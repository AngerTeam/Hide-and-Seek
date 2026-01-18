using System.Text;
using CraftyEngine.Infrastructure;

namespace TcpIpNetworkModule
{
	public class WithHttpHeader : TcpIpNetworkWithAmf
	{
		public bool sendHeader;

		public WithHttpHeader(IUpdate updater, string id, bool experementalOptimisation)
			: base(updater, id, experementalOptimisation)
		{
			sendHeader = true;
			Opened += HandleNetworkOpened;
		}

		public void SnedHttpHeader()
		{
			Send(Encoding.ASCII.GetBytes("GET / HTTP/1.0 \r\n\r\n"), false);
		}

		private void HandleNetworkOpened()
		{
			if (sendHeader)
			{
				SnedHttpHeader();
			}
		}
	}
}
