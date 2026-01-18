using System;
using BattleStats;
using CraftyNetworkEngine;
using TcpIpOnline;

namespace PrimeModule
{
	public class PrimeGameExitController : IDisposable
	{
		private BattleStatsTableManager tableManager_;

		private GameModel gameModel_;

		private IGameOnline gameOnline_;

		private PrimeConnectModel primeModel_;

		private bool exited_;

		public PrimeGameExitController(PrimeConnectModel primeModel, PvpServerTopManager pvpServerTopManager)
		{
			primeModel_ = primeModel;
			SingletonManager.Get<BattleStatsTableManager>(out tableManager_);
			SingletonManager.Get<IGameOnline>(out gameOnline_);
			SingletonManager.Get<GameModel>(out gameModel_);
			gameOnline_.InstanceResultsRecieved += HandleInstanceResultsRecieved;
			tableManager_.HomeСlicked += ExitPrimeState;
			tableManager_.ContinueClicked += HandleContinueClicked;
			tableManager_.NextClicked += RepeatCurrentGame;
			tableManager_.Window.allowContinue = gameModel_.gameMode.continuable;
		}

		private void HandleContinueClicked()
		{
		}

		public void ExitByUser()
		{
			if (!exited_)
			{
				exited_ = true;
				SingletonManager.Get<OnlineConnectionController>().allowReocnnect = false;
				NetworkPlayersManager networkPlayersManager = SingletonManager.Get<NetworkPlayersManager>();
				networkPlayersManager.enabled = false;
				gameOnline_.PvpExitSent += ExitPrimeState;
				gameOnline_.SendExitPvp();
			}
		}

		private void HandleInstanceResultsRecieved(RemoteMessageEventArgs obj)
		{
			if (!gameModel_.gameMode.continuable)
			{
				primeModel_.instanceStopped = true;
			}
		}

		public void CloseStatsWindow()
		{
			if (tableManager_.Window.Visible)
			{
				tableManager_.ToggleStatsTable();
			}
			tableManager_.SetCloseButton(true);
		}

		public void Dispose()
		{
			if (tableManager_.Window != null)
			{
				tableManager_.Window.allowContinue = false;
			}
			gameOnline_.PvpExitSent -= ExitPrimeState;
			gameOnline_.InstanceResultsRecieved -= HandleInstanceResultsRecieved;
			tableManager_.HomeСlicked -= ExitPrimeState;
			tableManager_.ContinueClicked -= HandleContinueClicked;
			tableManager_.NextClicked -= RepeatCurrentGame;
		}

		public void ShowLoadout()
		{
			tableManager_.SetCloseButton(false);
			tableManager_.ToggleStatsTable();
		}

		private void ExitPrimeState()
		{
			exited_ = true;
			gameModel_.prime = false;
			if (!gameModel_.primeRepeat)
			{
				gameModel_.lobby = true;
			}
		}

		private void RepeatCurrentGame()
		{
			gameModel_.primeRepeat = true;
			if (gameModel_.gameMode.continuable)
			{
				ExitByUser();
			}
			else
			{
				gameModel_.prime = false;
			}
		}
	}
}
