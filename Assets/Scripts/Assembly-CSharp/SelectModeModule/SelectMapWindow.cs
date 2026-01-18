using AuthorizationGame.RemoteData;
using CraftyEngine.Infrastructure;
using HudSystem;
using InventoryViewModule;
using NguiTools;
using PlayerModule.MyPlayer;
using PvpModule.Content;
using RecommendedToBuyModule;
using RemoteData.Lua;
using UnityEngine;
using WindowsModule;

namespace SelectModeModule
{
	public class SelectMapWindow : GameWindow
	{
		private const string GREEN_COLOR = "69fE26FF";

		private const string WHITE_COLOR = "FFFFFFFF";

		private Color redColor_ = new Color(1f, 0.21960784f, 0.21960784f);

		private Color defaultTextColor_;

		private MapInfoWidget recommendedItemsWindowMapInfoWidget_;

		private NguiFileManager nguiFileManager_;

		private SelectMapItem selectedItem_;

		private CatalogLoader<SelectMapItem> catalog;

		private SelectMapWindowHierarchy window_;

		private TimeManager timeManager_;

		private SelectModeController selectModeController_;

		private SelectModeOnlineController onlineController_;

		private MyPlayerStatsModel myPlayerStatsModel_;

		public SelectMapWindow()
			: base(false, false)
		{
			base.ExclusiveGroup = 3;
			base.HudState = 41088;
			SingletonManager.Get<TimeManager>(out timeManager_);
			SingletonManager.Get<NguiFileManager>(out nguiFileManager_);
			SingletonManager.Get<SelectModeController>(out selectModeController_);
			SingletonManager.Get<SelectModeOnlineController>(out onlineController_);
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			onlineController_.PvpInfoReceived += HandlePvpInfoReceived;
			prefabsManager.Load("SelectModeModulePrefabsHolder");
			window_ = prefabsManager.InstantiateIn<SelectMapWindowHierarchy>("UISelectMapWindow", nguiManager.UiRoot.transform);
			window_.title.text = Localisations.Get("UI_GameType_WindowTitle");
			ButtonSet.Up(window_.closeButton, CloseWindow, ButtonSetGroup.InWindow);
			ButtonSet.Up(window_.selectButton, PlayClick, ButtonSetGroup.InWindow);
			ButtonSet.Up(window_.comebackButton, ComebackClick, ButtonSetGroup.InWindow);
			window_.stubLabel.text = Localisations.Get("GameType_CommingSoon");
			window_.closeButtonLabel.text = Localisations.Get("UI_Close");
			window_.selectButtonLabel.text = Localisations.Get("UI_Play");
			window_.comebackButtonLabel.text = Localisations.Get("UI_ReturnToGameMode");
			defaultTextColor_ = window_.descriptionLabel.color;
			catalog = new CatalogLoader<SelectMapItem>();
			SetContent(window_.transform, true, true, false, false, true);
			SetupItems();
			base.ViewChanged += HandleViewChanged;
			base.HeavyGraphics = true;
		}

		public void OpenWindow(int modeId)
		{
			if (!Visible)
			{
				WindowsManagerShortcut.ToggleWindow(this);
			}
			selectedItem_ = null;
			UpdateLocks();
			foreach (SelectMapItem item in catalog.Items)
			{
				if (item.ViewModeId == modeId)
				{
					item.hierarchy.gameObject.SetActive(true);
					if (selectedItem_ == null)
					{
						selectedItem_ = item;
					}
				}
				else
				{
					item.hierarchy.gameObject.SetActive(false);
				}
			}
		}

		private void UpdateLocks()
		{
			foreach (SelectMapItem item in catalog.Items)
			{
				if (item.LockedLevel > 0)
				{
					item.Locked = item.LockedLevel > myPlayerStatsModel_.stats.experiance.level;
					if (item.hierarchy != null)
					{
						item.hierarchy.lockSprite.gameObject.SetActive(item.Locked);
					}
				}
				else
				{
					item.Locked = false;
					if (item.hierarchy != null)
					{
						item.hierarchy.lockSprite.gameObject.SetActive(false);
					}
				}
			}
		}

		private void CloseWindow()
		{
			windowsManager.ToggleWindow(this);
		}

		private void HandleMapItemClick(SelectMapItem item)
		{
			if (item.hierarchy.toggle.value)
			{
				selectedItem_ = item;
				Refresh();
			}
		}

		private void HandlePvpInfoReceived(RemoteMessageEventArgs obj)
		{
			PvpInfoResponse pvpInfoResponse = obj.remoteMessage as PvpInfoResponse;
			if (pvpInfoResponse == null || pvpInfoResponse.mapInfo == null || pvpInfoResponse.mapInfo.Length == 0)
			{
				return;
			}
			foreach (SelectMapItem item in catalog.Items)
			{
				if (item.Random)
				{
					continue;
				}
				for (int i = 0; i < pvpInfoResponse.mapInfo.Length; i++)
				{
					MapInfoMessage mapInfoMessage = pvpInfoResponse.mapInfo[i];
					if (item.Id == mapInfoMessage.islandId)
					{
						SetItemCount(item, mapInfoMessage.instances);
						break;
					}
				}
			}
		}

		private void HandleViewChanged(object sender, BoolEventArguments e)
		{
			if (Visible)
			{
				catalog.Load();
				onlineController_.SendPvpInfo();
				Refresh();
				UnityEvent.OnNextUpdate(SelectItem);
			}
			else
			{
				catalog.Unload();
			}
		}

		private void Refresh()
		{
			if (selectedItem_ == null)
			{
				window_.comebackButton.gameObject.SetActive(false);
				window_.descriptionWidget.gameObject.SetActive(false);
				window_.selectButton.defaultColor = new Color(1f, 1f, 1f, 0.5f);
				window_.selectButton.enabled = false;
				return;
			}
			window_.comebackButton.gameObject.SetActive(ShowComebackButton());
			window_.descriptionWidget.gameObject.SetActive(true);
			window_.selectButton.enabled = !selectedItem_.Locked;
			window_.selectButton.defaultColor = ((!selectedItem_.Locked) ? new Color(1f, 1f, 1f, 1f) : new Color(1f, 1f, 1f, 0.5f));
			window_.descriptionLabel.color = ((!selectedItem_.Locked) ? defaultTextColor_ : redColor_);
			if (selectedItem_.Locked)
			{
				string text = Localisations.Get("UI_BuyShopItemLevelCap");
				text = text.Replace("%level%", selectedItem_.LockedLevel.ToString());
				window_.descriptionLabel.text = text;
			}
			else
			{
				window_.descriptionLabel.text = selectedItem_.Description;
			}
		}

		private void RenderItem(SelectMapItem item)
		{
			MapItemHierarchy mapItemHierarchy = prefabsManager.InstantiateIn<MapItemHierarchy>("UIMapItem", window_.contentsGrid.transform);
			item.hierarchy = mapItemHierarchy;
			item.countIcons = new UIWidget[4];
			for (int i = 0; i < item.countIcons.Length; i++)
			{
				UIWidget uIWidget = prefabsManager.InstantiateIn<UIWidget>("UIMapItemCountIcon", item.hierarchy.count.transform);
				uIWidget.depth = 10 + i;
				uIWidget.gameObject.SetActive(false);
				item.countIcons[i] = uIWidget;
			}
			item.hierarchy.count.Reposition();
			if (item.Random)
			{
				mapItemHierarchy.size.gameObject.SetActive(false);
			}
			else
			{
				string text = null;
				switch (item.MapSize)
				{
				case 1:
					text = "UI_MapSize1";
					break;
				case 2:
					text = "UI_MapSize2";
					break;
				case 3:
					text = "UI_MapSize3";
					break;
				case 4:
					text = "UI_MapSize4";
					break;
				}
				if (text == null)
				{
					mapItemHierarchy.size.gameObject.SetActive(false);
				}
				else
				{
					mapItemHierarchy.size.gameObject.SetActive(true);
					string text2 = Localisations.Get("UI_MapSizeTitle");
					string text3 = Localisations.Get(text);
					mapItemHierarchy.size.text = string.Format("[{0}]{1}[-]:[{2}]{3}[-]", "FFFFFFFF", text2, "69fE26FF", text3);
				}
			}
			mapItemHierarchy.title.text = item.Title;
			if (!string.IsNullOrEmpty(item.Picture))
			{
				nguiFileManager_.SetUiTexture(mapItemHierarchy.texture, item.Picture);
			}
			EventDelegate.Set(mapItemHierarchy.toggle.onChange, delegate
			{
				HandleMapItemClick(item);
			});
			catalog.Render(item, item.hierarchy.preloaderContainer, item.hierarchy.texture, item.Picture, null, null);
		}

		private void PlayClick()
		{
			ShowRecommendedToBuyItems(false);
		}

		private void ComebackClick()
		{
			ShowRecommendedToBuyItems(true);
		}

		public void ShowRecommendedToBuyItems(bool comeback)
		{
			MyPlayerStatsModel singlton;
			SingletonManager.Get<MyPlayerStatsModel>(out singlton);
			RecommendedToBuyWindow recommendedToBuyWindow = GuiModuleHolder.Get<RecommendedToBuyWindow>();
			if (recommendedItemsWindowMapInfoWidget_ == null)
			{
				recommendedItemsWindowMapInfoWidget_ = new MapInfoWidget(recommendedToBuyWindow.MapInfoContainer.transform);
			}
			recommendedItemsWindowMapInfoWidget_.SetMapInfo(selectedItem_);
			DataStorage.currentModeId = selectedItem_.ModeId;
			recommendedToBuyWindow.OpenWindow(singlton.stats.experiance.level, delegate
			{
				PlayMap(comeback);
			});
		}

		private void PlayMap(bool comeback)
		{
			selectModeController_.PlayMap(selectedItem_.ModeId, selectedItem_.Id, comeback);
			CloseWindow();
		}

		private void ResetScroll()
		{
			window_.scrollView.InvalidateBounds();
			window_.scrollView.ResetPosition();
			window_.contentsGrid.Reposition();
		}

		private void SelectItem()
		{
			if (selectedItem_ != null)
			{
				selectedItem_.hierarchy.toggle.value = true;
				HandleMapItemClick(selectedItem_);
				UnityEvent.OnNextUpdate(ResetScroll);
			}
		}

		private void SetItemCount(SelectMapItem item, int count)
		{
			for (int i = 0; i < item.countIcons.Length; i++)
			{
				bool active = count > i;
				item.countIcons[i].gameObject.SetActive(active);
			}
		}

		private void SetupItems()
		{
			foreach (PvpModesEntries value in PvpModuleContentMap.PvpModes.Values)
			{
				SelectMapItem selectMapItem = catalog.Add();
				selectMapItem.Init(value.id, value.id, null, value.title);
			}
			foreach (CommonIslandsEntries value2 in SelectGameModeMap.CommonIslands.Values)
			{
				SelectMapItem selectMapItem2 = catalog.Add();
				selectMapItem2.Init(value2.mode_id, value2.pvp_mode_id, value2);
			}
			catalog.Items.Sort((SelectMapItem a, SelectMapItem b) => a.Sort.CompareTo(b.Sort));
			foreach (SelectMapItem item in catalog.Items)
			{
				RenderItem(item);
			}
		}

		private bool ShowComebackButton()
		{
			if (selectedItem_ != null && !selectedItem_.Locked && selectModeController_.ComebackIslands != null)
			{
				foreach (PvpLastIslandsMessage comebackIsland in selectModeController_.ComebackIslands)
				{
					if (comebackIsland.islandId == selectedItem_.Id)
					{
						return comebackIsland.ctime < timeManager_.CurrentTimestamp;
					}
				}
			}
			return false;
		}
	}
}
