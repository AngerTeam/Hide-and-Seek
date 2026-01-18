using System;
using UnityEngine;

namespace CraftyEngine.Infrastructure.FileSystem
{
	public class LoadFileWWWTask : LoadFileTask, IProgressable
	{
		private bool debuggerDelayHack = true;

		private float connectionDuration_ = 15f;

		public bool loadFromCache;

		public bool saveBytesForCache;

		private WWWForm form_;

		private bool disposed_;

		public WWW www { get; private set; }

		public float Progress { get; private set; }

		public override float Weight { get; set; }

		public event Action<float> Progressed;

		public LoadFileWWWTask(string url, FileType type, bool loadFromCache, int layer, bool saveBytesForCache = false, WWWForm form = null)
			: base(layer)
		{
			Weight = 1f;
			this.loadFromCache = loadFromCache;
			this.saveBytesForCache = saveBytesForCache;
			base.File = new FileHolder(type);
			base.Address = url;
			form_ = form;
			Init();
		}

		private void ReportProgress(float progress)
		{
			Progress = progress;
			if (this.Progressed != null)
			{
				this.Progressed(progress);
			}
		}

		public override void Start()
		{
			if (base.State == LoadState.Errored || base.State == LoadState.Loaded)
			{
				Complete();
				return;
			}
			if (base.State == LoadState.Stopped || base.State == LoadState.Loading)
			{
				ReSubscribe();
				return;
			}
			if (form_ == null)
			{
				www = new WWW(base.Address);
			}
			else
			{
				www = new WWW(base.Address, form_);
			}
			SubscribeToUnityUpdate();
			base.Start();
		}

		public override void UnityUpdate()
		{
			if (debuggerDelayHack)
			{
				debuggerDelayHack = false;
			}
			else
			{
				connectionDuration_ -= Time.unscaledDeltaTime;
			}
			if (disposed_ || www == null)
			{
				Unsubscribe();
				Log.Warning("loading {0} was interrupted", base.Address);
			}
			else if (www.progress.Equals(0f) && connectionDuration_ < 0f)
			{
				if (!silent)
				{
					Exc.Report(3109, null, base.Address);
				}
				Unsubscribe();
				Complete();
				Unload();
			}
			else if (www.isDone)
			{
				Unsubscribe();
				if (www.error != null)
				{
					base.State = LoadState.Errored;
					base.ErrorMessage = www.error;
					if (!silent)
					{
						Exc.Report(3110, base.Address, www.error);
					}
				}
				else
				{
					base.State = LoadState.Loaded;
					switch (base.File.Type)
					{
					case FileType.UncompressedBundle:
					case FileType.Bundle:
					{
						AssetBundle assetBundle = www.assetBundle;
						if (CompileConstants.EDITOR)
						{
							LoadFileTask.ReadVersion(www.bytes, base.Address);
						}
						if (assetBundle != null)
						{
							base.File.loadedAssetBundle = assetBundle;
						}
						break;
					}
					case FileType.Texture:
						base.File.loadedTexture = www.texture;
						break;
					case FileType.AmfObject:
						base.File.loadedAmfObject = AmfHelper.ReadObject(www.bytes);
						break;
					case FileType.AmfArray:
						base.File.loadedAmfArray = AmfHelper.ReadArray(www.bytes);
						break;
					case FileType.Bytes:
						base.File.loadedBytes = www.bytes;
						break;
					case FileType.Text:
						base.File.loadedText = www.text;
						break;
					case FileType.Audio:
						base.File.audioClip = www.audioClip;
						break;
					default:
						Log.Error("Unsupported file type {0}", base.File.Type);
						break;
					}
					if (saveBytesForCache)
					{
						base.File.bytesForCache = www.bytes;
					}
					if (base.File.saveBytes)
					{
						base.File.loadedBytes = www.bytes;
					}
				}
				ReportProgress(1f);
				Complete();
			}
			else
			{
				ReportProgress(www.progress);
			}
		}

		public override void Unload()
		{
			disposed_ = true;
			if (www != null)
			{
				www.Dispose();
			}
			www = null;
		}
	}
}
