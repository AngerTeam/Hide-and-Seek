using System.IO;
using UnityEngine;

namespace CraftyEngine.Infrastructure.FileSystem
{
	public class LoadFileLocalTask : LoadFileTask
	{
		private AssetBundleCreateRequest request_;

		private WWW www_;

		public LoadFileLocalTask(string path, FileType type, int layer)
			: base(layer)
		{
			base.File = new FileHolder(type);
			base.Address = path;
			Init();
		}

		public override void Unload()
		{
			if (request_ != null && request_.assetBundle != null)
			{
				request_.assetBundle.Unload(true);
			}
			if (www_ != null && www_.assetBundle != null)
			{
				www_.assetBundle.Unload(true);
			}
			Unsubscribe();
		}

		public override void ReSubscribe()
		{
			if (!TryLoadSync())
			{
				base.ReSubscribe();
			}
		}

		public bool TryLoadSync()
		{
			byte[] bytes;
			if (TryLoadSync(out bytes))
			{
				base.State = LoadState.Loaded;
				if (base.File.saveBytes && bytes != null)
				{
					base.File.loadedBytes = bytes;
				}
				Complete();
				return true;
			}
			return false;
		}

		public bool TryLoadSync(out byte[] bytes)
		{
			bytes = null;
			switch (base.File.Type)
			{
			case FileType.Bytes:
				bytes = LoadBytes();
				base.File.loadedBytes = bytes;
				return true;
			case FileType.Texture:
				bytes = LoadBytes();
				base.File.loadedTexture = new Texture2D(2, 2);
				base.File.loadedTexture.LoadImage(bytes);
				return true;
			case FileType.AmfObject:
				bytes = LoadBytes();
				base.File.loadedAmfObject = AmfHelper.ReadObject(bytes);
				return true;
			case FileType.AmfArray:
				bytes = LoadBytes();
				base.File.loadedAmfArray = AmfHelper.ReadArray(bytes);
				return true;
			case FileType.Text:
				base.File.loadedText = System.IO.File.ReadAllText(base.Address);
				return true;
			default:
				return false;
			}
		}

		public override void Start()
		{
			if (base.State == LoadState.Errored || base.State == LoadState.Loaded)
			{
				Complete();
			}
			else if (base.State == LoadState.Stopped || base.State == LoadState.Loading)
			{
				ReSubscribe();
			}
			else
			{
				if (TryLoadSync())
				{
					return;
				}
				switch (base.File.Type)
				{
				case FileType.UncompressedBundle:
				case FileType.Bundle:
					if (Application.isPlaying)
					{
						SubscribeToUnityUpdate();
						request_ = AssetBundle.LoadFromFileAsync(base.Address);
					}
					else
					{
						base.File.loadedAssetBundle = AssetBundle.LoadFromFile(base.Address);
						base.State = LoadState.Loaded;
						Complete();
					}
					break;
				case FileType.Audio:
					SubscribeToUnityUpdate();
					www_ = new WWW("file:///" + base.Address);
					break;
				default:
					Log.Error("Unsupported file type {0} for {1}", base.File.Type, base.Address);
					CompleteWithError("Unsupported file type");
					break;
				}
				base.Start();
			}
		}

		private byte[] LoadBytes()
		{
			return System.IO.File.ReadAllBytes(base.Address);
		}

		public override void UnityUpdate()
		{
			if (base.File.Type == FileType.Audio)
			{
				if (www_ == null || !www_.isDone)
				{
					return;
				}
				Unsubscribe();
				base.State = LoadState.Loaded;
				if (string.IsNullOrEmpty(www_.error))
				{
					AssetBundle assetBundle = www_.assetBundle;
					if (assetBundle != null)
					{
						base.File.loadedAssetBundle = assetBundle;
					}
					base.File.audioClip = www_.audioClip;
				}
				else
				{
					base.State = LoadState.Errored;
					base.ErrorMessage = www_.error;
				}
				Complete();
			}
			else if (request_ != null)
			{
				if (request_.isDone)
				{
					Unsubscribe();
					base.State = LoadState.Loaded;
					AssetBundle assetBundle2 = request_.assetBundle;
					if (assetBundle2 != null)
					{
						base.File.loadedAssetBundle = assetBundle2;
					}
					Complete();
				}
			}
			else
			{
				Log.Error("Unable to load {0} by {1}: request is null", base.Address, "LoadFileLocalTask");
				Unsubscribe();
			}
		}
	}
}
