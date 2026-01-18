using System;
using Interlace.Amf;
using PlayerModule.MyPlayer;
using RemoteData;
using RemoteData.Socket;
using UnityEngine;

namespace CraftyNetworkEngine.Sockets
{
	public class SocketsPlayersOnline : SocketsOnlineManagerApi, IPlayersOnline, ISingleton
	{
		public const int STATUS_TIME_RATIO = 1000;

		private PlayerStateCommand cachedPlayerStateCommand_;

		private MyPlayerStatsModel myPlayerManager_;

		public event Action<RemoteMessageEventArgs> ActorsStatusChanged;

		public event Action<RemoteMessageEventArgs> PlayerExit;

		public event Action<RemoteMessageEventArgs> PlayerIn;

		public event Action<RemoteMessageEventArgs> PlayerSideChangeReceived;

		public event Action<RemoteMessageEventArgs> PlayerSpawn;

		public event Action<RemoteMessageEventArgs> SkinChangeReceived;

		public event Action<RemoteMessageEventArgs> SyncInstance;

		public override void Dispose()
		{
			sockets.CommandRecieved -= HandleCommand;
		}

		public override void Init()
		{
			base.Init();
			sockets.CommandRecieved += HandleCommand;
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerManager_);
			cachedPlayerStateCommand_ = new PlayerStateCommand(new VectorMessage(), new VectorMessage(), 0, 0);
		}

		public void ResyncInstance()
		{
			SendSyncInstance();
		}

		public void SendMyPlayerPosition()
		{
			if (myPlayerManager_.stats.reportSpawnPending)
			{
				myPlayerManager_.stats.reportSpawnPending = false;
				SendSpawn();
				return;
			}
			int time = (int)(Time.timeSinceLevelLoad * 1000f);
			Vector3 position = myPlayerManager_.stats.Position;
			Vector3 rotation = myPlayerManager_.stats.Rotation;
			cachedPlayerStateCommand_.position.x = position.x;
			cachedPlayerStateCommand_.position.y = position.y;
			cachedPlayerStateCommand_.position.z = position.z;
			cachedPlayerStateCommand_.rotation.x = rotation.x;
			cachedPlayerStateCommand_.rotation.y = rotation.y;
			cachedPlayerStateCommand_.rotation.z = rotation.z;
			cachedPlayerStateCommand_.action = myPlayerManager_.stats.networkAction;
			cachedPlayerStateCommand_.time = time;
			Send(cachedPlayerStateCommand_);
		}

		private void HandleCommand(string command, AmfObject obj)
		{
			if (command == "players_update")
			{
				ReportActorStatusChanged(obj);
				return;
			}
			switch (command)
			{
			case "player_in":
				HandlePlayerIn(obj);
				break;
			case "player_exit":
				HandlePlayerExit(obj);
				break;
			case "player_spawn":
				HandlePlayerSpawn(obj);
				break;
			case "change_skin":
				ReportSkinChangeReceived(obj);
				break;
			case "change_players_side":
				ReportSideChangeReceived(obj);
				break;
			}
		}

		private void HandlePlayerExit(AmfObject obj)
		{
			PlayerExitMessage remoteMessage = RemoteMessage.Read<PlayerExitMessage>(obj);
			this.PlayerExit(new RemoteMessageEventArgs(remoteMessage));
		}

		private void HandlePlayerIn(AmfObject obj)
		{
			PlayerInMessage remoteMessage = RemoteMessage.Read<PlayerInMessage>(obj);
			this.PlayerIn(new RemoteMessageEventArgs(remoteMessage));
		}

		private void HandlePlayerSpawn(AmfObject obj)
		{
			PlayerSpawnMessage remoteMessage = RemoteMessage.Read<PlayerSpawnMessage>(obj);
			this.PlayerSpawn(new RemoteMessageEventArgs(remoteMessage));
		}

		private void HandleSyncInstance(AmfObject obj)
		{
			SyncInstanceMessage remoteMessage = RemoteMessage.Read<SyncInstanceMessage>(obj);
			this.SyncInstance(new RemoteMessageEventArgs(remoteMessage));
		}

		private void ReportActorStatusChanged(AmfObject obj)
		{
			PlayersUpdateMessage remoteMessage = RemoteMessage.Read<PlayersUpdateMessage>(obj);
			this.ActorsStatusChanged(new RemoteMessageEventArgs(remoteMessage));
		}

		private void ReportSideChangeReceived(AmfObject obj)
		{
			ChangePlayersSideMessage remoteMessage = RemoteMessage.Read<ChangePlayersSideMessage>(obj);
			if (this.PlayerSideChangeReceived != null)
			{
				this.PlayerSideChangeReceived(new RemoteMessageEventArgs(remoteMessage));
			}
		}

		private void ReportSkinChangeReceived(AmfObject obj)
		{
			ChangeSkinMessage remoteMessage = RemoteMessage.Read<ChangeSkinMessage>(obj);
			if (this.SkinChangeReceived != null)
			{
				this.SkinChangeReceived(new RemoteMessageEventArgs(remoteMessage));
			}
		}

		private void SendSpawn()
		{
			SpawnCommand command = new SpawnCommand(new VectorMessage(myPlayerManager_.stats.Position));
			Send(command);
		}

		private void SendSyncInstance()
		{
			SyncInstanceCommand syncInstanceCommand = new SyncInstanceCommand();
			syncInstanceCommand.ResponceRecieved += HandleSyncInstance;
			Send(syncInstanceCommand);
		}
	}
}
