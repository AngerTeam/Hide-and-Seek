using System;
using System.Collections.Generic;
using BankModule;
using CraftyEngine.Content;
using CraftyEngine.Infrastructure;
using CraftyEngine.Sounds;
using CraftyGameEngine.Gui;
using ExperienceModule;
using ExpirienceModule.RemoteData;
using Extensions;
using HudSystem;
using InventoryModule;
using PlayerModule.MyPlayer;
using ShopModule;
using SplashesModule;
using SyncOnlineModule;
using WindowsModule;

namespace ExpirienceModule
{
	public class ExpirienceManager : Singleton
	{
		public MyPlayerExperianceModel expirience;

		public LevelUpWindow levelUpWindow;

		public XPWidget xpWidget;

		private BroadPurchaseOnline broadPurchaseOnline_;

		private HttpExperianceOnline expirienceOnline_;

		private MyPlayerStatsModel myPlayerStatsModel_;

		private WindowsManager windowsManager_;

		public bool LevelUpEnabled;

		public event Action<bool> LvlUpDone;

		public List<int> GetBonusAmount(int fromLevel, int toLevel, out int amount1, out int amount2)
		{
			amount1 = 0;
			amount2 = 0;
			List<int> list = new List<int>();
			foreach (KeyValuePair<int, ExpLevelsEntries> expLevel in ExpirienceContentMap.ExpLevels)
			{
				if (expLevel.Key > fromLevel && expLevel.Key <= toLevel)
				{
					ExpLevelsEntries value = expLevel.Value;
					amount1 += value.money1;
					amount2 += value.money2;
					if (value.bonus_id != 0)
					{
						list.Add(value.bonus_id);
					}
				}
			}
			return list;
		}

		public int GetHealthByLevel(int level)
		{
			ExpLevelsEntries value;
			if (ExpirienceContentMap.ExpLevels != null && ExpirienceContentMap.ExpLevels.TryGetValue(level, out value) && value.hp_max > 0)
			{
				return value.hp_max;
			}
			return 100;
		}

		public override void Init()
		{
			LevelUpEnabled = true;
			SingletonManager.Get<WindowsManager>(out windowsManager_);
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			SingletonManager.Get<BroadPurchaseOnline>(out broadPurchaseOnline_);
			expirience = myPlayerStatsModel_.stats.experiance;
			expirienceOnline_ = new HttpExperianceOnline();
		}

		public override void OnDataLoaded()
		{
			xpWidget = new XPWidget();
			levelUpWindow = new LevelUpWindow();
			ContentDeserializer.Deserialize<ExpirienceContentMap>();
			levelUpWindow.OkButtonClicked += CloseLevelUpWindow;
			levelUpWindow.BonusItemClicked += BonusItemClicked;
		}

		public override void OnSyncRecieved()
		{
			expirience.Exp = 0;
			PlayerExperienceSyncMessage message;
			if (!SyncManager.TryRead<PlayerExperienceSyncMessage>(out message) || message.expLevel == null || message.expLevel.Length != 1)
			{
				return;
			}
			PlayerSyncExperienceMessage playerSyncExperienceMessage = message.expLevel[0];
			if (LevelUpEnabled)
			{
				LevelUpEnabled = false;
				if (playerSyncExperienceMessage.expAcc > 0)
				{
					TryUpLevel();
				}
				else
				{
					this.LvlUpDone.SafeInvoke(false);
				}
			}
			UpdateExpirience(playerSyncExperienceMessage.level, playerSyncExperienceMessage.exp);
		}

		public void UpdateExpirience(int level, int exp)
		{
			expirience.level = level;
			expirience.Exp = exp;
			myPlayerStatsModel_.stats.HealthMax = GetHealthByLevel(level);
			UpdateExperienceWidget();
		}

		private void BonusItemClicked(ShopItemsEntries item)
		{
			CloseLevelUpWindow();
			UnityEvent.OnNextUpdate(delegate
			{
				OpenShopAndScrollTo(item.id);
			});
		}

		private void OpenShopAndScrollTo(int itemId)
		{
			IShop shop = GuiModuleHolder.Get<IShop>();
			WindowsManagerShortcut.ToggleWindow(shop as GameWindow);
			UnityEvent.OnNextUpdate(delegate
			{
				ScrollToShopItem(shop, itemId);
			});
		}

		private void ScrollToShopItem(IShop shop, int itemId)
		{
			shop.ScrollToItem(itemId, true);
		}

		private void CloseLevelUpWindow()
		{
			windowsManager_.ToggleWindow(levelUpWindow);
			this.LvlUpDone.SafeInvoke(true);
		}

		private List<ShopItemsEntries> GetAvailableItems(LevelupMessage message)
		{
			List<ShopItemsEntries> list = new List<ShopItemsEntries>();
			foreach (ShopItemsEntries value2 in ShopContentMap.ShopItems.Values)
			{
				int result;
				ArtikulsEntries value;
				if (int.TryParse(value2.entity_id, out result) && InventoryContentMap.Artikuls.TryGetValue(result, out value) && value2.hidden != 1 && value2.min_level == message.expLevelUpdate.level && value.min_level <= message.expLevelUpdate.level)
				{
					list.Add(value2);
				}
			}
			return list;
		}

		private bool GetLevels(int level, out ExpLevelsEntries current, out ExpLevelsEntries next)
		{
			current = (next = null);
			Dictionary<int, ExpLevelsEntries> expLevels = ExpirienceContentMap.ExpLevels;
			return expLevels != null && expLevels.TryGetValue(level, out current) && expLevels.TryGetValue(level + 1, out next);
		}

		private void HandleLevelUpResponse(RemoteMessageEventArgs args)
		{
			LevelupMessage levelupMessage = args.remoteMessage as LevelupMessage;
			if (levelupMessage == null)
			{
				this.LvlUpDone.SafeInvoke(false);
				return;
			}
			broadPurchaseOnline_.Report(levelupMessage);
			broadPurchaseOnline_.ExtractPurchaseItems(levelupMessage);
			int level = expirience.level;
			int level2 = levelupMessage.expLevelUpdate.level;
			if (level != level2)
			{
				int amount;
				int amount2;
				GetBonusAmount(level, level2, out amount, out amount2);
				SingletonManager.Get<SplashScreenManager>().HideScreen();
				levelUpWindow.SetBonusItems(GetAvailableItems(levelupMessage));
				levelUpWindow.SetLevelInfo(level2, amount2);
				windowsManager_.ToggleWindow(levelUpWindow);
				SoundProvider.PlaySingleSound2D(66);
			}
			else
			{
				this.LvlUpDone.SafeInvoke(false);
			}
			LevelUpdateMessage expLevelUpdate = levelupMessage.expLevelUpdate;
			UpdateExpirience(expLevelUpdate.level, expLevelUpdate.exp);
		}

		private void TryUpLevel()
		{
			expirienceOnline_.LevelUpResponse += HandleLevelUpResponse;
			expirienceOnline_.SendLevelUp();
		}

		private void UpdateExperienceWidget()
		{
			ExpLevelsEntries current;
			ExpLevelsEntries next;
			if (GetLevels(expirience.level, out current, out next))
			{
				int expMax = next.exp - current.exp;
				int exp = expirience.Exp - current.exp;
				xpWidget.SetXpWidgetValues(expirience.level, exp, expMax);
			}
			else
			{
				xpWidget.SetXpWidgetValues(expirience.level, expirience.Exp, 0);
			}
		}
	}
}
