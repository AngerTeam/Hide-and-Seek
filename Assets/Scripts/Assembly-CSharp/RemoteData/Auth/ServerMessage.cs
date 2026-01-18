using System.Collections.Generic;
using Interlace.Amf;

namespace RemoteData.Auth
{
	public class ServerMessage : RemoteMessage
	{
		public string id;

		public string name;

		public string location;

		public List<PersMessage> persList;

		public ServerMessage(string id, string name, string location)
		{
			this.id = id;
			this.name = name;
			this.location = location;
		}

		public ServerMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			id = Get<string>(source, "id", false);
			name = Get<string>(source, "name", false);
			location = Get<string>(source, "location", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("ServerMessage: id: {0}; name: {1}; location: {2};", id, name, location);
		}
	}
}
