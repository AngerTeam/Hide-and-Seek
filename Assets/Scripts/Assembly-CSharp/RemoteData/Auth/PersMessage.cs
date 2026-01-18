using Interlace.Amf;

namespace RemoteData.Auth
{
	public class PersMessage : RemoteMessage
	{
		public string serverId;

		public string persId;

		public string name;

		public PersMessage(string serverId, string persId, string name)
		{
			this.serverId = serverId;
			this.persId = persId;
			this.name = name;
		}

		public PersMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			serverId = Get<string>(source, "server_id", false);
			persId = Get<string>(source, "pers_id", false);
			name = Get<string>(source, "name", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PersMessage: serverId: {0}; persId: {1}; name: {2};", serverId, persId, name);
		}
	}
}
