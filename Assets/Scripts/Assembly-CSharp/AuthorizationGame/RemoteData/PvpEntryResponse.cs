using Interlace.Amf;
using RemoteData;

namespace AuthorizationGame.RemoteData
{
	public class PvpEntryResponse : RemoteMessage
	{
		public PvpInfoMessage pvpInfo;

		public string instanceId;

		public int islandId;

		public string clientUrl;

		public string ip;

		public int tcpPort;

		public PvpEntryResponse(string instanceId, int islandId, string clientUrl, string ip, int tcpPort)
		{
			this.instanceId = instanceId;
			this.islandId = islandId;
			this.clientUrl = clientUrl;
			this.ip = ip;
			this.tcpPort = tcpPort;
		}

		public PvpEntryResponse()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			pvpInfo = GetMessage<PvpInfoMessage>(source, "pvp_info", true);
			instanceId = Get<string>(source, "instance_id", false);
			islandId = Get<int>(source, "island_id", false);
			clientUrl = Get<string>(source, "client_url", false);
			ip = Get<string>(source, "ip", false);
			tcpPort = Get<int>(source, "tcp_port", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PvpEntryResponse: pvpInfo: {0}; instanceId: {1}; islandId: {2}; clientUrl: {3}; ip: {4}; tcpPort: {5};", pvpInfo, instanceId, islandId, clientUrl, ip, tcpPort);
		}
	}
}
