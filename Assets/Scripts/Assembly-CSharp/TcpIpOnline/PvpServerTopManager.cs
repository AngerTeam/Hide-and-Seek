using System;
using AuthorizationGame;
using BattleStats;
using CraftyEngine.Infrastructure;
using CraftyNetworkEngine;
using CraftyNetworkEngine.Sockets;
using HttpNetwork;
using InventoryOnlineModule;
using PlayerModule;
using TcpIpVoxels;

namespace TcpIpOnline
{
	public class PvpServerTopManager : IDisposable
	{
		private OnlineConnectionController connectionController_;

		private PvpAuthorizationModel pvpModel_;

		private UnityEvent unityEvent_;

		private IGameOnline gameOnline_;

		public static void InitModule(int layer)
		{
			OnlineConnectionController.InitModule();
			SingletonManager.AddAlias<SocketsPlayersOnline, IPlayersOnline>(layer);
			SingletonManager.Add<NetworkPlayersManager>(layer);
			SingletonManager.AddAlias<SocketsVoxelsOnline, IVoxelsOnline>(layer);
			SingletonManager.Add<NetworkVoxelsManager>(layer);
			SingletonManager.AddAlias<SocketsInventoryOnline, IInventoryOnline>(layer);
			SingletonManager.Add<NetworkInventoryManager>(layer);
			SingletonManager.AddAlias<SocketsShopOnline, IShopOnline>(layer);
			SingletonManager.Add<PlayerModelsHolder>(layer);
			SingletonManager.Add<PlaymatesActorsHolder>(layer);
			SingletonManager.Add<BattleStatsTableManager>(layer);
			SingletonManager.Add<GameStagesController>(layer);
		}

		public void Dispose()
		{
			pvpModel_.Reset();
		}

		public void EnterServer(bool autoReady)
		{
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			SingletonManager.Get<PvpAuthorizationModel>(out pvpModel_);
			SingletonManager.Get<IGameOnline>(out gameOnline_);
			SingletonManager.Get<OnlineConnectionController>(out connectionController_);
			pvpModel_.autoSendReady = autoReady;
			if (!pvpModel_.alreadyInPvp)
			{
				pvpModel_.serverUrl = null;
			}
			unityEvent_.Subscribe(UnityEventType.Update, Update);
			connectionController_.Connected += HandleConnected;
			if (pvpModel_.alreadyInPvp)
			{
				Connect();
				return;
			}
			GameServerOnlineController gameServerOnlineController = new GameServerOnlineController();
			gameServerOnlineController.SendEnterPvp();
		}

		private void Connect()
		{
			connectionController_.Connect();
		}

		private void HandleConnected()
		{
			if (pvpModel_.autoSendReady)
			{
				gameOnline_.ReadyResponseReceived += HandleReadyResponseReceived;
				gameOnline_.SendReady();
			}
		}

		private void HandleReadyResponseReceived(RemoteMessageEventArgs obj)
		{
			Log.Info("Ready response recieved");
		}

		private void Update()
		{
			if (pvpModel_.enteredPvp)
			{
				unityEvent_.Unsubscribe(UnityEventType.Update, Update);
				Connect();
			}
		}
	}
}
