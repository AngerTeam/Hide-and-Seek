using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using CraftyGameEngine.Gui.Fx;
using ExperienceModule;
using HudSystem;
using InventoryModule;
using InventoryViewModule;
using NguiTools;
using UnityEngine;
using WindowsModule;

namespace SpecialOffersModule
{
	public class SpecialOfferWindow : GameWindow
	{
		private SpecialOfferWindowHierarchy hierarchy_;

		private CatalogLoader<RewardItem> catalog_;

		private PrefabsManagerNGUI prefabsManager_;

		private NguiFileManager nguiFileManager_;

		private SpecialOffersManager specialOffersManager_;

		private UnityTimerManager unityTimerManager_;

		private InvetnoryController invetnoryController_;

		private RayGlow rayGlow_;

		private List<RewardItemHierarchy> rewardItems_;

		private UnityTimer timer_;

		private bool inited_;

		public SpecialOfferWindow()
			: base(false)
		{
			SingletonManager.Get<InvetnoryController>(out invetnoryController_);
			SingletonManager.Get<PrefabsManagerNGUI>(out prefabsManager_);
			SingletonManager.Get<UnityTimerManager>(out unityTimerManager_);
			SingletonManager.Get<SpecialOffersManager>(out specialOffersManager_);
			prefabsManager_.Load("SpecialOffersPrefabsHolder");
			hierarchy_ = prefabsManager_.InstantiateNGUIIn<SpecialOfferWindowHierarchy>("UISpecialOfferWindow", nguiManager.UiRoot.gameObject);
			hierarchy_.Widget.SetAnchor(nguiManager.UiRoot.gameObject, 0, 0, 0, 0);
			hierarchy_.TimeLeftTitleLabel.text = Localisations.Get("UI_TimeLeft");
			hierarchy_.BuyButtonLabel.text = Localisations.Get("UI_BuyShopItem");
			ButtonSet.Up(hierarchy_.BuyButton, BuyOffer, ButtonSetGroup.InWindow);
			SetContent(hierarchy_.transform, true, true, false, false, true);
			rayGlow_ = new RayGlow();
			rayGlow_.RandomizeRays();
			rayGlow_.SetParent(hierarchy_.RaysWidget.transform);
			specialOffersManager_.ShowSpecialOffer += ShowOffer;
			specialOffersManager_.HideSpecialOffer += HideWindow;
			catalog_ = new CatalogLoader<RewardItem>(0);
			base.ViewChanged += HandleViewChanged;
		}

		private void HandleViewChanged(object sender, BoolEventArguments e)
		{
			if (Visible && specialOffersManager_.CurrentOffer != null && (!inited_ || specialOffersManager_.CurrentOffer.updated))
			{
				specialOffersManager_.CurrentOffer.updated = false;
				inited_ = true;
				InitOffer();
			}
			if (!inited_)
			{
				return;
			}
			if (Visible)
			{
				if (timer_ != null)
				{
					timer_.Completeted -= HandleTimer;
					timer_.Stop();
					timer_ = null;
				}
				timer_ = unityTimerManager_.SetTimer(1f, false);
				timer_.repeat = true;
				timer_.Completeted += HandleTimer;
				timer_.enable = true;
				HandleTimer();
				catalog_.Load();
			}
			else
			{
				timer_.Completeted -= HandleTimer;
				timer_.Stop();
				timer_ = null;
				catalog_.Unload();
			}
		}

		private void ShowOffer(bool showNow)
		{
			if (!Visible && showNow && specialOffersManager_.CurrentOffer != null)
			{
				windowsManager.ToggleWindow(this);
			}
		}

		private void InitOffer()
		{
			ClearOffer();
			hierarchy_.TitleLabel.text = specialOffersManager_.CurrentOffer.entry.title;
			hierarchy_.DescriptionLabel.text = specialOffersManager_.CurrentOffer.entry.description;
			SingletonManager.Get<NguiFileManager>(out nguiFileManager_);
			nguiFileManager_.SetUiTexture(hierarchy_.Texture, specialOffersManager_.CurrentOffer.entry.GetFullPicturePath());
			float num = 0f;
			float num2 = 0f;
			string text = string.Empty;
			if (specialOffersManager_.CurrentOffer.umInApp != null)
			{
				if (CompileConstants.IOS)
				{
					text = specialOffersManager_.CurrentOffer.umInApp.IOSTemplate.LocalizedPrice;
					num = specialOffersManager_.CurrentOffer.umInApp.IOSTemplate.Price;
				}
				else if (CompileConstants.ANDROID)
				{
					text = string.Format("{0} {1}", specialOffersManager_.CurrentOffer.umInApp.AndroidTemplate.Price, specialOffersManager_.CurrentOffer.umInApp.AndroidTemplate.PriceCurrencyCode);
					num = specialOffersManager_.CurrentOffer.umInApp.AndroidTemplate.Price;
				}
			}
			else
			{
				num = specialOffersManager_.CurrentOffer.entry.price;
				text = string.Format("{0} {1}", num, "$");
			}
			if (specialOffersManager_.CurrentOffer.entry.price_coef != 0f)
			{
				num2 = num * specialOffersManager_.CurrentOffer.entry.price_coef;
			}
			hierarchy_.PriceLabel.text = text;
			hierarchy_.OldPriceLabel.text = num2.ToString();
			prefabsManager_.Load("ExpiriencePrefabsHolder");
			rewardItems_ = new List<RewardItemHierarchy>();
			foreach (SpecialOfferItem offerItem in specialOffersManager_.CurrentOffer.offerItems)
			{
				AddBonusItem(offerItem);
			}
			hierarchy_.AvailableItemsRootGrid.repositionNow = true;
		}

		private void ClearOffer()
		{
			if (rewardItems_ != null)
			{
				foreach (RewardItemHierarchy item in rewardItems_)
				{
					Object.Destroy(item.gameObject);
				}
			}
			rewardItems_ = null;
			catalog_.Items.Clear();
		}

		private void AddBonusItem(SpecialOfferItem specialOfferItem)
		{
			if (specialOfferItem == null || specialOfferItem.artikul == null)
			{
				return;
			}
			RewardItemHierarchy rewardItemHierarchy = prefabsManager_.InstantiateNGUIIn<RewardItemHierarchy>("UIRewardItem", hierarchy_.AvailableItemsRootGrid.gameObject);
			rewardItemHierarchy.ItemText.text = specialOfferItem.artikul.title;
			if (specialOfferItem.count > 1)
			{
				rewardItemHierarchy.Count.text = specialOfferItem.count.ToString();
			}
			ArtikulsEntries value;
			if (InventoryContentMap.Artikuls.TryGetValue(specialOfferItem.artikul.id, out value))
			{
				RewardItem rewardItem = catalog_.Add(rewardItemHierarchy.GetComponent<UIWidget>(), rewardItemHierarchy.ItemIcon, catalog_.Check(value.large_icon, value.GetFullLargeIconPath));
				RarityEntries rarity;
				invetnoryController_.GetRarity(value.rarity_id, value.id, out rarity);
				if (rarity != null)
				{
					rewardItemHierarchy.ItemBack.spriteName = rarity.background_sprite_name;
				}
				else
				{
					Log.Error("ERROR: Rarity with {0} not found.", value.rarity_id);
				}
				SingletonManager.Get<NguiFileManager>(out nguiFileManager_);
				nguiFileManager_.SetUiTexture(rewardItemHierarchy.ItemIcon, value.GetFullLargeIconPath());
				rewardItem.hierarchy = rewardItemHierarchy;
				rewardItem.artikul = value;
				rewardItems_.Add(rewardItemHierarchy);
			}
		}

		private void HideWindow()
		{
			if (Visible)
			{
				windowsManager.ToggleWindow(this);
			}
		}

		private void HandleTimer()
		{
			hierarchy_.TimeLeftLabel.text = specialOffersManager_.GetCurrentOfferTime();
		}

		private void BuyOffer()
		{
			specialOffersManager_.PurchaseCurrentOffer();
		}
	}
}
