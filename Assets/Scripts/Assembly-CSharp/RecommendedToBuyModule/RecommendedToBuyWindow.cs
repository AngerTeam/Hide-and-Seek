using System;
using System.Collections.Generic;
using CraftyEngine.Content;
using CraftyGameEngine.Gui;
using CraftyMultiplayerEngine;
using Extensions;
using HudSystem;
using InventoryModule;
using NguiTools;
using ShopModule;
using UnityEngine;
using WindowsModule;

namespace RecommendedToBuyModule
{
	public class RecommendedToBuyWindow : GameWindow
	{
		private const int ITEMS_COUNT = 4;

		private Action playAction_;

		private NguiManager nguiManager_;

		private InvetnoryController invetnoryController_;

		private RecommendedToBuyWindowHierarchy hierarchy_;

		private RecommendedItemHierarchy[] recommendedItems_;

		private WeaponDescriptionWidget weaponDescription_;

		public Transform MapInfoContainer
		{
			get
			{
				return hierarchy_.MapInfoContainer.transform;
			}
		}

		public RecommendedToBuyWindow()
			: base(false, false)
		{
			base.HudState = 8352;
			SingletonManager.Get<NguiManager>(out nguiManager_);
			SingletonManager.Get<InvetnoryController>(out invetnoryController_);
			prefabsManager.Load("RecommendedToBuyModule");
			prefabsManager.Load("KillCamPrefabHolder");
			hierarchy_ = prefabsManager.InstantiateIn<RecommendedToBuyWindowHierarchy>("UIRecommendedToBuyWindow", nguiManager_.UiRoot.transform);
			recommendedItems_ = new RecommendedItemHierarchy[4];
			for (int i = 0; i < 4; i++)
			{
				RecommendedItemHierarchy recommendedItemHierarchy = prefabsManager.InstantiateIn<RecommendedItemHierarchy>("UIRecommendedItem", hierarchy_.ContentsGrid.transform);
				recommendedItems_[i] = recommendedItemHierarchy;
			}
			weaponDescription_ = new WeaponDescriptionWidget(hierarchy_.DescriptionContainer.transform, true);
			SetContent(hierarchy_.transform, true, true, false, false, true);
			hierarchy_.TitleLabel.text = Localisations.Get("UI_RecommendedToBuy_WindowTitle");
			hierarchy_.PlayButtonLabel.text = Localisations.Get("UI_Play");
			ButtonSet.Up(hierarchy_.PlayButton, PlayAction, ButtonSetGroup.InWindow);
			ButtonSet.Up(hierarchy_.CloseButton, CloseWindow, ButtonSetGroup.InWindow);
		}

		private void CloseWindow()
		{
			if (Visible)
			{
				windowsManager.ToggleWindow(this);
			}
		}

		public static void GetRecommendedItems(int playerLevel, out List<ShopItemsEntries> recommendedEntries)
		{
			List<int> list = null;
			int currentModeId = DataStorage.currentModeId;
			if (currentModeId != 0)
			{
				list = new List<int>();
				ContentDeserializer.Deserialize<RecommendedToBuyModuleContentMap>();
				if (RecommendedToBuyModuleContentMap.ShopItemForModes != null)
				{
					foreach (ShopItemForModesEntries value in RecommendedToBuyModuleContentMap.ShopItemForModes.Values)
					{
						if (currentModeId == value.pvp_mode_id)
						{
							list.Add(value.shop_item_id);
						}
					}
				}
			}
			IShop shop = GuiModuleHolder.Get<IShop>();
			shop.GetRecommendedItems(playerLevel, 4, out recommendedEntries, list);
		}

		public void OpenWindow(int playerLevel, Action playAction)
		{
			List<ShopItemsEntries> recommendedEntries;
			GetRecommendedItems(playerLevel, out recommendedEntries);
			if (recommendedEntries.Count == 0)
			{
				playAction.SafeInvoke();
				return;
			}
			for (int i = 0; i < 4; i++)
			{
				RecommendedItemHierarchy itemPrefab = recommendedItems_[i];
				itemPrefab.gameObject.SetActive(recommendedEntries.Count > i);
				if (recommendedEntries.Count > i)
				{
					ShopItemsEntries recommendedEntry = recommendedEntries[i];
					itemPrefab.itemName.text = recommendedEntry.title;
					itemPrefab.price.text = recommendedEntry.money_cnt.ToString();
					invetnoryController_.SetLargeIcon(itemPrefab.sprite, recommendedEntry.artikulId, itemPrefab.spriteBack);
					ButtonSet.Up(itemPrefab.button, delegate
					{
						SelectItem(recommendedEntry, itemPrefab);
					}, ButtonSetGroup.Hud);
					ButtonSet.Up(itemPrefab.buyButton, delegate
					{
						Buy(recommendedEntry, itemPrefab.sprite);
					}, ButtonSetGroup.Hud);
					itemPrefab.buyLabel.text = Localisations.Get("UI_BuyShopItem");
				}
			}
			hierarchy_.ContentsGrid.repositionNow = true;
			UntoggleItems();
			weaponDescription_.SwitchDescription(false);
			weaponDescription_.ItemClear();
			weaponDescription_.SetMainDescription(Localisations.Get("UI_RecommendedToBuyWindow_Motivator"));
			if (!Visible)
			{
				windowsManager.ToggleWindow(this);
			}
			playAction_ = playAction;
		}

		private void UntoggleItems()
		{
			for (int i = 0; i < 4; i++)
			{
				RecommendedItemHierarchy recommendedItemHierarchy = recommendedItems_[i];
				recommendedItemHierarchy.selectionSprite.gameObject.SetActive(false);
			}
		}

		private void SelectItem(ShopItemsEntries entry, RecommendedItemHierarchy item)
		{
			UntoggleItems();
			item.selectionSprite.gameObject.SetActive(true);
			weaponDescription_.SwitchDescription(true);
			weaponDescription_.ItemSelect(entry);
		}

		private void Buy(ShopItemsEntries shopItem, UI2DSprite sprite)
		{
			NetworkShopManager singlton;
			SingletonManager.Get<NetworkShopManager>(out singlton);
			singlton.BuyArtikul(shopItem);
		}

		private void PlayAction()
		{
			CloseWindow();
			playAction_.SafeInvoke();
		}
	}
}
