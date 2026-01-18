using ArticulViewModule;
using CraftyBundles;
using CraftyEngine.Infrastructure.FileSystem;
using CraftyEngine.Utils.Unity;
using FxModule;
using InventoryModule;
using UnityEngine;

namespace PlayerModule
{
	public class ToolArticulView : ArticulViewBase
	{
		public Vector3 orientation;

		private LoadArtikulModelManager loadArtikulModelManager_;

		private FileHolder modelFileHolder_;

		private Transform projectileOrientation_;

		public GameObject prefab;

		public bool hideOnRender;

		public ArtikulsEntries Articul { get; private set; }

		public FxView FxView { get; private set; }

		public override bool IsBillboard
		{
			get
			{
				return false;
			}
		}

		public bool IsRangedWeapon { get; private set; }

		public void SendProjectile(ProjectileModel model)
		{
			if (FxView.HasProjectile)
			{
				ProjectileTargetType targetType = model.targetType;
				if (targetType == ProjectileTargetType.Item)
				{
					projectileOrientation_.eulerAngles = orientation;
					model.target = projectileOrientation_.position + projectileOrientation_.forward * 50f;
				}
				FxView.SendProjectile(model);
			}
		}

		public void SendProjectile(Vector3[] trajectory, int clientProjectileId)
		{
			if (FxView.HasProjectile)
			{
				FxView.SendProjectile(trajectory, clientProjectileId);
			}
		}

		public override void Render(Transform parent, int articulId)
		{
			IsRangedWeapon = false;
			base.Container = new GameObject("Instrument Container");
			base.Container.transform.SetParent(parent, false);
			if (prefab != null)
			{
				base.Instance = Object.Instantiate(prefab);
				base.Instance.transform.SetParent(base.Container.transform, false);
				GameObjectUtils.SetLayer(base.Instance, parent.gameObject.layer);
				Articul = new ArtikulsEntries();
				Articul.cooldown = 0.3f;
				base.Instance.transform.localPosition = new Vector3(0.245f, 0.3f, -0.3f);
				ReportRendered();
				return;
			}
			ArtikulsEntries value;
			if (InventoryContentMap.Artikuls.TryGetValue(articulId, out value))
			{
				Articul = value;
				SingletonManager.Get<LoadArtikulModelManager>(out loadArtikulModelManager_);
				IsRangedWeapon = Articul.ranged;
				int model_id = Articul.model_id;
				if (model_id > 0)
				{
					loadArtikulModelManager_.GetModel(out modelFileHolder_, model_id, UpdateModel);
					return;
				}
			}
			Log.Error("Unable to get Instrument model for artijul {0}", articulId);
		}

		private void UpdateModel()
		{
			if (modelFileHolder_ == null || !(base.Container != null))
			{
				return;
			}
			GameObject result;
			if (RenderHierarchyUtils.TryInstansiate(modelFileHolder_.loadedAssetBundle, out result))
			{
				base.Instance = result;
			}
			else
			{
				prefab = (GameObject)modelFileHolder_.GetBundle();
				if (prefab == null)
				{
					return;
				}
				base.Instance = Object.Instantiate(prefab);
			}
			base.Instance = HandleHierarchy(base.Instance, true, isPlayer);
			GameObjectUtils.SetLayerRecursive(base.Instance, base.Container.layer);
			if (hideOnRender)
			{
				base.Instance.gameObject.SetActive(false);
			}
			GameObject gameObject = new GameObject("projectileOrientation_");
			projectileOrientation_ = gameObject.transform;
			gameObject.transform.SetParent(base.Instance.transform, false);
			FxView = new FxView(base.Instance, Articul.projectile, Articul.FxEntries, Articul.ProjectileEntry, Articul.cooldown);
			FxView.bloodVoxelAtikulId = FxContentMap.FxSettings.BLOOD_ARTIKUL_ID;
			ReportRendered();
		}
	}
}
