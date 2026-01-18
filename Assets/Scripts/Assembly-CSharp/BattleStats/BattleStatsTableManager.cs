using System;
using CraftyEngine.Infrastructure;
using CraftyNetworkEngine;
using Extensions;
using HudSystem;
using PlayerModule;
using PlayerModule.MyPlayer;
using RemoteData.Socket;

namespace BattleStats
{
	public class BattleStatsTableManager : Singleton
	{
		private int autoCloseIn_;

		private MyPlayerStatsModel myPlayerStatsModel_;

		private NetworkPlayersManager networkPlayersManager_;

		private PlayerModelsHolder playersHolder_;

		private IGameOnline gameOnline_;

		private GameModel gameModel_;

		private ScoreCounterHud scoreCounterHud_;

		public TeamStats[] TeamStats { get; private set; }

		public BattleStatsTableWindow Window { get; private set; }

		public event Action HomeСlicked;

		public event Action NextClicked;

		public event Action ContinueClicked;

		public override void Dispose()
		{
			playersHolder_.ModelAdded -= Refresh;
			playersHolder_.ModelRemoved -= Refresh;
			playersHolder_.ModelChanged -= Refresh;
			playersHolder_.StatsChanged -= Refresh;
			myPlayerStatsModel_.stats.BattleExperianceChanged -= Refresh;
			myPlayerStatsModel_.stats.combat.KillsCountChanged -= Refresh;
			playersHolder_.ModelWillBeRemoved -= HandleModelRemoved;
			gameOnline_.StartStageReceived -= HandleStartStageReceived;
			networkPlayersManager_.StatsUpdated -= ShowResult;
			NetworkBasicPlayersManager.StatsRecieved -= SetTeamStats;
			if (Window != null)
			{
				Window.ViewChanged -= OnWindowToggledHandler;
				Window.HomeButtonClicked -= HomeButtonСlicked;
				Window.NextButtonClicked -= NextButtonСlicked;
				Window.ContinueButtonClicked -= ContinueButtonСlicked;
				Window.Dispose();
				Window = null;
			}
			GuiModuleHolder.Remove<PlayerStatsHud>();
			GuiModuleHolder.Remove<ScoreCounterHud>();
		}

		private void HomeButtonСlicked()
		{
			SetWindowStatus(false);
			this.HomeСlicked.SafeInvoke();
		}

		private void NextButtonСlicked()
		{
			SetWindowStatus(false);
			this.NextClicked.SafeInvoke();
		}

		private void ContinueButtonСlicked()
		{
			SetWindowStatus(false);
			this.ContinueClicked.SafeInvoke();
		}

		public override void Init()
		{
			SingletonManager.Get<NetworkPlayersManager>(out networkPlayersManager_);
			SingletonManager.Get<PlayerModelsHolder>(out playersHolder_);
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			SingletonManager.Get<IGameOnline>(out gameOnline_);
			SingletonManager.Get<GameModel>(out gameModel_);
			TeamStats = new TeamStats[2]
			{
				new TeamStats(),
				new TeamStats()
			};
			GuiModuleHolder.Add<PlayerStatsHud>();
			GuiModuleHolder.Add<ScoreCounterHud>();
			gameOnline_.StartStageReceived += HandleStartStageReceived;
			playersHolder_.ModelWillBeRemoved += HandleModelRemoved;
			networkPlayersManager_.StatsUpdated += ShowResult;
			NetworkBasicPlayersManager.StatsRecieved += SetTeamStats;
		}

		public override void OnDataLoaded()
		{
			InitWindow();
			myPlayerStatsModel_.stats.place = int.MaxValue;
			myPlayerStatsModel_.stats.reward = 0;
			GuiModuleHolder.Get<PlayerStatsHud>().CounterClicked += ToggleStatsTable;
		}

		public void InitWindow()
		{
			BattleStatsTableFormat format = ((gameModel_.battleStatsTableFormat != null) ? gameModel_.battleStatsTableFormat : new BattleStatsTableDefaultFormat());
			Window = new BattleStatsTableWindow(format);
			Window.HomeButtonClicked += HomeButtonСlicked;
			Window.NextButtonClicked += NextButtonСlicked;
			Window.ContinueButtonClicked += ContinueButtonСlicked;
			Window.ViewChanged += OnWindowToggledHandler;
			GuiModuleHolder.Get<ScoreCounterHud>(out scoreCounterHud_);
		}

		public void SetCloseButton(bool active)
		{
			Window.SetCloseButton(active);
		}

		public void SetTeamStats(TeamDataMessage[] teamData, int playerSide)
		{
			for (int i = 0; i < teamData.Length; i++)
			{
				TeamDataMessage teamDataMessage = teamData[i];
				TeamStats teamStats = TeamStats[i];
				teamStats.side = teamDataMessage.side;
				teamStats.isMyPlayerTeam = teamDataMessage.side == playerSide;
				teamStats.kills = teamDataMessage.kills;
				teamStats.leavers = teamDataMessage.leave;
				if (scoreCounterHud_ != null)
				{
					scoreCounterHud_.SetScore(teamStats.kills, teamStats.isMyPlayerTeam);
				}
			}
			Window.SetTeamStats(TeamStats);
		}

		public void SetTimer(string time, bool critical)
		{
			if (Window != null)
			{
				Window.SetTimer(time, critical);
			}
		}

		public void SetWindowStatus(bool isVisible)
		{
			if (Window.Visible == !isVisible)
			{
				Window.ToggleWindow();
			}
		}

		public void ToggleStatsTable()
		{
			if (gameModel_.gameMode.allowStats)
			{
				Window.ToggleWindow();
			}
		}

		private void HandleModelRemoved(PlayerStatsModel model)
		{
			TeamStats[] teamStats = TeamStats;
			foreach (TeamStats teamStats2 in teamStats)
			{
				if (teamStats2.isMyPlayerTeam == model.InMyPlayerTeam)
				{
					teamStats2.leavers++;
					break;
				}
			}
			Window.SetTeamStats(TeamStats);
		}

		private void HandleStartStageReceived(RemoteMessageEventArgs obj)
		{
			autoCloseIn_--;
			if (autoCloseIn_ == 0 && Window.Visible)
			{
				Window.Continue();
			}
		}

		public override void OnSyncRecieved()
		{
			playersHolder_.ModelAdded -= Refresh;
			playersHolder_.ModelRemoved -= Refresh;
			playersHolder_.ModelChanged -= Refresh;
			playersHolder_.StatsChanged -= Refresh;
			myPlayerStatsModel_.stats.BattleExperianceChanged -= Refresh;
			myPlayerStatsModel_.stats.combat.KillsCountChanged -= Refresh;
			playersHolder_.ModelAdded += Refresh;
			playersHolder_.ModelRemoved += Refresh;
			playersHolder_.ModelChanged += Refresh;
			playersHolder_.StatsChanged += Refresh;
			myPlayerStatsModel_.stats.BattleExperianceChanged += Refresh;
			myPlayerStatsModel_.stats.combat.KillsCountChanged += Refresh;
			Window.SetWindowType(BattleStatsTableType.Basic);
			Refresh();
		}

		private void OnWindowToggledHandler(object sender, BoolEventArguments e)
		{
			Refresh();
		}

		private void Refresh(PlayerStatsModel model)
		{
			Refresh();
		}

		private void Refresh(string obj)
		{
			Refresh();
		}

		private void Refresh()
		{
			if (Window != null && Window.Visible)
			{
				Window.UpdateTable();
			}
		}

		private void ShowResult()
		{
			Window.SetWindowType(BattleStatsTableType.Result);
			SetWindowStatus(true);
			Refresh();
			Window.Lock();
			autoCloseIn_ = 2;
		}
	}
}
