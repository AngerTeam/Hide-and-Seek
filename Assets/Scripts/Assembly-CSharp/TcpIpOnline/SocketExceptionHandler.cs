using CraftyNetworkEngine;
using CraftyNetworkEngine.Sockets;
using ExceptionsModule;

namespace TcpIpOnline
{
	public class SocketExceptionHandler : Singleton
	{
		private OnlineConnectionController connectionController_;

		private SocketsOnlineManager socketsOnlineManager_;

		private GreedyCounter deadCounter_;

		private GreedyCounter targetDeadCounter_;

		private ExceptionsManager exceptionsManager_;

		public override void Dispose()
		{
			exceptionsManager_.RemoveHandler(HandleSockets);
			exceptionsManager_.RemoveHandler(HandleLogic);
		}

		public override void Init()
		{
			SingletonManager.Get<ExceptionsManager>(out exceptionsManager_);
			SingletonManager.Get<OnlineConnectionController>(out connectionController_);
			SingletonManager.Get<SocketsOnlineManager>(out socketsOnlineManager_);
			exceptionsManager_.AddHandler(HandleSockets, 3101, 3102, 3103, 3104, 3105, 3106, 3108, 3107, 1006);
			exceptionsManager_.AddHandler(HandleLogic, 1201, 1202, 1200, 1204, 1206, 3201);
			deadCounter_ = new GreedyCounter(5, 3f);
			deadCounter_.CriticalAmountReached += HandleTooManyErrors;
			targetDeadCounter_ = new GreedyCounter(15, 1f);
			targetDeadCounter_.CriticalAmountReached += HandleDesync;
		}

		private void HandleDesync()
		{
			Exc.Report(3202);
		}

		private bool HandleLogic(ExceptionArgs args)
		{
			switch (args.Id)
			{
			case 1201:
				deadCounter_.PushError();
				return true;
			case 1200:
			case 1202:
				return true;
			case 1204:
			case 1206:
			case 3201:
				Exc.Report(3202);
				return true;
			default:
				return false;
			}
		}

		private bool HandleSockets(ExceptionArgs args)
		{
			if (!args.debug && args.context != socketsOnlineManager_.Network)
			{
				return false;
			}
			switch (args.Id)
			{
			case 3101:
			case 3102:
			case 3103:
			case 3104:
			case 3105:
			case 3106:
			case 3108:
				return Reconnect(false);
			case 1006:
			case 3107:
				if (!Reconnect(true))
				{
					Exc.Report(3204);
				}
				return true;
			default:
				return false;
			}
		}

		private void HandleTooManyErrors()
		{
			Exc.Report(3201);
		}

		private bool Reconnect(bool force)
		{
			if (force)
			{
				return connectionController_.ForceReconnect();
			}
			return connectionController_.Reconnect();
		}
	}
}
