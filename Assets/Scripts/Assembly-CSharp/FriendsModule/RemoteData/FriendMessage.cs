using Interlace.Amf;
using RemoteData;

namespace FriendsModule.RemoteData
{
	public class FriendMessage : RemoteMessage
	{
		public int userId;

		public string persId;

		public double ctime;

		public string name;

		public int skinId;

		public int level;

		public int online;

		public int mapId;

		public string mapName;

		public string instId;

		public FriendMessage(int userId, string persId, double ctime, string name, int skinId, int level, int online, int mapId, string mapName, string instId)
		{
			this.userId = userId;
			this.persId = persId;
			this.ctime = ctime;
			this.name = name;
			this.skinId = skinId;
			this.level = level;
			this.online = online;
			this.mapId = mapId;
			this.mapName = mapName;
			this.instId = instId;
		}

		public FriendMessage()
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
			online = Get<int>(source, "online", false);
			mapId = Get<int>(source, "map_id", false);
			mapName = Get<string>(source, "map_name", false);
			instId = Get<string>(source, "inst_id", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("FriendMessage: userId: {0}; persId: {1}; ctime: {2}; name: {3}; skinId: {4}; level: {5}; online: {6}; mapId: {7}; mapName: {8}; instId: {9};", userId, persId, ctime, name, skinId, level, online, mapId, mapName, instId);
		}
	}
}
