using System.Collections.Generic;
using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Auth
{
	public class ServersMessage : RemoteMessage
	{
		public ServerMessage[] serverList;

		public PersMessage[] persList;

		public Dictionary<string, ServerMessage> serversById;

		public Dictionary<string, PersMessage> persById;

		public ServersMessage(ServerMessage[] serverList, PersMessage[] persList)
		{
			this.serverList = serverList;
			this.persList = persList;
		}

		public ServersMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			serverList = GetArray<ServerMessage>(source, "server_list");
			persList = GetArray<PersMessage>(source, "pers_list");
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("ServersMessage:\n serverList: {0}\n persList: {1}", ArrayUtils.ArrayToString(serverList, "\n\t"), ArrayUtils.ArrayToString(persList, "\n\t"));
		}
	}
}
