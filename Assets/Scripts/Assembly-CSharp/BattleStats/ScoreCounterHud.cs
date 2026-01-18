using HudSystem;
using PlayerModule.MyPlayer;
using UnityEngine;

namespace BattleStats
{
	public class ScoreCounterHud : HeadUpDisplay
	{
		private BattleStatsTableManager battleStatsTableManager_;

		private UIScoreWidgetHierarchy scoreWidget_;

		private GameModel gameModel_;

		private MyPlayerStatsModel player_;

		private string currentStageName_;

		public int stageNameCount;

		public ScoreCounterHud()
		{
			SingletonManager.Get<GameModel>(out gameModel_);
			SingletonManager.Get<MyPlayerStatsModel>(out player_);
			gameModel_.StageChanged += HandleStageChanged;
			player_.stats.SideChanged += HandleStageChanged;
			prefabsManager.Load("BattleStatsPrefabsHolder");
			scoreWidget_ = prefabsManager.InstantiateNGUIIn<UIScoreWidgetHierarchy>("UIScoreWidget", nguiManager.UiRoot.TopCenterContainer.gameObject);
			hudStateSwitcher.Register(262144, scoreWidget_);
			hudStateSwitcher.Register(524288, scoreWidget_.teamsWidget);
			ButtonSet.Up(scoreWidget_.button, HandleScoreClick, ButtonSetGroup.Hud);
			ButtonSet.Up(scoreWidget_.widget, ButtonSetGroup.Hud);
			HandleStageChanged();
		}

		public void RefreshNotification()
		{
			string text = ((!string.IsNullOrEmpty(currentStageName_)) ? Localisations.Get(currentStageName_) : string.Empty);
			text = text.Replace("%count%", stageNameCount.ToString());
			SetNotification(text);
		}

		private void HandleStageChanged()
		{
			currentStageName_ = gameModel_.GetStageName(player_.stats.Side);
			RefreshNotification();
		}

		public override void Resubscribe()
		{
			SingletonManager.TryGet<BattleStatsTableManager>(out battleStatsTableManager_);
		}

		public void SetNotification(string text)
		{
			scoreWidget_.notificationLabel.text = text;
		}

		public void SetTimer(string text, bool critical)
		{
			scoreWidget_.timeLabel.text = text;
			if (critical)
			{
				scoreWidget_.timeLabel.color = Color.red;
				scoreWidget_.timeLabelTweenScale.ResetToBeginning();
				scoreWidget_.timeLabelTweenScale.PlayForward();
			}
			else
			{
				scoreWidget_.timeLabel.color = Color.white;
			}
		}

		public void SetScore(int teamScore, bool isMyTeam)
		{
			if (isMyTeam)
			{
				scoreWidget_.myTeamScore.text = teamScore.ToString();
			}
			else
			{
				scoreWidget_.enemyTeamScore.text = teamScore.ToString();
			}
		}

		private void HandleScoreClick()
		{
			if (battleStatsTableManager_ != null)
			{
				battleStatsTableManager_.ToggleStatsTable();
			}
		}

		public override void Dispose()
		{
			gameModel_.StageChanged -= HandleStageChanged;
			player_.stats.SideChanged -= HandleStageChanged;
			Object.Destroy(scoreWidget_.gameObject);
		}
	}
}
