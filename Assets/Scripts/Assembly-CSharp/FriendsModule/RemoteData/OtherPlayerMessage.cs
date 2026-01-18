using CraftyEngine.Utils;
using Interlace.Amf;
using RemoteData;

namespace FriendsModule.RemoteData
{
	public class OtherPlayerMessage : RemoteMessage
	{
		public int userId;

		public string persId;

		public double ctime;

		public string name;

		public int skinId;

		public int level;

		public int maps;

		public int pvpKills;

		public int online;

		public int mapId;

		public int instanceId;

		public FriendMessage[] friends;

		public OtherPlayerMessage(int userId, string persId, double ctime, string name, int skinId, int level, int maps, int pvpKills, int online, int mapId, int instanceId, FriendMessage[] friends)
		{
			this.userId = userId;
			this.persId = persId;
			this.ctime = ctime;
			this.name = name;
			this.skinId = skinId;
			this.level = level;
			this.maps = maps;
			this.pvpKills = pvpKills;
			this.online = online;
			this.mapId = mapId;
			this.instanceId = instanceId;
			this.friends = friends;
		}

		public OtherPlayerMessage()
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
			maps = Get<int>(source, "maps", false);
			pvpKills = Get<int>(source, "pvp_kills", false);
			online = Get<int>(source, "online", false);
			mapId = Get<int>(source, "map_id", false);
			instanceId = Get<int>(source, "instance_id", false);
			friends = GetArray<FriendMessage>(source, "friends");
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("OtherPlayerMessage: userId: {0}; persId: {1}; ctime: {2}; name: {3}; skinId: {4}; level: {5}; maps: {6}; pvpKills: {7}; online: {8}; mapId: {9}; instanceId: {10};\n friends: {11}", userId, persId, ctime, name, skinId, level, maps, pvpKills, online, mapId, instanceId, ArrayUtils.ArrayToString(friends, "\n\t"));
		}
	}
}
