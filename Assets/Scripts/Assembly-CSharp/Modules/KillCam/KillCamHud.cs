using System;
using System.Collections.Generic;
using CraftyEngine.Utils;
using Extensions;
using HudSystem;
using InventoryModule;
using RecommendedToBuyModule;
using ShopModule;
using UnityEngine;

namespace Modules.KillCam
{
	public class KillCamHud : HeadUpDisplay
	{
		private KillerWeaponDescriptionHierarchy killerWeaponDescription_;

		private RecommendedItemsHierarchy recommendedItems_;

		private RecommendedItemHierarchy recommendedItemHierarchy_;

		private YourKillerHierarchy yourKiller_;

		private MistScreenHierarchy blackMist_;

		private UnityTimerManager timerManager_;

		private InvetnoryController invetnoryController_;

		public event Action<ShopItemsEntries> BuyButtonPressed;

		public KillCamHud()
		{
			killerWeaponDescription_ = prefabsManager.InstantiateIn<KillerWeaponDescriptionHierarchy>("UIKillerWeaponDescription", nguiManager.UiRoot.KillerWeaponDescriptionContainer.transform);
			recommendedItems_ = prefabsManager.InstantiateIn<RecommendedItemsHierarchy>("UIRecommendedItems", nguiManager.UiRoot.RecommendedToBuyContainer.transform);
			recommendedItems_.ghostSprite.transform.position = nguiManager.UiRoot.BottomCenterLabel.transform.position;
			recommendedItemHierarchy_ = prefabsManager.InstantiateIn<RecommendedItemHierarchy>("UIRecommendedItem", recommendedItems_.itemHolder.transform);
			yourKiller_ = prefabsManager.InstantiateIn<YourKillerHierarchy>("UIYourKiller", nguiManager.UiRoot.YourKillerContainer.transform);
			blackMist_ = prefabsManager.InstantiateNGUIIn<MistScreenHierarchy>("UIBlackMistScreen", nguiManager.UiRoot.gameObject);
			blackMist_.widget.SetAnchor(nguiManager.UiRoot.gameObject, 0, 0, 0, 0);
			ButtonSet.Up(killerWeaponDescription_.widget, ButtonSetGroup.Hud);
			ButtonSet.Up(recommendedItems_.widget, ButtonSetGroup.Hud);
			ButtonSet.Up(yourKiller_.widget, ButtonSetGroup.Hud);
			ButtonSet.Up(blackMist_.widget, ButtonSetGroup.Hud);
			killerWeaponDescription_.description.text = Localisations.Get("UI_Enemy_Weapon");
			recommendedItems_.descriptionLabel.text = Localisations.Get("UI_Recommended");
			hudStateSwitcher.Register(1048576, killerWeaponDescription_);
			hudStateSwitcher.Register(1048576, recommendedItems_);
			hudStateSwitcher.Register(1048576, yourKiller_);
			hudStateSwitcher.Register(1048576, blackMist_);
		}

		public override void Resubscribe()
		{
			SingletonManager.Get<UnityTimerManager>(out timerManager_);
			SingletonManager.Get<InvetnoryController>(out invetnoryController_);
		}

		public void SetDetails(KillCamType killCamType, string killerNick, int killerLevel, int artikulId)
		{
			switch (killCamType)
			{
			case KillCamType.Empty:
				yourKiller_.description.gameObject.SetActive(false);
				yourKiller_.nicknameLabel.text = string.Empty;
				yourKiller_.levelLabel.text = string.Empty;
				break;
			case KillCamType.Suicide:
				yourKiller_.description.gameObject.SetActive(true);
				yourKiller_.description.text = Localisations.Get("UI_You_Crashed");
				yourKiller_.nicknameLabel.text = string.Empty;
				yourKiller_.levelLabel.text = string.Empty;
				break;
			default:
				yourKiller_.description.gameObject.SetActive(true);
				yourKiller_.description.text = string.Format("{0}:", Localisations.Get("UI_Your_Killer"));
				yourKiller_.nicknameLabel.text = killerNick;
				yourKiller_.levelLabel.text = string.Format("[{0}]", killerLevel);
				break;
			}
			killerWeaponDescription_.widget.gameObject.SetActive(killCamType == KillCamType.Killer);
			if (killCamType != KillCamType.Killer)
			{
				return;
			}
			ArtikulsEntries value;
			if (InventoryContentMap.Artikuls.TryGetValue(artikulId, out value))
			{
				if (!VersionUtil.Compare(DataStorage.version, value.client_version) || value.type_id != 4)
				{
					killerWeaponDescription_.itemTitle.text = InventoryContentMap.CraftSettings.handArtikul.title;
					SetLargeIcon(killerWeaponDescription_.itemIcon, killerWeaponDescription_.itemBack, 0);
				}
				else
				{
					killerWeaponDescription_.itemTitle.text = value.title;
					SetLargeIcon(killerWeaponDescription_.itemIcon, killerWeaponDescription_.itemBack, value.id);
				}
				killerWeaponDescription_.itemIcon.gameObject.SetActive(true);
			}
			else
			{
				killerWeaponDescription_.itemTitle.text = InventoryContentMap.CraftSettings.handArtikul.title;
				SetLargeIcon(killerWeaponDescription_.itemIcon, killerWeaponDescription_.itemBack, 0);
			}
		}

		public void DisableRecommended()
		{
			recommendedItems_.widget.gameObject.SetActive(false);
			yourKiller_.widget.transform.localPosition = new Vector3(0f, -350f, 0f);
		}

		public void SetRecommendedToBuy(int currentLevel)
		{
			yourKiller_.widget.transform.localPosition = new Vector3(0f, 0f, 0f);
			recommendedItems_.widget.gameObject.SetActive(true);
			List<ShopItemsEntries> recommendedEntries;
			RecommendedToBuyWindow.GetRecommendedItems(currentLevel, out recommendedEntries);
			if (recommendedEntries.Count > 0)
			{
				ShopItemsEntries recommendedEntry = recommendedEntries[UnityEngine.Random.Range(0, recommendedEntries.Count)];
				recommendedItemHierarchy_.itemName.text = recommendedEntry.title;
				recommendedItemHierarchy_.price.text = recommendedEntry.money_cnt.ToString();
				SetLargeIcon(recommendedItemHierarchy_.sprite, recommendedItemHierarchy_.spriteBack, recommendedEntry.artikulId);
				recommendedItemHierarchy_.buyLabel.text = Localisations.Get("UI_BuyShopItem");
				ButtonSet.Up(recommendedItemHierarchy_.buyButton, delegate
				{
					Buy(recommendedEntry, recommendedItemHierarchy_.sprite);
				}, ButtonSetGroup.Hud);
				recommendedItemHierarchy_.gameObject.SetActive(true);
				recommendedItemHierarchy_.button.enabled = false;
				UnityTimer unityTimer = timerManager_.SetTimer();
				unityTimer.Completeted += delegate
				{
					OnRecTimerCompleted(recommendedItemHierarchy_.button);
				};
			}
			else
			{
				recommendedItemHierarchy_.gameObject.SetActive(false);
			}
		}

		private void OnRecTimerCompleted(UIButton button)
		{
			button.enabled = true;
		}

		private void SetLargeIcon(UI2DSprite sprite, UISprite backSprite, int artikulId)
		{
			invetnoryController_.SetLargeIcon(sprite, artikulId, backSprite);
		}

		private void Buy(ShopItemsEntries shopItem, UI2DSprite sprite)
		{
			this.BuyButtonPressed.SafeInvoke(shopItem);
		}

		public override void Dispose()
		{
			this.BuyButtonPressed = null;
			UnityEngine.Object.Destroy(recommendedItemHierarchy_.gameObject);
			UnityEngine.Object.Destroy(killerWeaponDescription_.gameObject);
			UnityEngine.Object.Destroy(recommendedItems_.gameObject);
			UnityEngine.Object.Destroy(yourKiller_.gameObject);
			UnityEngine.Object.Destroy(blackMist_.gameObject);
		}
	}
}
