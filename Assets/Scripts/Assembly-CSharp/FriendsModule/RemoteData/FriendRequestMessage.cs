using Interlace.Amf;
using RemoteData;

namespace FriendsModule.RemoteData
{
	public class FriendRequestMessage : RemoteMessage
	{
		public int userId;

		public string persId;

		public double ctime;

		public string name;

		public int skinId;

		public int level;

		public FriendRequestMessage(int userId, string persId, double ctime, string name, int skinId, int level)
		{
			this.userId = userId;
			this.persId = persId;
			this.ctime = ctime;
			this.name = name;
			this.skinId = skinId;
			this.level = level;
		}

		public FriendRequestMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			userId = Get<int>(source, "user_id", false);
			persId = Get<string>(source, "pers_id", false);
			ctime = Get<double>(source, "ctime", false);
			name = Get<string>(source, "name", false);
			skinId = Get<int>(source, "skin_id", false);
			level = Get<int>(source, "level", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("FriendRequestMessage: userId: {0}; persId: {1}; ctime: {2}; name: {3}; skinId: {4}; level: {5};", userId, persId, ctime, name, skinId, level);
		}
	}
}
