using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using HudSystem;
using NguiTools;
using UnityEngine;

namespace WeaponSightsModule
{
	public class AimScopeHud : HeadUpDisplay
	{
		private readonly AimScopeHierarchy aimScope_;

		private readonly NguiFileManager nguiFileManager_;

		private Texture aimScopeTexture_;

		public AimScopeHud()
		{
			SingletonManager.TryGet<NguiFileManager>(out nguiFileManager_);
			prefabsManager.Load("WeaponSightsPrefabsHolder");
			aimScope_ = prefabsManager.InstantiateNGUIIn<AimScopeHierarchy>("UIAimScope", nguiManager.UiRoot.gameObject);
			aimScope_.panel.depth = -1;
			aimScope_.texture.enabled = false;
			hudStateSwitcher.Register(1, aimScope_.texture);
		}

		public override void Dispose()
		{
			Object.Destroy(aimScope_);
		}

		public override void Resubscribe()
		{
			aimScope_.texture.gameObject.SetActive(false);
		}

		public void SetScopeIcon(string icon)
		{
			if (!string.IsNullOrEmpty(icon))
			{
				aimScope_.texture.mainTexture = null;
				FileHolder fileHolder = nguiFileManager_.SetUiTexture(aimScope_.texture, icon);
				aimScope_.texture.enabled = true;
				QueueManager queueManager = SingletonManager.Get<QueueManager>();
				queueManager.AddTask(fileHolder.fileGetter);
				queueManager.AddTask(delegate
				{
					if (fileHolder.loadedTexture != null)
					{
						fileHolder.loadedTexture.filterMode = FilterMode.Point;
					}
				});
			}
			else
			{
				aimScope_.texture.enabled = false;
			}
		}

		public void SetScopeLegacyIcon(bool aiming)
		{
			if (aiming)
			{
				aimScope_.texture.mainTexture = aimScopeTexture_ ?? (aimScopeTexture_ = Resources.Load<Texture>("aim_scope"));
			}
			aimScope_.texture.enabled = aiming;
		}
	}
}
