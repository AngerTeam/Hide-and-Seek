using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using HudSystem;
using InventoryModule;
using InventoryViewModule;
using PlayerModule.MyPlayer;
using ShopModule;
using UnityEngine;
using WindowsModule;

public class ShopItemsSubwindow : GameSubwindow
{
	public ShopItemsSubwindowHierarchy windowHierarchy;

	private MyPlayerStatsModel myPlayerStatsModel_;

	private IInventoryLogic inventory_;

	private UnityEvent unityEvent_;

	private ShopItem currentItem_;

	private CatalogLoader<ShopItem> catalog_;

	private int itemsTypeId_;

	private bool useWeaponDescription_;

	private Color redColor_ = new Color(1f, 0.21960784f, 0.21960784f);

	private WeaponDescriptionWidget weaponDescription_;

	public event Action<int> ItemSelected;

	private event Action<ShopItemsEntries> BuyButtonPressed;

	public ShopItemsSubwindow()
	{
		SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
		SingletonManager.Get<IInventoryLogic>(out inventory_);
		SingletonManager.Get<UnityEvent>(out unityEvent_);
		prefabsManager_.Load("ShopModule");
		windowHierarchy = prefabsManager_.InstantiateNGUIIn<ShopItemsSubwindowHierarchy>("UIShopItemsSubwindow", nguiManager_.UiRoot.gameObject);
		weaponDescription_ = new WeaponDescriptionWidget(windowHierarchy.DescriptionContainer.transform);
		container = windowHierarchy.gameObject;
	}

	public void Setup(int itemsTypeId, Action<ShopItemsEntries> buyButtonPressed, bool useWeaponDescription)
	{
		itemsTypeId_ = itemsTypeId;
		this.BuyButtonPressed = buyButtonPressed;
		useWeaponDescription_ = useWeaponDescription;
		ButtonSet.Up(windowHierarchy.BuyButton, Buy, ButtonSetGroup.InWindow);
		base.ViewChanged += HandleViewChanged;
		catalog_ = new CatalogLoader<ShopItem>(4);
		weaponDescription_.SwitchDescription(useWeaponDescription_);
	}

	private void Buy()
	{
		if (this.BuyButtonPressed != null)
		{
			this.BuyButtonPressed(currentItem_.entry);
		}
	}

	private void HandleViewChanged(object sender, BoolEventArguments e)
	{
		if (base.Visible)
		{
			if (catalog_.Items.Count > 0)
			{
				ItemSelect((currentItem_ == null) ? catalog_.Items[0] : currentItem_);
			}
			else
			{
				ItemSelect(null);
			}
			UpdateLocks();
			if (currentItem_ != null)
			{
				ScrollToItem(currentItem_);
			}
			catalog_.Load();
		}
		else
		{
			catalog_.Unload();
		}
	}

	private bool TestEntryLevel(ShopItemsEntries entry)
	{
		bool flag = myPlayerStatsModel_.stats.experiance.level >= entry.level_min;
		bool flag2 = myPlayerStatsModel_.stats.experiance.level <= entry.level_max || entry.level_max == 0;
		return flag && flag2;
	}

	private void UpdateLocks()
	{
		foreach (ShopItem item in catalog_.Items)
		{
			if (item.entry != null)
			{
				item.hierarchy.lockSprite.gameObject.SetActive(item.entry.maxLevelCap > myPlayerStatsModel_.stats.experiance.level);
				item.hierarchy.gameObject.SetActive(TestEntryLevel(item.entry));
			}
		}
	}

	private void ResetScroll()
	{
		windowHierarchy.ScrollView.InvalidateBounds();
		windowHierarchy.ScrollView.ResetPosition();
	}

	public override void SelectById(int itemId)
	{
		for (int i = 0; i < catalog_.Items.Count; i++)
		{
			ShopItem shopItem = catalog_.Items[i];
			if (shopItem.itemId == itemId)
			{
				ItemSelect(shopItem);
				ScrollToItemByIndex(i);
				break;
			}
		}
	}

	public void AddItems(List<ShopItemsEntries> entries)
	{
		foreach (ShopItemsEntries entry in entries)
		{
			ArtikulsEntries value;
			if (entry.type - 1 == itemsTypeId_ && InventoryContentMap.Artikuls.TryGetValue(entry.artikulId, out value))
			{
				ShopItemHierarchy shopItemHierarchy = prefabsManager_.InstantiateNGUIIn<ShopItemHierarchy>("UIShopItem", windowHierarchy.ContentsGrid.gameObject);
				shopItemHierarchy.itemName.text = entry.title;
				shopItemHierarchy.price.text = entry.money_cnt.ToString();
				ShopItem item = catalog_.Add(shopItemHierarchy.rollerWidget, shopItemHierarchy.icon, catalog_.Check(value.large_icon, value.GetFullLargeIconPath), shopItemHierarchy.preview, catalog_.Check(value.large_icon_preview, value.GetFullLargeIconPreviewPath));
				inventory_.Controller.SetBackgroundSprite(shopItemHierarchy.backgroundSprite, value);
				item.itemId = entry.id;
				item.entry = entry;
				item.artikul = value;
				item.hierarchy = shopItemHierarchy;
				item.hierarchy.gameObject.SetActive(TestEntryLevel(entry));
				ButtonSet.Up(shopItemHierarchy.button, delegate
				{
					ItemSelect(item);
				}, ButtonSetGroup.InWindow);
			}
		}
	}

	public void SetCurrentPrefferableItem()
	{
		int num = -1;
		int num2 = -1;
		int level = myPlayerStatsModel_.stats.experiance.level;
		for (int i = 0; i < catalog_.Items.Count; i++)
		{
			ShopItem shopItem = catalog_.Items[i];
			if (shopItem.entry != null && TestEntryLevel(shopItem.entry) && level >= shopItem.entry.maxLevelCap && shopItem.entry.maxLevelCap > num2)
			{
				num = i;
				num2 = shopItem.entry.maxLevelCap;
			}
		}
		if (num != -1)
		{
			currentItem_ = catalog_.Items[num];
		}
	}

	private void ItemSelect(ShopItem item)
	{
		currentItem_ = item;
		if (item != null && item.entry != null)
		{
			bool flag = item.artikul.type_id == 5;
			weaponDescription_.ItemSelect(item.entry);
			BuyRestrictionType type = BuyRestrictionType.Available;
			SlotModel slot;
			if (flag)
			{
				type = BuyRestrictionType.Available;
			}
			else if (currentItem_.entry.maxLevelCap > myPlayerStatsModel_.stats.experiance.level)
			{
				type = BuyRestrictionType.RestrictByLevel;
			}
			else if (!inventory_.GetFirstAvailableSlot((ushort)currentItem_.entry.artikulId, 1, false, out slot))
			{
				type = BuyRestrictionType.RestrictBySlots;
			}
			SetupBuyButton(type, currentItem_.entry.maxLevelCap);
			windowHierarchy.BuyButton.gameObject.SetActive(true);
			if (this.ItemSelected != null)
			{
				this.ItemSelected(currentItem_.entry.artikulId);
			}
			UnityEvent.OnNextUpdate(delegate
			{
				item.hierarchy.selectionToggle.value = true;
			});
		}
		else
		{
			weaponDescription_.ItemClear();
			windowHierarchy.BuyButton.gameObject.SetActive(false);
		}
	}

	private void SetupBuyButton(BuyRestrictionType type, int level)
	{
		UISprite component = windowHierarchy.BuyButton.GetComponent<UISprite>();
		switch (type)
		{
		case BuyRestrictionType.RestrictBySlots:
		{
			string text2 = Localisations.Get("UI_BuyShopItemInventoryFull");
			weaponDescription_.SetRestricted(text2, redColor_, true);
			windowHierarchy.BuyButton.gameObject.SetActive(false);
			windowHierarchy.BuyButtonLabel.text = string.Empty;
			component.enabled = false;
			return;
		}
		case BuyRestrictionType.RestrictByLevel:
		{
			string text = Localisations.Get("UI_BuyShopItemLevelCap");
			text = text.Replace("%level%", level.ToString());
			weaponDescription_.SetRestricted(text, redColor_, true);
			windowHierarchy.BuyButton.gameObject.SetActive(false);
			windowHierarchy.BuyButtonLabel.text = string.Empty;
			component.enabled = false;
			return;
		}
		}
		windowHierarchy.BuyButtonLabel.text = Localisations.Get("UI_BuyShopItem");
		if (level > 1)
		{
			string text3 = Localisations.Get("UI_BuyShopItemLevelCap");
			text3 = text3.Replace("%level%", level.ToString());
			weaponDescription_.SetRestricted(text3, Color.white, true);
		}
		else
		{
			weaponDescription_.SetRestricted(string.Empty, Color.white, false);
		}
		windowHierarchy.BuyButton.gameObject.SetActive(true);
		component.enabled = true;
	}

	private void ScrollToItem(ShopItem shopItem)
	{
		int num = 0;
		for (int i = 0; i < catalog_.Items.Count; i++)
		{
			if (catalog_.Items[i] == shopItem)
			{
				ScrollToItemByIndex(i - num);
				break;
			}
			if (!catalog_.Items[i].hierarchy.gameObject.activeSelf)
			{
				num++;
			}
		}
	}

	private void ScrollToItemByIndex(int index)
	{
		Action act = null;
		act = delegate
		{
			unityEvent_.Unsubscribe(UnityEventType.LateUpdate, act);
			windowHierarchy.ScrollView.ResetPosition();
			Vector2 cellPosition = windowHierarchy.ContentsGrid.GetCellPosition(index);
			windowHierarchy.ScrollView.MoveRelative(new Vector3(0f - cellPosition.x, 0f, 0f));
			windowHierarchy.ScrollView.RestrictWithinBounds(true);
		};
		unityEvent_.Subscribe(UnityEventType.LateUpdate, act);
	}
}
