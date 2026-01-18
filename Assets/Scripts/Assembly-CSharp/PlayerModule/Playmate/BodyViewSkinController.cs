using System;
using ArticulView;
using CraftyBundles;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using Extensions;
using UnityEngine;

namespace PlayerModule.Playmate
{
	public class BodyViewSkinController : IDisposable
	{
		public GameObject Instance { get; private set; }

		public bool SkinLoaded { get; private set; }

		public event Action Loaded;

		public FileHolder GetBodyBundle(int skinId)
		{
			SkinsEntries value;
			if (!ArticulViewContentMap.Skins.TryGetValue(skinId, out value))
			{
				int defaultSkinId = PlayerContentMap.PlayerEntity.defaultSkinId;
				if (!ArticulViewContentMap.Skins.TryGetValue(defaultSkinId, out value))
				{
					Log.Error("Unable to find skin!");
					return null;
				}
			}
			return LoadSkin(value.GetFullBundlePath());
		}

		public FileHolder LoadSkin(string file)
		{
			FilesManager singlton;
			SingletonManager.Get<FilesManager>(out singlton);
			return singlton.AddLoadBundleTask(file, Instansiate);
		}

		private void Instansiate(FileHolder holder)
		{
			GameObject instance;
			if (RenderHierarchyUtils.TryInstansiate(holder, out instance))
			{
				Instance = instance;
				UnityEvent.OnNextUpdate(ReportLoaded);
			}
		}

		private void ReportLoaded()
		{
			SkinLoaded = true;
			this.Loaded.SafeInvoke();
		}

		public void Dispose()
		{
			this.Loaded = null;
			if (Instance != null)
			{
				UnityEngine.Object.Destroy(Instance);
			}
		}
	}
}
