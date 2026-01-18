using Interlace.Amf;

namespace RemoteData.Auth
{
	public class ServerEnterMessage : RemoteMessage
	{
		public string url;

		public string chatUrl;

		public string chatIp;

		public int chatTcpPort;

		public ServerEnterMessage(string url, string chatUrl, string chatIp, int chatTcpPort)
		{
			this.url = url;
			this.chatUrl = chatUrl;
			this.chatIp = chatIp;
			this.chatTcpPort = chatTcpPort;
		}

		public ServerEnterMessage(string url)
		{
			this.url = url;
		}

		public ServerEnterMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			url = Get<string>(source, "url", false);
			chatUrl = Get<string>(source, "chat_url", true);
			chatIp = Get<string>(source, "chat_ip", true);
			chatTcpPort = Get<int>(source, "chat_tcp_port", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("ServerEnterMessage: url: {0}; chatUrl: {1}; chatIp: {2}; chatTcpPort: {3};", url, chatUrl, chatIp, chatTcpPort);
		}
	}
}
