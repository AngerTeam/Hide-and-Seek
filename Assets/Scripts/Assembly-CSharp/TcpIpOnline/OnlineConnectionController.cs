using System;
using CraftyEngine.States;
using CraftyEngine.Utils;
using CraftyNetworkEngine;
using CraftyNetworkEngine.Sockets;
using Extensions;

namespace TcpIpOnline
{
	public class OnlineConnectionController : Singleton
	{
		public bool allowReocnnect;

		private SocketsConnectionOnline connection_;

		private StateMachine machine_;

		private PvpServerOnlineModel model_;

		private UnityTimer stateTimer_;

		private bool stopped_;

		private UnityTimerManager timerManager_;

		private bool firstConnection_;

		public event Action Reconnected;

		public event Action Connected;

		public override void Init()
		{
			allowReocnnect = true;
			firstConnection_ = true;
			SingletonManager.Get<SocketsConnectionOnline>(out connection_);
			SingletonManager.Get<UnityTimerManager>(out timerManager_);
			model_ = new PvpServerOnlineModel();
			State state = new State("waiting");
			State state2 = new State("connecting");
			State state3 = new State("init authorise");
			State state4 = new State("connected");
			State state5 = new State("terminate");
			machine_ = new StateMachine(state, "Online Connection Controller");
			machine_.enableLog = true;
			state.AddTransaction(state2, () => model_.connecting);
			state2.AddTransaction(state4, () => model_.authorised);
			state2.AddTransaction(state3, () => model_.connected);
			state3.AddTransaction(state4, () => model_.authorised);
			machine_.AnyState.AddTransaction(state5, () => model_.reconnect);
			machine_.enabled = false;
			machine_.SetAutoUpdate(Layer);
			state5.AddTransaction(state);
			state2.Entered += HandleConnectStarted;
			state3.Entered += Authorise;
			state4.Entered += HandleSuccessConnect;
			state5.Entered += Terminate;
			connection_.Connected += delegate
			{
				model_.connected = true;
			};
			connection_.InitResponseRecieved += delegate
			{
				model_.authorised = true;
			};
		}

		public static void InitModule()
		{
			int layer = 2;
			SingletonManager.Add<OnlineConnectionController>(layer);
			SingletonManager.Add<SocketsOnlineManager>(layer);
			SingletonManager.Add<SocketExceptionHandler>(layer);
			SingletonManager.Add<SocketsConnectionOnline>(layer);
			SingletonManager.AddAlias<SocketsGameOnline, IGameOnline>(layer);
		}

		public void Connect()
		{
			stopped_ = false;
			model_.authorised = false;
			model_.connecting = true;
			machine_.enabled = true;
			connection_.AllowPing = false;
		}

		public override void Dispose()
		{
			Log.Online("Dispose OnlineConnectionController");
			Terminate();
			machine_.Dispose();
		}

		public void FreezeBeforeDisconnect()
		{
			if (!stopped_)
			{
				stopped_ = true;
				connection_.AllowPing = false;
				model_.Clear();
			}
		}

		public bool Reconnect()
		{
			if (model_.connected && allowReocnnect)
			{
				model_.Clear();
				model_.connecting = true;
				machine_.enabled = true;
				model_.reconnect = true;
				connection_.AllowPing = false;
				return true;
			}
			return false;
		}

		private void HandleConnectStarted()
		{
			RestartTimer(HandleConnectStarted);
			connection_.Connect();
		}

		private void HandleSuccessConnect()
		{
			RestartTimer(null);
			connection_.AllowPing = true;
			model_.connecting = false;
			machine_.enabled = false;
			this.Connected.SafeInvoke();
			if (firstConnection_)
			{
				firstConnection_ = false;
			}
			else
			{
				this.Reconnected.SafeInvoke();
			}
		}

		private void Authorise()
		{
			RestartTimer(delegate
			{
				ForceReconnect();
			});
			connection_.SendInit();
		}

		public bool ForceReconnect()
		{
			model_.connected = true;
			return Reconnect();
		}

		private void RestartTimer(Action action)
		{
			if (stateTimer_ != null)
			{
				stateTimer_.Stop();
			}
			if (action != null)
			{
				stateTimer_ = timerManager_.SetTimer(5f);
				stateTimer_.Completeted += action;
			}
		}

		private void Terminate()
		{
			model_.reconnect = false;
			connection_.Disconnect();
		}
	}
}
