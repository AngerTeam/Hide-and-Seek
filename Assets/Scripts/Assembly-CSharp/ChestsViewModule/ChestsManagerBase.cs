using System;
using System.Collections.Generic;
using ChestsViewModule.Content;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using Extensions;
using InventoryModule;
using Modules.PerfomanceTests;
using MoneyModule;
using NguiTools;
using PlayerModule.MyPlayer;
using RemoteData.Lua;
using SyncOnlineModule;
using UnityEngine;
using WindowsModule;

namespace ChestsViewModule
{
	public abstract class ChestsManagerBase : Singleton
	{
		protected ChestOpener chestOpener;

		protected ChestsWindowBase chestsWindowBase;

		private MyPlayerStatsModel myPlayerStatsModel_;

		private NguiManager nguiManager_;

		protected TimeManager timeManager_;

		private WindowsManager windowsManager_;

		private UnityTimer timer_;

		private UnityTimerManager unityTimerManager_;

		public RewardChest OpeningChest { get; private set; }

		public List<RewardChest> RewardChests { get; private set; }

		public event Action SendOpenAssassinsChest;

		public event Action<int, int> SendOpenChest;

		public event Action<int> SendStartChest;

		public override void Init()
		{
			RewardChests = new List<RewardChest>();
			SingletonManager.Get<TimeManager>(out timeManager_);
			SingletonManager.Get<WindowsManager>(out windowsManager_);
			SingletonManager.Get<NguiManager>(out nguiManager_);
			SingletonManager.Get<ChestOpener>(out chestOpener);
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			SingletonManager.Get<UnityTimerManager>(out unityTimerManager_);
			windowsManager_.WindowsCountChanged += OnWindowsCountChanged;
		}

		protected void SendAssassinsChestOpen()
		{
			this.SendOpenAssassinsChest.SafeInvoke();
		}

		protected abstract void SetChestOpenNotification(int seconds);

		protected abstract void CancelChestOpenNotification();

		protected abstract void SetChestGotIdleNotification();

		public override void OnDataLoaded()
		{
			timer_ = unityTimerManager_.SetTimer();
			timer_.repeat = true;
			timer_.Completeted += HandleTimer;
			SetChestsCamerasMode();
		}

		public static int GetCurrentBoostPrice(RewardChest rewardChest, int currentTime)
		{
			int result = 0;
			if (rewardChest.state == RewardChestState.Opening)
			{
				int num = rewardChest.EndTime - currentTime;
				result = Mathf.CeilToInt((float)rewardChest.boostPrice * (float)num / (float)rewardChest.timeToOpen);
			}
			else if (rewardChest.state == RewardChestState.Idle)
			{
				result = rewardChest.boostPrice;
			}
			return result;
		}

		public static bool GotEmptyRewardChestsSlots(bool considerReward = true)
		{
			int rewardChestsMaxCount = ChestsContentMap.ChestSettings.rewardChestsMaxCount;
			if (rewardChestsMaxCount == 0)
			{
				return true;
			}
			MyPlayerStatsModel myPlayerStatsModel = SingletonManager.Get<MyPlayerStatsModel>();
			int num = ((!considerReward || myPlayerStatsModel.stats.reward <= 0) ? DataStorage.rewardChestsCount : (DataStorage.rewardChestsCount + 1));
			return num < rewardChestsMaxCount;
		}

		public void StartOpeningChest(int startTime)
		{
			if (OpeningChest != null)
			{
				OpeningChest.startTime = startTime;
			}
		}

		private void SetChestsCamerasMode()
		{
			PerfomanceTestsUtility singlton;
			SingletonManager.Get<PerfomanceTestsUtility>(out singlton);
			UI3DHierarchy.Perspective = singlton.supportPerspectiveCameras;
		}

		public void OpenChest(RewardChest rewardChest)
		{
			int currentBoostPrice = GetCurrentBoostPrice(rewardChest, timeManager_.CurrentTimestamp);
			if (rewardChest.state != RewardChestState.Completed && myPlayerStatsModel_.money.CrystalsAmount < currentBoostPrice)
			{
				myPlayerStatsModel_.money.ReportInsufficientMoney(MoneyTypesEntries.crystalId);
				return;
			}
			this.SendOpenChest(rewardChest.slotId, currentBoostPrice);
			RewardChests.Remove(rewardChest);
			chestsWindowBase.FillRewardChestSlots();
			UpdateChests();
			rewardChest.state = RewardChestState.Taking;
			chestOpener.selectedChestWindow.OpenWindow(rewardChest);
			DataStorage.rewardChestsCount = RewardChests.Count;
			if (rewardChest.type == RewardChestType.Normal)
			{
				rewardChest.Dispose();
				CancelChestOpenNotification();
				if (RewardChests.Count > 0 && OpeningChest == null)
				{
					SetChestGotIdleNotification();
				}
			}
		}

		public void OpenSelectedChestWindow(RewardChest rewardChest)
		{
			chestOpener.selectedChestWindow.OpenWindow(rewardChest);
		}

		public void StartChest(RewardChest rewardChest)
		{
			if (OpeningChest == null && rewardChest.state == RewardChestState.Idle)
			{
				rewardChest.startTime = timeManager_.CurrentTimestamp;
				UpdateChests();
				this.SendStartChest.SafeInvoke(rewardChest.slotId);
				if (rewardChest.type == RewardChestType.Normal)
				{
					SetChestOpenNotification(rewardChest.timeToOpen);
				}
			}
		}

		public void ToggleChestsWindow()
		{
			chestsWindowBase.ToggleWindow();
		}

		public override void OnSyncRecieved()
		{
			PlayerChestsSyncMessage message;
			if (SyncManager.TryRead<PlayerChestsSyncMessage>(out message) && message.chestSlots != null)
			{
				FillRewardChests(message.chestSlots);
			}
		}

		private void FillRewardChests(ChestSlotsMessage[] chestSlotMessages)
		{
			MyPlayerStatsModel myPlayerStatsModel = SingletonManager.Get<MyPlayerStatsModel>();
			myPlayerStatsModel.stats.reward = 0;
			RewardChests = new List<RewardChest>();
			foreach (ChestSlotsMessage chestSlotsMessage in chestSlotMessages)
			{
				if (chestSlotsMessage.artikulId != 0)
				{
					RewardChest rewardChest = new RewardChest();
					rewardChest.slotId = chestSlotsMessage.slotId;
					rewardChest.artikulId = chestSlotsMessage.artikulId;
					rewardChest.startTime = (int)chestSlotsMessage.startTime;
					rewardChest.type = RewardChestType.Normal;
					ArtikulsEntries value;
					if (InventoryContentMap.Artikuls.TryGetValue(rewardChest.artikulId, out value) && value.type_id == 5)
					{
						rewardChest.artikul = value;
						rewardChest.timeToOpen = value.chest_open_time;
						rewardChest.boostPrice = value.chest_boost_price;
						rewardChest.bonusId = value.chest_bonus_id;
						rewardChest.itemName = value.title;
						rewardChest.iconPath = value.GetFullLargeIconPath();
						rewardChest.view.Instantiate(value.model_id, 1.4f);
					}
					else
					{
						Log.Error("No chest artikul with id:" + rewardChest.artikulId);
					}
					RewardChests.Add(rewardChest);
				}
			}
			DataStorage.rewardChestsCount = RewardChests.Count;
			if (chestsWindowBase != null)
			{
				chestsWindowBase.FillRewardChestSlots();
			}
			UpdateChests();
		}

		protected void UpdateChests()
		{
			bool flag = false;
			int num = 0;
			bool flag2 = false;
			bool flag3 = false;
			foreach (RewardChest rewardChest in RewardChests)
			{
				if (UpdateChestState(rewardChest))
				{
					OpeningChest = rewardChest;
					flag = true;
				}
				if (rewardChest.state == RewardChestState.Completed)
				{
					flag2 = true;
				}
				if (rewardChest.state == RewardChestState.Idle)
				{
					flag3 = true;
				}
			}
			if (!flag)
			{
				OpeningChest = null;
			}
			if (flag2)
			{
				num++;
			}
			else if (flag3 && !flag)
			{
				num++;
			}
			num += ExtraChestsReady();
			UpdateInformer(flag2, flag, flag3 && !flag);
			SetCountInformer(num);
			if (chestsWindowBase != null)
			{
				chestsWindowBase.UpdateRewardChests();
			}
			if (chestOpener.selectedChestWindow != null)
			{
				chestOpener.selectedChestWindow.UpdateView();
			}
		}

		protected virtual int ExtraChestsReady()
		{
			return 0;
		}

		private void HandleTimer()
		{
			UpdateChests();
		}

		private void OnWindowsCountChanged()
		{
			GameWindow frontWindow = windowsManager_.FrontWindow;
			if (frontWindow != null && chestsWindowBase != null)
			{
				if (frontWindow == chestsWindowBase)
				{
					nguiManager_.UiRoot.ChestsLight.gameObject.SetActive(true);
				}
				else if (frontWindow == chestOpener.selectedChestWindow)
				{
					nguiManager_.UiRoot.ChestsLight.gameObject.SetActive(true);
				}
				else if (chestsWindowBase.Visible)
				{
					nguiManager_.UiRoot.ChestsLight.gameObject.SetActive(false);
				}
			}
		}

		private bool UpdateChestState(RewardChest rewardChest)
		{
			if (rewardChest.startTime == 0)
			{
				rewardChest.state = RewardChestState.Idle;
			}
			else
			{
				if (timeManager_.CurrentTimestamp < rewardChest.EndTime)
				{
					rewardChest.state = RewardChestState.Opening;
					return true;
				}
				rewardChest.state = RewardChestState.Completed;
			}
			return false;
		}

		protected abstract void SetCountInformer(int count);

		protected abstract void UpdateInformer(bool anyCompleted, bool chestIsOpening, bool startNow);

		public static void CheckEmptyRewardChestsSlots(Action yesAction, Action noAction = null)
		{
			if (GotEmptyRewardChestsSlots())
			{
				yesAction();
			}
			else if (DataStorage.isAdmin)
			{
				Log.Warning("Admin: ignoring no free slots for chests is avalible!");
				yesAction();
			}
			else
			{
				DialogWindowManager dialogWindowManager = SingletonManager.Get<DialogWindowManager>();
				string message = Localisations.Get("UI_NoRewardChestsSlotsWarning");
				dialogWindowManager.ShowDialogue(message, yesAction, noAction);
			}
		}

		public override void Dispose()
		{
			foreach (RewardChest rewardChest in RewardChests)
			{
				rewardChest.Dispose();
			}
			chestsWindowBase.Dispose();
			chestsWindowBase = null;
			if (timer_ != null)
			{
				timer_.Stop();
				timer_.Completeted -= HandleTimer;
				timer_ = null;
			}
			windowsManager_.WindowsCountChanged -= OnWindowsCountChanged;
		}
	}
}
