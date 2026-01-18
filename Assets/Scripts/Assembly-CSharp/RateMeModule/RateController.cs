using System;
using PlayerModule.MyPlayer;
using RateMeModule.RemoteData;
using SplashesModule;
using SyncOnlineModule;

namespace RateMeModule
{
	public class RateController : Singleton
	{
		private MyPlayerStatsModel myPlayerStatsModel_;

		private RateMeController rateMeController_;

		private GameModel model_;

		public bool ItWasAGoodBattle
		{
			get
			{
				return (myPlayerStatsModel_.stats.combat.KillFragsCount >= 1 || myPlayerStatsModel_.stats.BattleExperiance >= 1) && myPlayerStatsModel_.stats.place <= 5;
			}
		}

		private void RateDone()
		{
			model_.rated = true;
		}

		private void RateNotNeeded()
		{
			model_.rateNotNeeded = true;
		}

		public override void Init()
		{
			SingletonManager.Get<RateMeController>(out rateMeController_);
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			SingletonManager.Get<GameModel>(out model_);
		}

		public void Start()
		{
			model_.rated = false;
			model_.rateNotNeeded = false;
			if (!ItWasAGoodBattle)
			{
				RateNotNeeded();
				return;
			}
			AppRatingMessage appRatingMessage = null;
			bool flag = false;
			try
			{
				PlayerRatingSyncMessage message;
				if (SyncManager.TryRead<PlayerRatingSyncMessage>(out message) && message.appRating != null && message.appRating.Length == 1)
				{
					appRatingMessage = message.appRating[0];
				}
			}
			catch (Exception)
			{
				flag = true;
			}
			if (appRatingMessage == null)
			{
				flag = true;
			}
			else if (appRatingMessage.refusalForever == 0 && appRatingMessage.rewardTime.Equals(0.0))
			{
				double num = appRatingMessage.refusalTime + (double)(appRatingMessage.refusalCount * 86400);
				flag = num > (double)ContentStandart.GetUnixTimeStamp();
			}
			if (flag)
			{
				SingletonManager.Get<SplashScreenManager>().HideScreen();
				rateMeController_.RateDone -= RateDone;
				rateMeController_.RateDone += RateDone;
				rateMeController_.Rate();
			}
			else
			{
				RateNotNeeded();
			}
		}
	}
}
