using PlayerModule;
using RemoteData.Socket;

namespace CraftyNetworkEngine.Sockets
{
	public class GameStagesController : NetworkBasicPlayersManager
	{
		private GameModel gameModel_;

		private IGameOnline gameOnline_;

		private IPlayersOnline playersOnline_;

		public override void Dispose()
		{
			gameOnline_.StartStageReceived -= HandleStartStageReceived;
			playersOnline_.SyncInstance -= HandleSyncInstance;
		}

		public override void Init()
		{
			base.Init();
			SingletonManager.Get<IGameOnline>(out gameOnline_);
			SingletonManager.Get<GameModel>(out gameModel_);
			SingletonManager.Get<IPlayersOnline>(out playersOnline_);
			gameOnline_.StartStageReceived += HandleStartStageReceived;
			playersOnline_.SyncInstance += HandleSyncInstance;
		}

		private void HandleStartStageReceived(RemoteMessageEventArgs args)
		{
			StartStageMessage startStageMessage = (StartStageMessage)args.remoteMessage;
			UpdateStage(startStageMessage.stage, (int)startStageMessage.started);
		}

		private void HandleSyncInstance(RemoteMessageEventArgs obj)
		{
			SyncInstanceMessage syncInstanceMessage = (SyncInstanceMessage)obj.remoteMessage;
			UpdateStage(syncInstanceMessage.stage, (int)syncInstanceMessage.stageTime);
		}

		private void UpdateStage(int stageId, int starded)
		{
			StageModel value;
			if (!gameModel_.stages.TryGetValue(stageId, out value))
			{
				return;
			}
			value.started = starded;
			gameModel_.CurrentStage = value;
			foreach (PlayerStatsModel value2 in holder.Models.Values)
			{
				value2.AllowAttack = value.allowCombat;
			}
		}
	}
}
