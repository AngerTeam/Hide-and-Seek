using Interlace.Amf;

namespace RemoteData.Auth
{
	public class PersCreateMessage : RemoteMessage
	{
		public string persId;

		public string name;

		public PersCreateMessage(string persId, string name)
		{
			this.persId = persId;
			this.name = name;
		}

		public PersCreateMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			persId = Get<string>(source, "pers_id", false);
			name = Get<string>(source, "name", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PersCreateMessage: persId: {0}; name: {1};", persId, name);
		}
	}
}
