using RemoteData;

namespace CraftyNetworkEngine.Sockets
{
	public class SocketsOnlineManagerApi : Singleton
	{
		protected SocketsOnlineManager sockets;

		public override void Init()
		{
			SingletonManager.Get<SocketsOnlineManager>(out sockets);
		}

		protected void Send(RemoteCommand command)
		{
			sockets.Send(command);
		}
	}
}
