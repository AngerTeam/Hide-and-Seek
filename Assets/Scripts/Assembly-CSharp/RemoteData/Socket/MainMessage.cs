using Interlace.Amf;

namespace RemoteData.Socket
{
	public class MainMessage : RemoteMessage
	{
		public int userId;

		public string persId;

		public string name;

		public int skinId;

		public int flags;

		public MainMessage(int userId, string persId, string name, int skinId, int flags)
		{
			this.userId = userId;
			this.persId = persId;
			this.name = name;
			this.skinId = skinId;
			this.flags = flags;
		}

		public MainMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			userId = Get<int>(source, "user_id", false);
			persId = Get<string>(source, "pers_id", false);
			name = Get<string>(source, "name", false);
			skinId = Get<int>(source, "skin_id", false);
			flags = Get<int>(source, "flags", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("MainMessage: userId: {0}; persId: {1}; name: {2}; skinId: {3}; flags: {4};", userId, persId, name, skinId, flags);
		}
	}
}
