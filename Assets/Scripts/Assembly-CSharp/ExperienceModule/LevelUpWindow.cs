using System;
using System.Collections.Generic;
using CraftyGameEngine.Gui.Fx;
using Extensions;
using HudSystem;
using InventoryModule;
using NguiTools;
using ShopModule;
using UnityEngine;
using WindowsModule;

namespace ExperienceModule
{
	public class LevelUpWindow : GameWindow
	{
		private LevelUpWindowHierarchy hierarchy_;

		private NguiFileManager nguiFileManager_;

		private PrefabsManagerNGUI prefabsManager_;

		public event Action OkButtonClicked;

		public event Action<ShopItemsEntries> BonusItemClicked;

		public LevelUpWindow()
			: base(false, false)
		{
			SingletonManager.Get<PrefabsManagerNGUI>(out prefabsManager_);
			SingletonManager.Get<NguiFileManager>(out nguiFileManager_);
			prefabsManager_.Load("ExpiriencePrefabsHolder");
			hierarchy_ = prefabsManager_.InstantiateNGUIIn<LevelUpWindowHierarchy>("UILevelUpWindow", nguiManager.UiRoot.gameObject);
			hierarchy_.LevelInfoWidget.SetAnchor(nguiManager.UiRoot.gameObject, 0, 0, 0, 0);
			hierarchy_.ConfirmLevelButtonLabel.text = Localisations.Get("UI_Exp_Congratulations_Button_Text");
			hierarchy_.CongratulationsLabel.text = Localisations.Get("UI_Exp_Congratulations");
			hierarchy_.BonusTextLabel.text = Localisations.Get("UI_Exp_Congratulations_Gained_Bonus");
			SetContent(hierarchy_.transform, true, true, false, false, true);
			ButtonSet.Up(hierarchy_.ConfirmLevelButton, delegate
			{
				this.OkButtonClicked.SafeInvoke();
			}, ButtonSetGroup.InWindow);
			RayGlow rayGlow = new RayGlow();
			rayGlow.RandomizeRays();
			rayGlow.SetParent(hierarchy_.RaysWidget.transform);
		}

		public void SetLevelInfo(int newLevel, int bonusAmount)
		{
			hierarchy_.LevelIndexText.text = newLevel.ToString();
			hierarchy_.BonusAmountLabel.text = bonusAmount.ToString();
		}

		public void SetBonusItems(List<ShopItemsEntries> bonusList)
		{
			int num = ((bonusList != null) ? bonusList.Count : 0);
			hierarchy_.AvailableItemsTextLabel.text = ((num <= 0) ? Localisations.Get("UI_Exp_Congratulations_No_Available_Items") : Localisations.Get("UI_Exp_Congratulations_Available_Items"));
			if (num == 0)
			{
				hierarchy_.BonusItemElement.SetActive(false);
				return;
			}
			SetItemHandler(bonusList[0], hierarchy_.BonusItemElement.GetComponent<RewardItemHierarchy>());
			foreach (Transform item in hierarchy_.AvailableItemsRootGrid.transform)
			{
				if (item != hierarchy_.BonusItemElement.transform)
				{
					UnityEngine.Object.Destroy(item.gameObject);
				}
			}
			for (int i = 1; i < bonusList.Count; i++)
			{
				GameObject gameObject = (GameObject)UnityEngine.Object.Instantiate(hierarchy_.BonusItemElement, hierarchy_.AvailableItemsRootGrid.transform);
				SetItemHandler(bonusList[i], gameObject.GetComponent<RewardItemHierarchy>());
			}
			hierarchy_.AvailableItemsRootGrid.enabled = true;
		}

		private void SetItemHandler(ShopItemsEntries itemEntry, RewardItemHierarchy rewardItemHierarchy)
		{
			RarityEntries value;
			if (!InventoryContentMap.Rarity.TryGetValue(itemEntry.artikul.id, out value))
			{
				Log.Warning("Rarity not set for {0} artukul.", itemEntry.artikul.id);
				InventoryContentMap.Rarity.TryGetValue(InventoryContentMap.CraftSettings.default_rarity_id, out value);
			}
			rewardItemHierarchy.ItemBack.spriteName = value.background_sprite_name;
			rewardItemHierarchy.ItemText.text = itemEntry.artikul.title;
			nguiFileManager_.SetUiTexture(rewardItemHierarchy.ItemIcon, itemEntry.artikul.GetFullLargeIconPath());
			ButtonSet.Up(rewardItemHierarchy.ItemButton, delegate
			{
				this.BonusItemClicked.SafeInvoke(itemEntry);
			}, ButtonSetGroup.InWindow);
		}

		public override void Dispose()
		{
			base.Dispose();
			nguiManager = null;
			hierarchy_ = null;
			prefabsManager_ = null;
		}
	}
}
