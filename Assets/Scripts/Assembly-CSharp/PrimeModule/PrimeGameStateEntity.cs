using System;
using CraftyEngine.States;
using CraftyNetworkEngine.Chat;
using CraftyNetworkEngine.Sockets;
using ExceptionsModule;
using SplashesModule;
using TcpIpOnline;

namespace PrimeModule
{
	public class PrimeGameStateEntity : IDisposable
	{
		private ChatManager chatManager_;

		private OnlineConnectionController connectionController_;

		private SocketsConnectionOnline connectionOnline_;

		private PrimeConnectModel connectModel_;

		private ExceptionsManager exceptionsManager_;

		private GameModel gameModel_;

		private PrimeGameStatePlayerController playerController_;

		private PrimeLoaderController primeLoaderController_;

		private PvpServerTopManager pvpServerTopManager_;

		private SplashScreenManager splashScreenManager_;

		private StateMachine stateMachine_;

		public PrimeGameExitController ExitController { get; private set; }

		public PrimeGameStateEntity()
		{
			connectModel_ = new PrimeConnectModel();
			pvpServerTopManager_ = new PvpServerTopManager();
		}

		public void Dispose()
		{
			stateMachine_.Dispose();
			playerController_.Dispose();
			ExitController.Dispose();
			primeLoaderController_.Dispose();
			pvpServerTopManager_.Dispose();
			connectionController_.Connected -= HandleConnected;
			connectionController_.Reconnected -= HandleReconnected;
			connectionOnline_.SyncPlayerResponseRecieved -= HandleSyncPlayerResponseRecieved;
			exceptionsManager_.RemoveHandler(SyncHandler);
		}

		public void Enter(bool alreadyInPvp)
		{
			Init();
			connectModel_.alreadyInPvp = alreadyInPvp;
			if (!connectModel_.connected)
			{
				pvpServerTopManager_.EnterServer(false);
			}
			primeLoaderController_.Load();
			stateMachine_.enabled = true;
			if (connectModel_.alreadyInPvp)
			{
				playerController_.NotifyVoxelEngine();
			}
		}

		public void EnterByMode()
		{
			pvpServerTopManager_.EnterServer(false);
		}

		private void HandleConnected()
		{
			connectModel_.connected = true;
		}

		private void HandleNormalEntered()
		{
			playerController_.Start();
			splashScreenManager_.HideScreen();
			if (chatManager_ != null)
			{
				chatManager_.OpenChat();
			}
		}

		private void HandleReconnected()
		{
			if (!connectModel_.syncRecieved)
			{
				stateMachine_.ReenterState();
			}
		}

		private void HandleStopped()
		{
			playerController_.Enabled = false;
			stateMachine_.enabled = false;
			if (chatManager_ != null)
			{
				chatManager_.CloseChat();
			}
			connectionOnline_.Dispose();
		}

		private void HandleSyncPlayerResponseRecieved(RemoteMessageEventArgs obj)
		{
			connectModel_.syncRecieved = true;
		}

		private void Init()
		{
			ExitController = new PrimeGameExitController(connectModel_, pvpServerTopManager_);
			primeLoaderController_ = new PrimeLoaderController();
			playerController_ = new PrimeGameStatePlayerController(ExitController);
			SingletonManager.Get<GameModel>(out gameModel_);
			SingletonManager.Get<SplashScreenManager>(out splashScreenManager_);
			SingletonManager.Get<OnlineConnectionController>(out connectionController_);
			SingletonManager.Get<SocketsConnectionOnline>(out connectionOnline_);
			SingletonManager.TryGet<ChatManager>(out chatManager_);
			SingletonManager.Get<ExceptionsManager>(out exceptionsManager_);
			State state = new State("connecting");
			State state2 = new State("sync");
			State state3 = new State("normal");
			State state4 = new State("instanceStoped");
			state.AddTransaction(state2, () => connectModel_.connected && gameModel_.levelLoaded);
			state2.AddTransaction(state3, () => connectModel_.syncRecieved);
			stateMachine_ = new StateMachine(state, "PrimeGameState");
			stateMachine_.SetModel<PrimeGameStateModelInspector>(connectModel_);
			stateMachine_.AnyState.AddTransaction(state4, () => connectModel_.instanceStopped);
			stateMachine_.enableLog = true;
			stateMachine_.enabled = false;
			stateMachine_.SetAutoUpdate(2);
			state2.Entered += Sync;
			state4.Entered += HandleStopped;
			state3.Entered += HandleNormalEntered;
			connectionController_.Connected += HandleConnected;
			connectionController_.Reconnected += HandleReconnected;
			connectionOnline_.SyncPlayerResponseRecieved += HandleSyncPlayerResponseRecieved;
			exceptionsManager_.AddHandler(SyncHandler, 3202);
		}

		private void Sync()
		{
			connectionOnline_.SendSync();
		}

		private bool SyncHandler(ExceptionArgs args)
		{
			Sync();
			return true;
		}
	}
}
