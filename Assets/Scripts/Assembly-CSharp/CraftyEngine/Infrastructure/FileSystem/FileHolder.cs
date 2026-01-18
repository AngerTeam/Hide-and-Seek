using System;
using CraftyEngine.Utils;
using CraftyEngine.Utils.Unity;
using Interlace.Amf;
using UnityEngine;

namespace CraftyEngine.Infrastructure.FileSystem
{
	public class FileHolder : IDisposable
	{
		public LoadFileTask fileGetter;

		public Texture2D loadedTexture;

		public byte[] loadedBytes;

		public byte[] bytesForCache;

		public AssetBundle loadedAssetBundle;

		public AmfObject loadedAmfObject;

		public AmfArray loadedAmfArray;

		public string loadedText;

		public AudioClip audioClip;

		public UnityEngine.Object bundle;

		public bool saveBytes;

		public string meta;

		public FileType Type { get; private set; }

		public FileHolder(FileType type)
		{
			Type = type;
		}

		public T GetBundle<T>() where T : UnityEngine.Object
		{
			return (T)GetBundle();
		}

		public UnityEngine.Object GetBundle()
		{
			if (bundle != null)
			{
				return bundle;
			}
			if (loadedAssetBundle == null)
			{
				return null;
			}
			string[] allAssetNames = loadedAssetBundle.GetAllAssetNames();
			if (allAssetNames.Length >= 1)
			{
				bundle = loadedAssetBundle.LoadAsset(allAssetNames[0]);
			}
			else
			{
				if (loadedAssetBundle.mainAsset == null)
				{
					Log.ArtError("Unable to determinate correct asset in {1}:\n{0}", ArrayUtils.ArrayToString(loadedAssetBundle.GetAllAssetNames(), "\n"), fileGetter.Address);
				}
				bundle = loadedAssetBundle.mainAsset;
			}
			return bundle;
		}

		public UnityEngine.Object Instantiate()
		{
			if (EnumUtils.Contains(FileType.IsBundle, Type) && fileGetter != null && fileGetter.State == LoadState.Loaded)
			{
				UnityEngine.Object @object = GetBundle();
				if (@object == null)
				{
					Log.ContentError("Asset bundle {0} is corrupted ot missing", fileGetter.Address);
					return null;
				}
				UnityEngine.Object object2 = UnityEngine.Object.Instantiate(@object);
				GameObject gameObject = object2 as GameObject;
				if (gameObject != null)
				{
					GameObjectUtils.ReassignShaders(gameObject);
				}
				return object2;
			}
			throw new Exception("Instantiatoin called for wrong or not yet loaded file!");
		}

		public void Dispose()
		{
			if (loadedTexture != null)
			{
				UnityEngine.Object.Destroy(loadedTexture);
			}
			if (audioClip != null)
			{
				UnityEngine.Object.Destroy(audioClip);
			}
			if (loadedAssetBundle != null)
			{
				loadedAssetBundle.Unload(true);
			}
			fileGetter.Unload();
		}
	}
}
