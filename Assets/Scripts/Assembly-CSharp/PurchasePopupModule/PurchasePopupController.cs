using ArticulView;
using BankModule;
using ChestsViewModule;
using CraftyEngine.Sounds;
using InventoryModule;
using NguiTools;
using PlayerModule;
using UnityEngine;

namespace PurchasePopupModule
{
	public class PurchasePopupController : Singleton
	{
		private PurchasePopupWindowHierarchy hierarchy_;

		private PrefabsManagerNGUI prefabsManager_;

		private BroadPurchaseOnline broadPurchseOnline_;

		private NguiFileManager nguiFileManager_;

		private NguiManager nguiManager_;

		private UI3DViewTexture view3D_;

		private VoxelArticulView viewVoxel_;

		private GameObject viewObject_;

		private bool isAnimation_;

		private bool isPaused_;

		public override void OnSyncRecieved()
		{
			base.OnSyncRecieved();
			SingletonManager.Get<PrefabsManagerNGUI>(out prefabsManager_);
			SingletonManager.Get<BroadPurchaseOnline>(out broadPurchseOnline_);
			SingletonManager.Get<NguiFileManager>(out nguiFileManager_);
			SingletonManager.Get<NguiManager>(out nguiManager_);
			prefabsManager_.Load("PurchasePopupModule");
			if (!(hierarchy_ != null))
			{
				hierarchy_ = prefabsManager_.InstantiateNGUIIn<PurchasePopupWindowHierarchy>("UIPurchasePopupWindow", nguiManager_.UiRoot.gameObject);
				hierarchy_.Init();
				broadPurchseOnline_.PurchaseItemsUpdated += HandlePurchaseItemsUpdated;
				hierarchy_.AnimationComplete += HandleAnimationComplete;
			}
		}

		public override void Dispose()
		{
			base.Dispose();
			if (view3D_ != null)
			{
				view3D_.Dispose();
			}
			if (viewVoxel_ != null)
			{
				viewVoxel_.Dispose();
			}
			if (viewObject_ != null)
			{
				Object.Destroy(viewObject_);
			}
			broadPurchseOnline_.PurchaseItemsUpdated -= HandlePurchaseItemsUpdated;
			hierarchy_.AnimationComplete -= HandleAnimationComplete;
			Object.Destroy(hierarchy_.gameObject);
		}

		public void Pause()
		{
			isPaused_ = true;
		}

		public void Resume()
		{
			isPaused_ = false;
		}

		public void Show(bool immediately)
		{
			if ((!immediately && isAnimation_) || isPaused_ || broadPurchseOnline_ == null || broadPurchseOnline_.PurchaseItems == null || broadPurchseOnline_.PurchaseItems.Count == 0)
			{
				return;
			}
			PurchaseItem purchaseItem = broadPurchseOnline_.PurchaseItems.Dequeue();
			if (purchaseItem == null)
			{
				return;
			}
			switch (purchaseItem.type)
			{
			case PurchaseItemType.Money:
			{
				ArtikulsEntries value2;
				if (InventoryContentMap.Artikuls.TryGetValue(InventoryContentMap.CraftSettings.CRYSTAL_ARTIKUL_ID, out value2))
				{
					string fullLargeIconPath2 = value2.GetFullLargeIconPath();
					nguiFileManager_.SetUiTexture(hierarchy_.IconArtikulTexture, fullLargeIconPath2);
					hierarchy_.IconArtikulTexture.gameObject.SetActive(true);
					hierarchy_.IconArtikulSprite.gameObject.SetActive(false);
					hierarchy_.IconSkinTexture.gameObject.SetActive(false);
					hierarchy_.Icon3DTexture.gameObject.SetActive(false);
					hierarchy_.DescriptionLabel.text = Localisations.Get("UI_Message_Buy_Money");
				}
				break;
			}
			case PurchaseItemType.Skin:
			{
				SkinsEntries value3;
				if (ArticulViewContentMap.Skins.TryGetValue(purchaseItem.id, out value3))
				{
					string fullPreviewPicturePath = value3.GetFullPreviewPicturePath();
					nguiFileManager_.SetUiTexture(hierarchy_.IconSkinTexture, fullPreviewPicturePath);
					hierarchy_.IconArtikulTexture.gameObject.SetActive(false);
					hierarchy_.IconArtikulSprite.gameObject.SetActive(false);
					hierarchy_.IconSkinTexture.gameObject.SetActive(true);
					hierarchy_.Icon3DTexture.gameObject.SetActive(false);
					hierarchy_.DescriptionLabel.text = Localisations.Get("UI_Message_Buy_Skin");
				}
				break;
			}
			case PurchaseItemType.Artikul:
			{
				ArtikulsEntries value4;
				if (InventoryContentMap.Artikuls.TryGetValue(purchaseItem.id, out value4))
				{
					if (!string.IsNullOrEmpty(value4.large_icon))
					{
						string fullLargeIconPath3 = value4.GetFullLargeIconPath();
						nguiFileManager_.SetUiTexture(hierarchy_.IconArtikulTexture, fullLargeIconPath3);
						hierarchy_.IconArtikulTexture.gameObject.SetActive(true);
						hierarchy_.IconArtikulSprite.gameObject.SetActive(false);
						hierarchy_.IconSkinTexture.gameObject.SetActive(false);
						hierarchy_.Icon3DTexture.gameObject.SetActive(false);
					}
					else
					{
						nguiManager_.SetIconSprite(hierarchy_.IconArtikulSprite, value4.id.ToString());
						hierarchy_.IconArtikulTexture.gameObject.SetActive(false);
						hierarchy_.IconArtikulSprite.gameObject.SetActive(true);
						hierarchy_.IconSkinTexture.gameObject.SetActive(false);
						hierarchy_.Icon3DTexture.gameObject.SetActive(false);
					}
					hierarchy_.DescriptionLabel.text = Localisations.Get("UI_Message_Buy_Artikul");
				}
				break;
			}
			case PurchaseItemType.Voxel:
				if (viewObject_ != null)
				{
					Object.Destroy(viewObject_);
				}
				if (viewVoxel_ != null)
				{
					viewVoxel_.Dispose();
				}
				viewObject_ = new GameObject("[Voxel]");
				viewObject_.transform.position = Vector3.zero;
				viewVoxel_ = new VoxelArticulView();
				viewVoxel_.RenderVoxel(viewObject_.transform, (ushort)purchaseItem.id, "[Voxel]");
				viewVoxel_.RenderCompleted += HandleRenderCompleted;
				hierarchy_.IconArtikulTexture.gameObject.SetActive(false);
				hierarchy_.IconArtikulSprite.gameObject.SetActive(false);
				hierarchy_.IconSkinTexture.gameObject.SetActive(false);
				hierarchy_.Icon3DTexture.gameObject.SetActive(true);
				hierarchy_.DescriptionLabel.text = Localisations.Get("UI_Message_Buy_Voxel");
				break;
			case PurchaseItemType.Multi:
			{
				ArtikulsEntries value;
				if (InventoryContentMap.Artikuls.TryGetValue(InventoryContentMap.CraftSettings.MORE_ITEMS_ARTIKUL_ID, out value))
				{
					if (string.IsNullOrEmpty(value.large_icon))
					{
						hierarchy_.IconArtikulTexture.mainTexture = null;
					}
					else
					{
						string fullLargeIconPath = value.GetFullLargeIconPath();
						nguiFileManager_.SetUiTexture(hierarchy_.IconArtikulTexture, fullLargeIconPath);
					}
					hierarchy_.IconArtikulTexture.gameObject.SetActive(true);
					hierarchy_.IconArtikulSprite.gameObject.SetActive(false);
					hierarchy_.IconSkinTexture.gameObject.SetActive(false);
					hierarchy_.Icon3DTexture.gameObject.SetActive(false);
					hierarchy_.DescriptionLabel.text = Localisations.Get("UI_Message_Buy_Many");
				}
				break;
			}
			}
			if (purchaseItem.gift)
			{
				hierarchy_.DescriptionLabel.text = Localisations.Get("UI_Message_Buy_Gift");
			}
			isAnimation_ = true;
			SoundProvider.PlaySingleSound2D(70);
			hierarchy_.Show();
		}

		private void HandlePurchaseItemsUpdated()
		{
			Show(true);
		}

		private void HandleRenderCompleted()
		{
			viewVoxel_.RenderCompleted -= HandleRenderCompleted;
			if (view3D_ != null)
			{
				view3D_.Dispose();
			}
			view3D_ = new UI3DViewTexture(viewObject_, 1f);
			view3D_.SetParent(hierarchy_.Icon3DTexture.transform, true);
			view3D_.SwitchActive(true);
		}

		private void HandleAnimationComplete()
		{
			isAnimation_ = false;
			Show(false);
		}
	}
}
