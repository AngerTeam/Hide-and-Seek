using System;
using AdsModule;
using ChestsOnlineModule;
using ChestsViewModule.Content;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using DailyBonusModule;
using Extensions;
using HudSystem;
using InventoryModule;
using NotificationsModule;
using RemoteData.Lua;
using SyncOnlineModule;
using UnityEngine;

namespace ChestsViewModule
{
	public class ChestsManager : ChestsManagerBase
	{
		private ArtikulsEntries adsArtikul_;

		private ArtikulsEntries assassinsArtikul_;

		private ArtikulsEntries dailyArtikul_;

		private INotifications notificationsManager_;

		private AdsManager adsManager_;

		private DailyBonusController dailyBonusController_;

		private ChestsPermanent chestsPermanent_;

		private ChestRewardInformer chestRewardInformer_;

		public RewardChest AdsChest { get; private set; }

		public RewardChest AssassinsChest { get; private set; }

		public RewardChest DailyChest { get; private set; }

		public event Action<int> SetInformerCount;

		public event Action<string> AnimateInformerChest;

		public override void Init()
		{
			base.Init();
			SingletonManager.Get<ChestsPermanent>(out chestsPermanent_);
			SingletonManager.Get<INotifications>(out notificationsManager_);
			SingletonManager.Get<AdsManager>(out adsManager_);
			SingletonManager.Get<DailyBonusController>(out dailyBonusController_);
			adsManager_.AdsWached += OpenAdsChest;
		}

		public override void OnDataLoaded()
		{
			base.OnDataLoaded();
			InitAssasinChest();
			InitAdsChest();
			InitDailyChest();
			LoadChests();
			chestsWindowBase = GuiModuleHolder.Add<ChestsWindow>();
		}

		public void LoadChests()
		{
			if (adsArtikul_ != null)
			{
				AdsChest.view.Instantiate(adsArtikul_.model_id);
			}
			else
			{
				Log.Error("ERROR: adsArtikul is null");
			}
			if (assassinsArtikul_ != null)
			{
				AssassinsChest.view.Instantiate(assassinsArtikul_.model_id);
			}
			else
			{
				Log.Error("ERROR: assassinsArtikul_ is null");
			}
			if (dailyArtikul_ != null)
			{
				DailyChest.view.Instantiate(dailyArtikul_.model_id);
			}
			else
			{
				Log.Error("ERROR: dailyArtikul_ is null");
			}
		}

		public void AssassinsChestClick()
		{
			if (chestsPermanent_.IsAssassinsChestReady())
			{
				SendAssassinsChestOpen();
				chestsPermanent_.NullifyAssassinsChest();
				ChestsWindow chestsWindow = (ChestsWindow)chestsWindowBase;
				chestsWindow.UpdateAssassinsChest();
				chestOpener.selectedChestWindow.OpenWindow(AssassinsChest);
				notificationsManager_.CancelAssassinsChestNotification();
			}
			else
			{
				MessageBroadcaster.ReportInfo(Localisations.Get("UI_AssassinsChest_Description"), 230f);
			}
		}

		public void OpenAdsChest()
		{
			chestOpener.selectedChestWindow.OpenWindow(AdsChest);
			ChestsOnlineController singlton;
			SingletonManager.Get<ChestsOnlineController>(out singlton);
			singlton.SendOpenAdsChest();
		}

		protected override void SetCountInformer(int count)
		{
			this.SetInformerCount.SafeInvoke(count);
		}

		public void SetChestInformer(Transform chestTransform)
		{
			if (chestRewardInformer_ == null)
			{
				chestRewardInformer_ = new ChestRewardInformer();
				chestRewardInformer_.InformerClicked += base.ToggleChestsWindow;
				chestRewardInformer_.AnimateChest += OnAnimateInformerChest;
			}
			chestRewardInformer_.SetShape(chestTransform);
		}

		protected override void UpdateInformer(bool anyCompleted, bool chestIsOpening, bool startNow)
		{
			if (chestRewardInformer_ != null)
			{
				if (anyCompleted)
				{
					chestRewardInformer_.UpdateState(InformerStateType.TakeRewards, string.Empty);
				}
				else if (startNow && !chestIsOpening)
				{
					chestRewardInformer_.UpdateState(InformerStateType.StartNow, string.Empty);
				}
				else if (adsManager_.IsVideoAvailable())
				{
					chestRewardInformer_.UpdateState(InformerStateType.FreeGems, string.Empty);
				}
				else if (chestIsOpening)
				{
					chestRewardInformer_.UpdateState(InformerStateType.InProgress, TimeUtils.ToTimerCounter(base.OpeningChest.EndTime - timeManager_.CurrentTimestamp));
				}
				else
				{
					chestRewardInformer_.UpdateState(InformerStateType.Idle, string.Empty);
				}
			}
		}

		public override void OnSyncRecieved()
		{
			base.OnSyncRecieved();
			PlayerChestsSyncMessage message;
			if (SyncManager.TryRead<PlayerChestsSyncMessage>(out message) && message.adChest != null && message.adChest.Length > 0)
			{
				adsManager_.SetLastViewTime(Convert.ToInt32(message.adChest[0].viewTime));
			}
			if (chestsWindowBase != null)
			{
				ChestsWindow chestsWindow = (ChestsWindow)chestsWindowBase;
				chestsWindow.UpdateAssassinsChest();
			}
		}

		protected override void SetChestOpenNotification(int seconds)
		{
			notificationsManager_.SetChestOpenNotification(seconds);
		}

		protected override void CancelChestOpenNotification()
		{
			notificationsManager_.CancelChestOpenNotification();
		}

		protected override void SetChestGotIdleNotification()
		{
			notificationsManager_.SetChestGotIdleNotification();
		}

		public void SetLuckyChestNotification(int secondsLeft)
		{
			notificationsManager_.SetLuckyChestNotification(secondsLeft);
		}

		protected override int ExtraChestsReady()
		{
			int num = 0;
			if (chestsPermanent_ != null && chestsPermanent_.IsAssassinsChestReady())
			{
				num++;
			}
			if (dailyBonusController_ != null && dailyBonusController_.IsBonusEnable)
			{
				num++;
			}
			return num;
		}

		private void InitAdsChest()
		{
			if (AdsChest == null)
			{
				AdsChest = new RewardChest();
				AdsChest.artikulId = ChestsContentMap.ChestSettings.ADS_CHEST_ARTIKUL_ID;
				AdsChest.state = RewardChestState.Taking;
				AdsChest.type = RewardChestType.Ads;
				if (InventoryContentMap.Artikuls.TryGetValue(AdsChest.artikulId, out adsArtikul_) && adsArtikul_.type_id == 5)
				{
					AdsChest.artikul = adsArtikul_;
					AdsChest.itemName = adsArtikul_.title;
					AdsChest.iconPath = adsArtikul_.GetFullLargeIconPath();
				}
			}
		}

		private void InitAssasinChest()
		{
			if (AssassinsChest == null)
			{
				AssassinsChest = new RewardChest();
				AssassinsChest.artikulId = ChestsContentMap.ChestSettings.ASSASSINS_CHEST_ARTIKUL_ID;
				AssassinsChest.state = RewardChestState.Taking;
				AssassinsChest.type = RewardChestType.Assassins;
				if (InventoryContentMap.Artikuls.TryGetValue(AssassinsChest.artikulId, out assassinsArtikul_) && assassinsArtikul_.type_id == 5)
				{
					AssassinsChest.artikul = assassinsArtikul_;
					AssassinsChest.itemName = assassinsArtikul_.title;
					AssassinsChest.iconPath = assassinsArtikul_.GetFullLargeIconPath();
				}
			}
		}

		private void InitDailyChest()
		{
			if (DailyChest == null)
			{
				DailyChest = new RewardChest();
				DailyChest.artikulId = ChestsContentMap.ChestSettings.DAILY_CHEST_ARTIKUL_ID;
				DailyChest.state = RewardChestState.Taking;
				DailyChest.type = RewardChestType.Daily;
				if (InventoryContentMap.Artikuls.TryGetValue(DailyChest.artikulId, out dailyArtikul_) && dailyArtikul_.type_id == 5)
				{
					DailyChest.artikul = dailyArtikul_;
					DailyChest.itemName = dailyArtikul_.title;
					DailyChest.iconPath = dailyArtikul_.GetFullLargeIconPath();
				}
			}
		}

		public override void Dispose()
		{
			adsManager_.AdsWached -= OpenAdsChest;
			GuiModuleHolder.Remove(chestsWindowBase);
			base.Dispose();
			AdsChest.Dispose();
			AssassinsChest.Dispose();
			DailyChest.Dispose();
			if (chestRewardInformer_ != null)
			{
				chestRewardInformer_.Clear();
				chestRewardInformer_.InformerClicked -= base.ToggleChestsWindow;
				chestRewardInformer_.AnimateChest -= OnAnimateInformerChest;
			}
		}

		private void OnAnimateInformerChest(string animation)
		{
			this.AnimateInformerChest.SafeInvoke(animation);
		}
	}
}
