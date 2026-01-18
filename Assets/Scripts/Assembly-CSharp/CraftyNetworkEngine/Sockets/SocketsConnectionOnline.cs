using System;
using Authorization;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using Extensions;
using HttpNetwork;
using Interlace.Amf;
using RemoteData;
using RemoteData.Socket;
using SyncOnlineModule;

namespace CraftyNetworkEngine.Sockets
{
	public class SocketsConnectionOnline : SocketsOnlineManagerApi
	{
		private UnityTimerManager timerManager_;

		private UnityTimer pingTimer_;

		private bool virgin_;

		public RemoteMessage SyncMessage { get; private set; }

		public bool AllowPing { get; set; }

		public event Action<RemoteMessageEventArgs> SyncPlayerResponseRecieved;

		public event Action Connected;

		public event Action InitResponseRecieved;

		public override void Init()
		{
			virgin_ = true;
			base.Init();
			sockets.Connected += SocketsConnected;
			SingletonManager.Get<UnityTimerManager>(out timerManager_);
			UnityEvent unityEvent = SingletonManager.Get<UnityEvent>();
			unityEvent.Subscribe(UnityEventType.ApplicationFocus, HandleFocus);
		}

		public void Connect()
		{
			PvpAuthorizationModel pvpAuthorizationModel = SingletonManager.Get<PvpAuthorizationModel>();
			Log.Info("[SocketsOnline]: Connecting to {0}", pvpAuthorizationModel.serverUrl);
			sockets.Connect(pvpAuthorizationModel.serverUrl, pvpAuthorizationModel.serverPort);
		}

		public void Disconnect()
		{
			if (sockets != null)
			{
				Log.Info("[SocketsOnline]: Disconnect");
				sockets.Disconnect();
			}
			AllowPing = false;
			if (pingTimer_ != null)
			{
				pingTimer_.Stop();
				pingTimer_ = null;
			}
		}

		public void SendSync()
		{
			SyncPlayerCommand syncPlayerCommand = new SyncPlayerCommand();
			syncPlayerCommand.ResponceRecieved += HandleSyncPlayer;
			Send(syncPlayerCommand);
		}

		private void HandleSyncPlayer(AmfObject obj)
		{
			AmfObject source = (AmfObject)obj.Properties["player"];
			SyncMessage = RemoteMessage.Read<PlayerSyncMessage>(source);
			SyncManager singleton;
			if (SingletonManager.TryGet<SyncManager>(out singleton))
			{
				singleton.reportOnNextUpdate = true;
				singleton.SetObject(obj, false);
			}
			this.SyncPlayerResponseRecieved(new RemoteMessageEventArgs(SyncMessage));
		}

		public void SendInit()
		{
			HttpOnlineModel httpOnlineModel = SingletonManager.Get<HttpOnlineModel>();
			InitCommand initCommand = new InitCommand(httpOnlineModel.persId, httpOnlineModel.userId, httpOnlineModel.sessionId, (!virgin_) ? 1 : 0);
			virgin_ = false;
			initCommand.ResponceRecieved += delegate
			{
				this.InitResponseRecieved();
			};
			initCommand.ResponceNotRecieved += delegate
			{
				Exc.Report(3107);
			};
			HttpService.SessionRequest(initCommand);
			Send(initCommand);
		}

		private void HandleFocus()
		{
			if (AllowPing)
			{
				PingCommand pingCommand = new PingCommand();
				pingCommand.ResponceRecieved += HandlePingResponce;
				Send(pingCommand);
			}
		}

		private void HandlePingResponce(AmfObject obj)
		{
			Log.Info("[SocketsOnline]: Ping responce recieved");
		}

		public override void Dispose()
		{
			Disconnect();
		}

		private void SendPing()
		{
			if (AllowPing)
			{
				Send(new PingCommand());
			}
		}

		private void SocketsConnected()
		{
			pingTimer_ = timerManager_.SetTimer(10f);
			pingTimer_.repeat = true;
			pingTimer_.Completeted += SendPing;
			this.Connected.SafeInvoke();
		}
	}
}
