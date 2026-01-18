namespace TcpIpOnline
{
	public class PvpServerOnlineModel
	{
		public bool connecting;

		public bool connected;

		public bool authorised;

		public bool reconnect;

		public void Clear()
		{
			connecting = false;
			connected = false;
			authorised = false;
			reconnect = false;
		}
	}
}
