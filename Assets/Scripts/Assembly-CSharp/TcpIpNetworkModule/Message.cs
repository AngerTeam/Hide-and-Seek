using Interlace.Amf;

namespace TcpIpNetworkModule
{
	public struct Message
	{
		public string name;

		public AmfObject obj;

		public int seq;

		public int status;
	}
}
