using System;
using AdsModule.Content;
using CraftyEngine.Infrastructure;
using Extensions;
using PlayerModule.MyPlayer;

namespace AdsModule
{
	public class AdsManager : Singleton
	{
		private const int WAIT_FRAMES_COUNT = 10;

		private AppodealManager appodealManager_;

		private QueueManager queueManager_;

		private UnityEvent unityEvent_;

		private TimeManager timeManager_;

		private MyPlayerStatsModel myPlayerStatsModel_;

		private Action videoShownCallback_;

		private bool waitForRewardVideo_;

		private int waitFrames_;

		private int lastNonRewardedAdTimestamp_;

		public int LastViewTime { get; private set; }

		public event Action AdsWached;

		public override void Init()
		{
			SingletonManager.Get<AppodealManager>(out appodealManager_);
			SingletonManager.Get<QueueManager>(out queueManager_);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			SingletonManager.Get<TimeManager>(out timeManager_);
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			AppodealManager appodealManager = appodealManager_;
			appodealManager.VideoShown = (Action)Delegate.Combine(appodealManager.VideoShown, new Action(OnVideoShown));
			AppodealManager appodealManager2 = appodealManager_;
			appodealManager2.VideoFailed = (Action)Delegate.Combine(appodealManager2.VideoFailed, new Action(OnVideoFailed));
		}

		public void SetLastViewTime(int viewTime)
		{
			LastViewTime = viewTime;
		}

		public bool IsVideoAvailable()
		{
			return appodealManager_.IsLoaded() && IsAvailableByTime();
		}

		public bool IsAvailableByTime()
		{
			return GetTimeLeft() <= 0;
		}

		public int GetTimeLeft()
		{
			return LastViewTime + AdsContentMap.AdsSettings.adChestTimeout - timeManager_.CurrentTimestamp;
		}

		public bool IsNonRewardedAdAvailableByTime()
		{
			return lastNonRewardedAdTimestamp_ == 0 || lastNonRewardedAdTimestamp_ + AdsContentMap.AdsSettings.adShowingCooldown <= timeManager_.CurrentTimestamp;
		}

		public bool TryShowNonRewardedAd(Action videoShownCallback = null)
		{
			if (IsNonRewardedAdAvailableByTime() && !myPlayerStatsModel_.money.IsPayer && appodealManager_.IsLoaded() && !DataStorage.isAdmin)
			{
				waitForRewardVideo_ = false;
				videoShownCallback_ = videoShownCallback;
				appodealManager_.ShowVideo();
				return true;
			}
			videoShownCallback.SafeInvoke();
			return false;
		}

		public void TryShowAd()
		{
			if (IsVideoAvailable())
			{
				waitForRewardVideo_ = true;
				appodealManager_.ShowVideo();
			}
		}

		private void OnVideoShown()
		{
			if (waitForRewardVideo_)
			{
				queueManager_.AddTask(DeferredGiveReward);
				return;
			}
			lastNonRewardedAdTimestamp_ = timeManager_.CurrentTimestamp;
			videoShownCallback_.SafeInvoke();
		}

		private void OnVideoFailed()
		{
			if (waitForRewardVideo_)
			{
				waitForRewardVideo_ = false;
				return;
			}
			lastNonRewardedAdTimestamp_ = timeManager_.CurrentTimestamp;
			videoShownCallback_.SafeInvoke();
		}

		private void DeferredGiveReward()
		{
			if (waitForRewardVideo_)
			{
				waitForRewardVideo_ = false;
				waitFrames_ = 0;
				unityEvent_.Subscribe(UnityEventType.Update, SendAdView);
			}
		}

		private void SendAdView()
		{
			if (waitFrames_ >= 10)
			{
				unityEvent_.Unsubscribe(UnityEventType.Update, SendAdView);
				this.AdsWached.SafeInvoke();
				LastViewTime = timeManager_.CurrentTimestamp;
			}
			else
			{
				waitFrames_++;
			}
		}

		public override void Dispose()
		{
		}
	}
}
