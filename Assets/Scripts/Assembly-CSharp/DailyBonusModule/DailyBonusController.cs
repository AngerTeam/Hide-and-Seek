using System;
using System.Collections.Generic;
using BankModule;
using ChestsViewModule;
using CraftyEngine.Content;
using CraftyEngine.Infrastructure;
using CraftyEngine.States;
using CraftyEngine.Utils;
using DailyBonusModule.RemoteData;
using ExpirienceModule;
using HttpNetwork;
using HudSystem;
using InventoryModule;
using MoneyModule;
using PlayerModule.MyPlayer;
using PurchasePopupModule;
using RemoteData;
using SyncOnlineModule;

namespace DailyBonusModule
{
	public class DailyBonusController : Singleton
	{
		private DailyBonusModel model_;

		private StateMachine machine_;

		private State stateInitialize_;

		private State stateAvalible_;

		private State stateNotAvalible_;

		private State stateRolling_;

		private State stateOpened_;

		private HttpOnlineManager http_;

		private MyPlayerStatsModel myPlayerStatsModel_;

		private PurchasePopupController purchasePopupController_;

		private BroadPurchaseOnline broadPurchaseOnline_;

		private DailyBonusWindow dailyBonusWindow_;

		private TimeManager timeManager_;

		private UnityTimerManager timerManager_;

		private UnityTimer timer_;

		private UnityEvent events_;

		private ChestsManager chestsManager_;

		public List<BonusItem> bonuses { get; private set; }

		public int TimeLeft
		{
			get
			{
				if (model_ == null)
				{
					return -1;
				}
				if (model_.endTime <= 0)
				{
					return -1;
				}
				if (timeManager_ == null)
				{
					return -1;
				}
				return model_.endTime - timeManager_.CurrentTimestamp;
			}
		}

		public bool IsBonusEnable
		{
			get
			{
				return TimeLeft <= 0;
			}
		}

		public bool IsModuleEnable
		{
			get
			{
				if (InventoryContentMap.Bonuses == null)
				{
					return false;
				}
				return InventoryContentMap.Bonuses.ContainsKey(DailyBonusContentMap.DailyBonusSettings.dailyBonusID);
			}
		}

		public DailyBonusController()
		{
			if (!SingletonManager.Contains<ExpirienceManager>())
			{
				Log.Error("Add ExpirienceManager before DailyBonusController for correct order of Sync responce");
			}
			if (!SingletonManager.TryGet<DailyBonusModel>(out model_))
			{
				model_ = SingletonManager.Add<DailyBonusModel>();
			}
		}

		public override void Dispose()
		{
			base.Dispose();
			if (dailyBonusWindow_ != null)
			{
				DailyBonusWindow dailyBonusWindow = dailyBonusWindow_;
				dailyBonusWindow.WindowShow = (Action)Delegate.Remove(dailyBonusWindow.WindowShow, new Action(OnWindowShow));
				DailyBonusWindow dailyBonusWindow2 = dailyBonusWindow_;
				dailyBonusWindow2.WindowHide = (Action)Delegate.Remove(dailyBonusWindow2.WindowHide, new Action(OnWindowHide));
			}
		}

		public override void OnSyncRecieved()
		{
			base.OnSyncRecieved();
			PlayerDailySyncMessage message;
			if (SyncManager.TryRead<PlayerDailySyncMessage>(out message) && message.dailyBonus != null && message.dailyBonus.Length > 0)
			{
				model_.startTime = (int)message.dailyBonus[0].bonusTime;
				model_.endTime = model_.startTime + DailyBonusContentMap.DailyBonusSettings.dailyBonusTimeout;
				chestsManager_.SetLuckyChestNotification(model_.endTime - timeManager_.CurrentTimestamp);
				Log.Info("===== Last bonus Time: {0} =====", model_.startTime);
			}
			else
			{
				model_.startTime = TimeUtils.DateTimeToUnixTimestamp(DateTime.Now);
				model_.endTime = model_.startTime;
				Log.Info("===== Default start and end time =====");
			}
			bonuses = BonusUtils.ExtractBonuses(DailyBonusContentMap.DailyBonusSettings.dailyBonusID, myPlayerStatsModel_.stats.experiance.level);
		}

		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<DailyBonusContentMap>();
			base.OnDataLoaded();
			dailyBonusWindow_ = GuiModuleHolder.GetOrAdd<DailyBonusWindow>();
			SingletonManager.Get<HttpOnlineManager>(out http_);
			SingletonManager.Get<UnityEvent>(out events_);
			SingletonManager.Get<BroadPurchaseOnline>(out broadPurchaseOnline_);
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			SingletonManager.Get<PurchasePopupController>(out purchasePopupController_);
			SingletonManager.Get<TimeManager>(out timeManager_);
			SingletonManager.Get<UnityTimerManager>(out timerManager_);
			SingletonManager.Get<ChestsManager>(out chestsManager_);
			DailyBonusWindow dailyBonusWindow = dailyBonusWindow_;
			dailyBonusWindow.WindowShow = (Action)Delegate.Combine(dailyBonusWindow.WindowShow, new Action(OnWindowShow));
			DailyBonusWindow dailyBonusWindow2 = dailyBonusWindow_;
			dailyBonusWindow2.WindowHide = (Action)Delegate.Combine(dailyBonusWindow2.WindowHide, new Action(OnWindowHide));
		}

		public BonusItem GetDailyBonusById(int id)
		{
			if (bonuses == null)
			{
				return null;
			}
			for (int i = 0; i < bonuses.Count; i++)
			{
				if (bonuses[i].artikulId == id)
				{
					return bonuses[i];
				}
			}
			return null;
		}

		public int GetDailyBonusIndex(BonusItem item)
		{
			if (bonuses == null)
			{
				return -1;
			}
			for (int i = 0; i < bonuses.Count; i++)
			{
				if (bonuses[i].artikulId == item.artikulId && bonuses[i].count == item.count)
				{
					return i;
				}
			}
			Log.Error("ERROR: Can't find bonus {0} with count {1} in list", item.artikulId, item.count);
			return -1;
		}

		public bool GetDailyBonusFree()
		{
			GetDailyBonusLuaCommand command = new GetDailyBonusLuaCommand();
			SingletonManager.Get<HttpOnlineManager>(out http_);
			http_.Send<GetDailyBonusResponse>(command, OnGetDailyBonusResponseReceived);
			return true;
		}

		public bool GetDailyBonus()
		{
			if (myPlayerStatsModel_.money.CrystalsAmount < DailyBonusContentMap.DailyBonusSettings.dailyBonusPrice)
			{
				myPlayerStatsModel_.money.ReportInsufficientMoney(MoneyTypesEntries.crystalId);
				return false;
			}
			return GetDailyBonusFree();
		}

		private void InitStates()
		{
			stateInitialize_ = new State("Initialize");
			stateAvalible_ = new State("Avalible");
			stateAvalible_.Entered += StartStateAvalible;
			stateNotAvalible_ = new State("NotAvalible");
			stateNotAvalible_.Entered += StartStateNotAvalible;
			stateRolling_ = new State("Rolling");
			stateRolling_.Entered += StartStateRolling;
			stateRolling_.Exited += ExitStateRolling;
			stateOpened_ = new State("Opened");
			stateOpened_.Entered += StartStateOpened;
			stateOpened_.Exited += ExitStateOpened;
			machine_ = new StateMachine(stateInitialize_, "DailyRewards");
			machine_.SetModel<DailyBonusModelInspector>(model_);
			stateInitialize_.AddTransaction(stateAvalible_, () => model_.avalible);
			stateInitialize_.AddTransaction(stateNotAvalible_, () => !model_.avalible);
			stateAvalible_.AddTransaction(stateNotAvalible_, () => !model_.avalible);
			stateAvalible_.AddTransaction(stateRolling_, () => model_.rolling);
			stateNotAvalible_.AddTransaction(stateAvalible_, () => model_.avalible);
			stateNotAvalible_.AddTransaction(stateRolling_, () => model_.rolling);
			stateRolling_.AddTransaction(stateOpened_, () => !model_.rolling);
			stateOpened_.AddTransaction(stateNotAvalible_, () => model_.collected);
		}

		private void DisposeStates()
		{
			machine_.Dispose();
			machine_ = null;
			stateInitialize_ = null;
			stateAvalible_.Entered -= StartStateAvalible;
			stateAvalible_ = null;
			stateNotAvalible_.Entered -= StartStateNotAvalible;
			stateNotAvalible_ = null;
			stateRolling_.Entered -= StartStateRolling;
			stateRolling_.Exited -= ExitStateRolling;
			stateRolling_ = null;
			stateOpened_.Entered -= StartStateOpened;
			stateOpened_.Exited -= ExitStateOpened;
			stateOpened_ = null;
		}

		private void Reset()
		{
			if (model_ != null)
			{
				model_.avalible = IsBonusEnable;
				model_.opened = false;
				model_.rolling = false;
				model_.collected = true;
				if (dailyBonusWindow_ != null)
				{
					dailyBonusWindow_.UpdateUIElements();
				}
			}
			else
			{
				Log.Error("ERROR: Daily Bonus Model Not Initialized.");
			}
		}

		private void Update()
		{
			if (machine_ != null)
			{
				machine_.Update();
			}
		}

		private void OnWindowShow()
		{
			events_.Subscribe(UnityEventType.Update, Update);
			timer_ = timerManager_.SetTimer();
			timer_.repeat = true;
			timer_.Completeted += OnTimerComplete;
			InitStates();
			Reset();
		}

		private void OnWindowHide()
		{
			events_.Unsubscribe(UnityEventType.Update, Update);
			timer_.Stop();
			timer_.Completeted -= OnTimerComplete;
			timer_ = null;
			DisposeStates();
			Reset();
		}

		private void OnGetDailyBonusResponseReceived(RemoteMessageEventArgs obj)
		{
			GetDailyBonusResponse getDailyBonusResponse = obj.remoteMessage as GetDailyBonusResponse;
			if (getDailyBonusResponse == null || getDailyBonusResponse.bonusItems == null || getDailyBonusResponse.bonusItems.Length == 0)
			{
				Log.Error("Bonuses not received");
				return;
			}
			model_.startTime = timeManager_.CurrentTimestamp;
			model_.endTime = model_.startTime + DailyBonusContentMap.DailyBonusSettings.dailyBonusTimeout;
			chestsManager_.SetLuckyChestNotification(model_.endTime - timeManager_.CurrentTimestamp);
			broadPurchaseOnline_.Report(getDailyBonusResponse);
			broadPurchaseOnline_.ExtractPurchaseItems(getDailyBonusResponse, true);
			BonusItemMessage bonusItemMessage = getDailyBonusResponse.bonusItems[0];
			BonusItem item = new BonusItem(bonusItemMessage.typeId, bonusItemMessage.field, bonusItemMessage.value, bonusItemMessage.value2, 0);
			int dailyBonusIndex = GetDailyBonusIndex(item);
			model_.avalible = IsBonusEnable;
			dailyBonusWindow_.SpinBonuses(dailyBonusIndex);
		}

		private void OnTimerComplete()
		{
			model_.avalible = IsBonusEnable;
			dailyBonusWindow_.UpdateUIElements();
		}

		private void SwitchState()
		{
			dailyBonusWindow_.SwitchState();
			Log.Info("SwitchState: ", machine_.CurrentState.Name);
		}

		private void StartStateAvalible()
		{
			dailyBonusWindow_.StartStateAvalible();
			Log.Info("StartStateAvalible");
		}

		private void StartStateNotAvalible()
		{
			dailyBonusWindow_.StartStateNotAvalible();
			Log.Info("StartStateNotAvalible");
		}

		private void StartStateRolling()
		{
			dailyBonusWindow_.StartStateRolling();
			purchasePopupController_.Pause();
			Log.Info("StartStateRolling");
		}

		private void ExitStateRolling()
		{
			dailyBonusWindow_.ExitStateRolling();
			Log.Info("ExitStateRolling");
		}

		private void StartStateOpened()
		{
			dailyBonusWindow_.StartStateOpened();
			Log.Info("StartStateOpened");
		}

		private void ExitStateOpened()
		{
			dailyBonusWindow_.ExitStateOpened();
			purchasePopupController_.Resume();
			purchasePopupController_.Show(false);
			Log.Info("ExitStateOpened");
		}
	}
}
