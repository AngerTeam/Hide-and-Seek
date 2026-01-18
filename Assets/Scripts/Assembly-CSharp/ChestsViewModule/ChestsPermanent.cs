using ChestsViewModule.Content;
using NotificationsModule;
using PlayerModule.MyPlayer;
using RemoteData.Lua;
using SyncOnlineModule;

namespace ChestsViewModule
{
	public class ChestsPermanent : Singleton
	{
		private INotifications notificationsManager_;

		private MyPlayerStatsModel myPlayerStatsModel_;

		public int AssassinChestKills { get; private set; }

		public override void Init()
		{
			SingletonManager.Get<INotifications>(out notificationsManager_);
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
		}

		public override void OnLogicLoaded()
		{
			myPlayerStatsModel_.stats.combat.KillsCountChanged += OnKillsCountChanged;
		}

		private void OnKillsCountChanged()
		{
			if (AssassinChestKills + myPlayerStatsModel_.stats.combat.KillFragsCount >= ChestsContentMap.ChestSettings.assassinChestKills)
			{
				notificationsManager_.SetAssassinsChestNotification();
			}
		}

		public bool IsAssassinsChestReady()
		{
			return AssassinChestKills >= ChestsContentMap.ChestSettings.assassinChestKills;
		}

		public void NullifyAssassinsChest()
		{
			AssassinChestKills = 0;
		}

		public override void OnSyncRecieved()
		{
			PlayerChestsSyncMessage message;
			if (SyncManager.TryRead<PlayerChestsSyncMessage>(out message) && message.assassinChest != null && message.assassinChest.Length > 0)
			{
				AssassinChestKills = message.assassinChest[0].kills;
				if (IsAssassinsChestReady())
				{
					notificationsManager_.SetAssassinsChestNotification();
				}
				else
				{
					notificationsManager_.CancelAssassinsChestNotification();
				}
			}
		}
	}
}
