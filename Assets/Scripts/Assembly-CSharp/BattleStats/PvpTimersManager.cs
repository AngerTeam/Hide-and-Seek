using CraftyEngine.Infrastructure;
using CraftyEngine.Sounds;
using CraftyEngine.Utils;
using HudSystem;

namespace BattleStats
{
	public class PvpTimersManager : Singleton
	{
		protected TimeManager timeManager;

		private UnityTimerManager unityTimerManager_;

		private UnityTimer timer_;

		private GameModel model_;

		private ScoreCounterHud hud_;

		private BattleStatsTableManager tableManager_;

		public override void Init()
		{
			SingletonManager.Get<TimeManager>(out timeManager);
			SingletonManager.Get<UnityTimerManager>(out unityTimerManager_);
			SingletonManager.Get<GameModel>(out model_);
			SingletonManager.Get<BattleStatsTableManager>(out tableManager_);
		}

		public override void OnDataLoaded()
		{
			GuiModuleHolder.Get<ScoreCounterHud>(out hud_);
			timer_ = unityTimerManager_.SetTimer();
			timer_.repeat = true;
			timer_.Completeted += HandleTimer;
		}

		public override void Dispose()
		{
			timer_.Stop();
			timer_ = null;
		}

		private void HandleTimer()
		{
			if (model_.CurrentStage != null)
			{
				int secondsLeft = TimeUtils.GetSecondsLeft(timeManager.CurrentTimestamp, model_.CurrentStage.started + model_.CurrentStage.duration);
				bool flag = model_.CurrentStage.criticalTime && secondsLeft <= 10 && secondsLeft > 0;
				if (flag)
				{
					SoundProvider.PlaySingleSound2D(65);
				}
				string text = TimeUtils.ToTimerCounter(secondsLeft);
				hud_.SetTimer(text, flag);
				tableManager_.SetTimer(text, flag);
			}
		}
	}
}
