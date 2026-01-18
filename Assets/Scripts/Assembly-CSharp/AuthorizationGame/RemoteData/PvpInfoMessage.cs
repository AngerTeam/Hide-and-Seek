using Interlace.Amf;
using RemoteData;

namespace AuthorizationGame.RemoteData
{
	public class PvpInfoMessage : RemoteMessage
	{
		public string instanceId;

		public int islandId;

		public string url;

		public string ip;

		public int tcpPort;

		public int mapId;

		public PvpInfoMessage(string instanceId, int islandId, string url, string ip, int tcpPort, int mapId)
		{
			this.instanceId = instanceId;
			this.islandId = islandId;
			this.url = url;
			this.ip = ip;
			this.tcpPort = tcpPort;
			this.mapId = mapId;
		}

		public PvpInfoMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			instanceId = Get<string>(source, "instance_id", false);
			islandId = Get<int>(source, "island_id", false);
			url = Get<string>(source, "url", false);
			ip = Get<string>(source, "ip", false);
			tcpPort = Get<int>(source, "tcp_port", false);
			mapId = Get<int>(source, "map_id", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PvpInfoMessage: instanceId: {0}; islandId: {1}; url: {2}; ip: {3}; tcpPort: {4}; mapId: {5};", instanceId, islandId, url, ip, tcpPort, mapId);
		}
	}
}
