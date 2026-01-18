using System.Net.Sockets;

namespace TcpIpNetworkModule
{
	public class SocketReciever
	{
		public const int BUFFER_SIZE = 2048;

		public SocketAsyncEventArgs args;

		public byte[] buffer;

		public int position;

		public int length;

		public SocketReciever()
		{
			buffer = new byte[2048];
			args = new SocketAsyncEventArgs();
		}
	}
}
