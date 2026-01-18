using ArticulViewModule;
using CraftyEngine.Infrastructure.FileSystem;
using CraftyEngine.Utils.Unity;
using InventoryModule;
using PlayerModule.Playmate;
using UnityEngine;

namespace HideAndSeek
{
	public class VoxelBodyView : BodyView
	{
		private ArtikulItemView artikulItemView_;

		private Transform anchorTransform_;

		private Renderer skinRenderer_;

		private int currendArtikul_;

		public VoxelBodyView()
			: base("PlayerVoxelFrame", HideAndSeekContentMap.HideSeekSettings.ANIMATIONS_ID_HIDEVOXEL)
		{
		}

		public override void Init()
		{
			model.visual.NicknameAnchorHeight = 1.1f;
			anchorTransform_ = hierarchy.transform;
			InitAsc();
		}

		public override void Dispose()
		{
			if (artikulItemView_ != null)
			{
				artikulItemView_.Dispose();
				artikulItemView_ = null;
			}
			model.hideAndSeek.SelectedHideVoxelChanged -= HandleSelectedArtikulChanged;
			base.Dispose();
		}

		public override void UpdateSetSelectedArtikul()
		{
			RenderVoxel();
		}

		protected override FileHolder GetBodyBundle()
		{
			return GetBodyBundle(HideAndSeekContentMap.HideSeekSettings.HIDE_SKIN);
		}

		protected override void OnSkinApplyied()
		{
			GameObject gameObject = GameObjectUtils.FindChild(base.gameObject, "VoxelAnchor");
			if (gameObject != null)
			{
				anchorTransform_ = gameObject.transform;
				hierarchy.headCollider.transform.SetParent(anchorTransform_, false);
				hierarchy.headCollider.transform.localPosition = Vector3.zero;
				hierarchy.headCollider.transform.localEulerAngles = Vector3.zero;
			}
			RenderVoxel();
			skinRenderer_ = base.gameObject.GetComponentInChildren<Renderer>();
			model.hideAndSeek.SelectedHideVoxelChanged += HandleSelectedArtikulChanged;
		}

		private void HandleSelectedArtikulChanged()
		{
			RenderVoxel();
		}

		private void RenderVoxel()
		{
			if (currendArtikul_ != model.hideAndSeek.ArtikulId)
			{
				currendArtikul_ = model.hideAndSeek.ArtikulId;
				if (artikulItemView_ != null)
				{
					artikulItemView_.Dispose();
					artikulItemView_ = null;
				}
				float offsetY = 0f;
				float scale = 1f;
				ArtikulsEntries value;
				if (InventoryContentMap.Artikuls.TryGetValue(model.hideAndSeek.ArtikulId, out value))
				{
					artikulItemView_ = new ArtikulItemView(anchorTransform_.transform, value, offsetY, scale);
					artikulItemView_.View.RenderCompleted += HandleRenderCompleted;
					GameObjectUtils.SetLayerRecursive(artikulItemView_.Container.gameObject, hierarchy.gameObject.layer);
				}
			}
		}

		private void HandleRenderCompleted()
		{
			Renderer componentInChildren = artikulItemView_.View.Container.GetComponentInChildren<Renderer>();
			model.visual.bodyMaterial = ((componentInChildren == null) ? new Material[1] { skinRenderer_.sharedMaterial } : new Material[2]
			{
				skinRenderer_.sharedMaterial,
				CreateMaterial(componentInChildren.sharedMaterial)
			});
		}
	}
}
