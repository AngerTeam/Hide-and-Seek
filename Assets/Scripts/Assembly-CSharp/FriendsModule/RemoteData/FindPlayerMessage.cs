using Interlace.Amf;
using RemoteData;

namespace FriendsModule.RemoteData
{
	public class FindPlayerMessage : RemoteMessage
	{
		public int userId;

		public string persId;

		public string name;

		public int skinId;

		public FindPlayerMessage(int userId, string persId, string name, int skinId)
		{
			this.userId = userId;
			this.persId = persId;
			this.name = name;
			this.skinId = skinId;
		}

		public FindPlayerMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			userId = Get<int>(source, "user_id", false);
			persId = Get<string>(source, "pers_id", false);
			name = Get<string>(source, "name", false);
			skinId = Get<int>(source, "skin_id", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("FindPlayerMessage: userId: {0}; persId: {1}; name: {2}; skinId: {3};", userId, persId, name, skinId);
		}
	}
}
