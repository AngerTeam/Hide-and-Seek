using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using HudSystem;
using InventoryViewModule;
using ShopModule;
using UnityEngine;
using WindowsModule;

namespace CraftyGameEngine.Gui
{
	public class ShopWindow : GameWindow, IShop
	{
		private const int MELEE_SUBWINDOW_ID = 0;

		private const int RANGED_SUBWINDOW_ID = 1;

		private const int OTHER_SUBWINDOW_ID = 2;

		private ShopItemsSubwindow meleeSubwindow_;

		private ShopItemsSubwindow rangedSubwindow_;

		private ShopItemsSubwindow otherSubwindow_;

		private SkinsSubwindow skinsSubwindow_;

		private ShopStateController shopStateController_;

		private Dictionary<int, int> itemIds_;

		private TabsWidgetWithSubwindows tabs_;

		public event Action<ShopItemsEntries> OnBuy;

		public ShopWindow()
			: base(false, false)
		{
			itemIds_ = new Dictionary<int, int>();
			base.HudState = 8352;
			prefabsManager.Load("ShopModule");
			base.ExclusiveGroup = 1;
			tabs_ = new TabsWidgetWithSubwindows();
			SetContent(tabs_.hierarchy.transform, true, true, false, false, true);
			tabs_.SetSize(1850, 800);
			tabs_.hierarchy.background.transform.localPosition = new Vector3(0f, -124f, 0f);
			tabs_.hierarchy.contentContainer.bottomAnchor.absolute = 249;
			tabs_.hierarchy.title.text = Localisations.Get("UI_Arsenal");
			meleeSubwindow_ = tabs_.AddSubWindow<ShopItemsSubwindow>("UI_Tab_Melee");
			meleeSubwindow_.ItemSelected += OnHandItemSelected;
			meleeSubwindow_.Setup(0, BuyItem, true);
			rangedSubwindow_ = tabs_.AddSubWindow<ShopItemsSubwindow>("UI_Tab_Ranged");
			rangedSubwindow_.Setup(1, BuyItem, true);
			rangedSubwindow_.ItemSelected += OnHandItemSelected;
			otherSubwindow_ = tabs_.AddSubWindow<ShopItemsSubwindow>("UI_Tab_Other");
			otherSubwindow_.Setup(2, BuyItem, false);
			otherSubwindow_.ItemSelected += OnHandItemSelected;
			skinsSubwindow_ = tabs_.AddSubWindow<SkinsSubwindow>("UI_Tab_Skins");
			skinsSubwindow_.SkinSelected += OnSkinSelected;
			Build();
			windowsManager.WindowsCountChanged += OnWindowsCountChanged;
			base.HeavyGraphics = true;
			ShopWindowHierarchy shopWindowHierarchy = prefabsManager.InstantiateNGUIIn<ShopWindowHierarchy>("UIShopElements", tabs_.hierarchy.contentContainer.gameObject);
			shopStateController_ = new ShopStateController(shopWindowHierarchy.modelHolder.transform);
			base.Hierarchy.closeButton = shopWindowHierarchy.closeButton;
			shopWindowHierarchy.closeButtonLabel.text = Localisations.Get("UI_Close");
			ButtonSet.Up(shopWindowHierarchy.closeButton, OnWindowClose, ButtonSetGroup.InWindow);
			SetContent(shopWindowHierarchy.transform, false);
			ButtonSet.Up(shopWindowHierarchy.actorButton, OnActorPressed, ButtonSetGroup.InWindow);
			base.ViewChanged += HandleViewChanged;
			tabs_.TabActivated += HandleTabActivated;
		}

		public override void Clear()
		{
			tabs_.Dispose();
		}

		private void HandleTabActivated(Tab tab)
		{
			skinsSubwindow_.PreviewCurrentSkin();
		}

		private void OnActorPressed()
		{
			shopStateController_.ToggleFlauntActor();
		}

		private void OnSkinSelected(int skinId)
		{
			shopStateController_.SwitchActorSkin(skinId);
		}

		private void OnHandItemSelected(int artikul)
		{
			shopStateController_.SetHandItem((ushort)artikul);
		}

		private void OnWindowClose()
		{
			windowsManager.ToggleWindow(this);
		}

		private void OnWindowsCountChanged()
		{
			if (base.IsFront)
			{
				shopStateController_.SwitchActor(true);
			}
			else
			{
				shopStateController_.SwitchActor(false);
			}
		}

		private void HandleViewChanged(object sender, BoolEventArguments e)
		{
			if (Visible)
			{
				shopStateController_.CreateActor();
				meleeSubwindow_.SetCurrentPrefferableItem();
				rangedSubwindow_.SetCurrentPrefferableItem();
			}
			else
			{
				shopStateController_.Dispose();
			}
			tabs_.ActivateTab(1);
			tabs_.UpdateVisibility(Visible);
		}

		private void Build()
		{
			List<ShopItemsEntries> entries;
			Dictionary<string, ShopCategory> categories;
			GetShopItems(out entries, out categories);
			entries.Sort((ShopItemsEntries a, ShopItemsEntries b) => a.sort_val.CompareTo(b.sort_val));
			foreach (ShopItemsEntries item in entries)
			{
				itemIds_.Add(item.id, item.type);
			}
			meleeSubwindow_.AddItems(entries);
			rangedSubwindow_.AddItems(entries);
			otherSubwindow_.AddItems(entries);
			skinsSubwindow_.BuildSkins();
		}

		public void BuyItem(ShopItemsEntries shopItemsEntry)
		{
			if (this.OnBuy != null)
			{
				this.OnBuy(shopItemsEntry);
			}
		}

		public void ScrollToItem(int itemId, bool select = false)
		{
			foreach (KeyValuePair<int, int> kvp in itemIds_)
			{
				if (kvp.Key != itemId)
				{
					continue;
				}
				int num = kvp.Value - 1;
				tabs_.ActivateTab(num);
				SubWindow subwindow;
				if (tabs_.Windows.TryGetValue(num, out subwindow))
				{
					UnityEvent.OnNextUpdate(delegate
					{
						subwindow.window.SelectById(kvp.Key);
					});
				}
				break;
			}
		}

		public void GetShopItems(out List<ShopItemsEntries> entries, out Dictionary<string, ShopCategory> categories)
		{
			entries = new List<ShopItemsEntries>();
			categories = new Dictionary<string, ShopCategory>();
			int num = 0;
			foreach (ShopItemsEntries value2 in ShopContentMap.ShopItems.Values)
			{
				if ((value2.hidden != 0 && !DataStorage.isAdmin) || value2.artikul == null)
				{
					continue;
				}
				if (!string.IsNullOrEmpty(value2.artikul.client_version) && !VersionUtil.Compare(DataStorage.version, value2.artikul.client_version))
				{
					Log.Info("Skipping shop item {0} by client version", value2.artikul.id);
					continue;
				}
				if (value2.hidden == 1 && !value2.title.Contains("[hidden] "))
				{
					value2.title = "[hidden] " + value2.title;
				}
				ShopCategory value;
				if (!categories.TryGetValue(value2.entity_table_name, out value))
				{
					value = new ShopCategory();
					value.id = num;
					value.title = value2.entity_table_name;
					categories[value2.entity_table_name] = value;
					num++;
				}
				value2.categoryId = value.id;
				entries.Add(value2);
			}
		}

		public void GetRecommendedItems(int currentLevel, int itemsCount, out List<ShopItemsEntries> recommendedItems, List<int> recommendedItemsIds = null)
		{
			recommendedItems = new List<ShopItemsEntries>();
			List<ShopItemsEntries> entries;
			Dictionary<string, ShopCategory> categories;
			GetShopItems(out entries, out categories);
			entries.Sort(delegate(ShopItemsEntries a, ShopItemsEntries b)
			{
				int num2 = b.maxLevelCap.CompareTo(a.maxLevelCap);
				return (num2 != 0) ? num2 : b.money_cnt.CompareTo(a.money_cnt);
			});
			int num = 0;
			foreach (ShopItemsEntries item in entries)
			{
				if (recommendedItemsIds == null || recommendedItemsIds.Contains(item.id))
				{
					if (item.maxLevelCap <= currentLevel && item.artikul != null && item.artikul.type_id == 4)
					{
						num++;
						recommendedItems.Add(item);
					}
					if (num >= itemsCount)
					{
						break;
					}
				}
			}
		}
	}
}
