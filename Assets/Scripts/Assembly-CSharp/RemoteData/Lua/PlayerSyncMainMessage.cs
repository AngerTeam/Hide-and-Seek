using Interlace.Amf;

namespace RemoteData.Lua
{
	public class PlayerSyncMainMessage : RemoteMessage
	{
		public int userId;

		public string persId;

		public double ctime;

		public string cdate;

		public string name;

		public int skinId;

		public int flags;

		public string curSlotId;

		public string gameCenterId;

		public PlayerSyncMainMessage(int userId, string persId, double ctime, string cdate, string name, int skinId, int flags, string curSlotId, string gameCenterId)
		{
			this.userId = userId;
			this.persId = persId;
			this.ctime = ctime;
			this.cdate = cdate;
			this.name = name;
			this.skinId = skinId;
			this.flags = flags;
			this.curSlotId = curSlotId;
			this.gameCenterId = gameCenterId;
		}

		public PlayerSyncMainMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			userId = Get<int>(source, "user_id", false);
			persId = Get<string>(source, "pers_id", false);
			ctime = Get<double>(source, "ctime", false);
			cdate = Get<string>(source, "cdate", false);
			name = Get<string>(source, "name", false);
			skinId = Get<int>(source, "skin_id", false);
			flags = Get<int>(source, "flags", false);
			curSlotId = Get<string>(source, "cur_slot_id", false);
			gameCenterId = Get<string>(source, "game_center_id", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerSyncMainMessage: userId: {0}; persId: {1}; ctime: {2}; cdate: {3}; name: {4}; skinId: {5}; flags: {6}; curSlotId: {7}; gameCenterId: {8};", userId, persId, ctime, cdate, name, skinId, flags, curSlotId, gameCenterId);
		}
	}
}
