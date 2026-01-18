using Animations;
using ArticulView;
using ArticulViewModule;
using CraftyEngine.Utils.Unity;
using UnityEngine;

namespace PlayerModule.Playmate
{
	public class PlayerItemView : AnimatedItemView
	{
		private GameObject container_;

		private ArtikulModelsEntries currentArtikulModel_;

		private bool isTool_;

		private Transform rightWeaponAnchor_;

		private GameObject shootOrientationContainer_;

		public ToolArticulView toolView_;

		public ArtikulItemView ArticulItemView { get; private set; }

		public PlayerItemView()
		{
			type = AnimationType.ThirdPersonItem;
			container_ = new GameObject("RightHandHolder");
			shootOrientationContainer_ = new GameObject("ShootOrientation");
			shootOrientationContainer_.transform.SetParent(container_.transform, false);
			InitAsc();
			base.AnimationsLoaded += HandleAnimationsLoaded;
		}

		private void HandleAnimationsLoaded()
		{
			SetOffset();
		}

		public override void Dispose()
		{
			if (ArticulItemView != null)
			{
				ArticulItemView.Dispose();
			}
			if (container_ != null)
			{
				Object.Destroy(container_);
			}
			base.Dispose();
		}

		public void Load()
		{
			if (selectedArtikul == null)
			{
				return;
			}
			ArticulViewContentMap.ArtikulModels.TryGetValue(selectedArtikul.model_id, out currentArtikulModel_);
			float offsetY = 0f;
			float scale = 0.35f;
			if (ArticulItemView != null)
			{
				ArticulItemView.Dispose();
			}
			if (!selectedArtikul.isHand)
			{
				ArticulItemView = new ArtikulItemView(shootOrientationContainer_.transform, selectedArtikul, offsetY, scale, true);
				toolView_ = ArticulItemView.View as ToolArticulView;
				isTool_ = toolView_ != null;
				if (isTool_)
				{
					toolView_.persId = selectedArtikul.title;
				}
				SetOffset();
				GameObjectUtils.SetLayerRecursive(ArticulItemView.Container.gameObject, container_.layer);
				if (ArticulItemView.View.Rendered)
				{
					HandleRenderCompleted();
				}
				else
				{
					ArticulItemView.View.RenderCompleted += HandleRenderCompleted;
				}
			}
		}

		private void HandleRenderCompleted()
		{
			LoadAnimations();
		}

		public void LoadAnimations()
		{
			if (ArticulItemView != null && ArticulItemView.View != null)
			{
				LoadAnimations(ArticulItemView.View.Instance);
			}
		}

		public void SetBody(Transform body)
		{
			Transform transform = GameObjectUtils.FindChild(body, "player");
			rightWeaponAnchor_ = GameObjectUtils.FindChild(body, "rightWeaponAnchor");
			if (rightWeaponAnchor_ == null)
			{
				GameObject gameObject = new GameObject("rightWeaponAnchor");
				rightWeaponAnchor_ = gameObject.transform;
				if (transform != null)
				{
					rightWeaponAnchor_.SetParent(transform, false);
				}
				else
				{
					rightWeaponAnchor_.SetParent(body, true);
				}
			}
			container_.transform.SetParent(rightWeaponAnchor_, false);
			container_.transform.localScale = Vector3.one;
			container_.transform.localPosition = Vector3.zero;
			container_.transform.localRotation = Quaternion.identity;
			SetOffset();
		}

		public void SetVisible(bool visible)
		{
			if (container_ != null)
			{
				container_.SetActive(visible);
			}
		}

		internal void Update(bool attakInProgress, Vector3 rotation)
		{
			if (toolView_ != null)
			{
				toolView_.orientation = rotation;
				if (toolView_.IsRangedWeapon)
				{
					float z = ((!attakInProgress) ? 0f : rotation.x);
					shootOrientationContainer_.transform.localEulerAngles = new Vector3(0f, 0f, z);
				}
			}
		}

		private void SetOffset()
		{
			if (isTool_ && currentArtikulModel_ != null && toolView_ != null && toolView_.Container != null)
			{
				Vector3 localPosition = Vector3Utils.SafeParse(currentArtikulModel_.offset_third_person);
				toolView_.Container.transform.localPosition = localPosition;
			}
		}
	}
}
