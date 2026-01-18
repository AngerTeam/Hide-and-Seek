using System;
using BankModule;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using Extensions;
using HudSystem;
using InventoryViewModule;
using PlayerModule.MyPlayer;
using ShopModule;
using WindowsModule;

public class SkinsSubwindow : GameSubwindow
{
	protected CatalogLoader<SkinItem> catalog;

	protected SkinSubwindowHierarchy windowHierarchy;

	protected SkinItem currentSkin;

	protected PlayerSkinsManager playerSkinsManager;

	private MyPlayerStatsModel myPlayerManager_;

	private UnityTimerManager unityTimerManager_;

	private BroadPurchaseOnline online_;

	private UnityTimer buttonTimer_;

	public event Action<int> SkinSelected;

	public SkinsSubwindow()
	{
		SingletonManager.Get<PlayerSkinsManager>(out playerSkinsManager);
		SingletonManager.Get<MyPlayerStatsModel>(out myPlayerManager_);
		SingletonManager.Get<UnityTimerManager>(out unityTimerManager_);
		SingletonManager.Get<BroadPurchaseOnline>(out online_);
		windowHierarchy = prefabsManager_.InstantiateNGUIIn<SkinSubwindowHierarchy>("UISkinsSubwindow", nguiManager_.UiRoot.gameObject);
		container = windowHierarchy.gameObject;
		windowHierarchy.DescriptionLabel.text = string.Empty;
		windowHierarchy.passiveDescription.text = Localisations.Get("UI_SkinsLockedForMap");
		ButtonSet.Up(windowHierarchy.BuyButton, OnBuyButtonClicked, ButtonSetGroup.InWindow);
		base.ViewChanged += HandleViewChanged;
		playerSkinsManager.OnSkinBought += OnSkinBought;
		playerSkinsManager.SkinsEnabled += OnSkinsEnabled;
		catalog = new CatalogLoader<SkinItem>(0);
	}

	private void OnSkinsEnabled(bool enable)
	{
		windowHierarchy.activeWidget.gameObject.SetActive(enable);
		windowHierarchy.passiveWidget.gameObject.SetActive(!enable);
	}

	public virtual void BuildSkins()
	{
		foreach (SkinEntryView skin in playerSkinsManager.Skins)
		{
			if ((skin.skinData.selectable == 1 || skin.skinData.sale_on == 1) && !string.IsNullOrEmpty(skin.skinData.preview_picture))
			{
				AddSkin(skin);
			}
		}
	}

	public void PreviewCurrentSkin()
	{
		foreach (SkinItem item in catalog.Items)
		{
			if (item.skinId == myPlayerManager_.stats.SkinId)
			{
				PreviewSkin(item);
				return;
			}
		}
		UpdateSkinsButtons();
	}

	protected void AddSkin(SkinEntryView skinEntry)
	{
		SkinItemHierarchy skinItemHierarchy = prefabsManager_.InstantiateNGUIIn<SkinItemHierarchy>("UISkinItem", windowHierarchy.ContentsGrid.gameObject);
		SkinItem item = catalog.Add(skinItemHierarchy.rollerWidget, skinItemHierarchy.image, catalog.Check(skinEntry.skinData.preview_picture, skinEntry.skinData.GetFullPreviewPicturePath));
		item.entry = skinEntry;
		item.skinId = skinEntry.skinData.id;
		item.hierarchy = skinItemHierarchy;
		item.hierarchy.price.text = skinEntry.skinData.money_cnt.ToString();
		ButtonSet.Up(item.hierarchy.button, delegate
		{
			OnSkinClicked(item);
		}, ButtonSetGroup.InWindow);
	}

	private void OnSkinClicked(SkinItem item)
	{
		if (buttonTimer_ == null)
		{
			buttonTimer_ = unityTimerManager_.SetTimer(0.3f);
			buttonTimer_.Completeted += ButtonTimerCompleted;
			PreviewSkin(item);
		}
	}

	private void ButtonTimerCompleted()
	{
		buttonTimer_.Completeted -= ButtonTimerCompleted;
		buttonTimer_ = null;
	}

	private void HandleViewChanged(object sender, BoolEventArguments e)
	{
		if (base.Visible)
		{
			UnityEvent.OnNextUpdate(ResetScroll);
			catalog.Load();
			UpdateSkinsButtons();
		}
		else
		{
			catalog.Unload();
		}
	}

	private void ResetScroll()
	{
		windowHierarchy.ScrollView.InvalidateBounds();
		windowHierarchy.ScrollView.ResetPosition();
	}

	private void OnBuyButtonClicked()
	{
		if (currentSkin != null)
		{
			if (currentSkin.entry.isBought)
			{
				playerSkinsManager.SetSkin(currentSkin.entry.skinData.id);
				UpdateSkinsButtons();
			}
			else
			{
				playerSkinsManager.TryBuySkin(currentSkin.entry);
			}
		}
	}

	private void OnSkinBought()
	{
		if (base.Visible)
		{
			UpdateSkinsButtons();
			PreviewCurrentSkin();
			myPlayerManager_.stats.SkinId = currentSkin.entry.skinData.id;
			online_.AddPurchaseItem(currentSkin.entry.skinData.id, false, PurchaseItemType.Skin);
		}
	}

	protected virtual void UpdateSkinsButtons()
	{
		foreach (SkinItem item in catalog.Items)
		{
			item.hierarchy.selectionSprite.gameObject.SetActive(item.skinId == currentSkin.skinId);
			item.hierarchy.currentlySelectedSprite.gameObject.SetActive(item.skinId == myPlayerManager_.stats.SkinId);
			item.hierarchy.price.gameObject.SetActive(!item.entry.isBought);
		}
	}

	private void PreviewSkin(SkinItem item)
	{
		currentSkin = item;
		windowHierarchy.DescriptionLabel.text = item.entry.skinData.title;
		if (item.entry.isBought)
		{
			windowHierarchy.BuyButtonLabel.text = Localisations.Get("UI_Select");
		}
		else
		{
			windowHierarchy.BuyButtonLabel.text = Localisations.Get("UI_BuyShopItem");
		}
		this.SkinSelected.SafeInvoke(currentSkin.skinId);
		UpdateSkinsButtons();
	}
}
