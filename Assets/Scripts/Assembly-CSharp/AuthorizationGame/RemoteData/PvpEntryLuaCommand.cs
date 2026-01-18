using Interlace.Amf;
using RemoteData;

namespace AuthorizationGame.RemoteData
{
	public class PvpEntryLuaCommand : RemoteLuaCommand
	{
		public int? islandId;

		public int? mapId;

		public int? modeId;

		public int? comeback;

		public PvpEntryLuaCommand()
		{
			cmd = "pvp_entry";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			if (islandId.HasValue)
			{
				amfObject.Properties["island_id"] = islandId;
			}
			if (mapId.HasValue)
			{
				amfObject.Properties["map_id"] = mapId;
			}
			if (modeId.HasValue)
			{
				amfObject.Properties["mode_id"] = modeId;
			}
			if (comeback.HasValue)
			{
				amfObject.Properties["comeback"] = comeback;
			}
			amfObject.Properties["cmd"] = cmd;
			amfObject.Properties["ts"] = ts;
			amfObject.Properties["sig"] = sig;
			amfObject.Properties["user_id"] = userId;
			amfObject.Properties["pers_id"] = persId;
			amfObject.Properties["sid"] = sid;
			if (!silent)
			{
				Log.Online(ToString());
			}
			return amfObject;
		}

		public override string ToString()
		{
			return string.Format("PvpEntryLuaCommand: islandId: {0}; mapId: {1}; modeId: {2}; comeback: {3};", islandId, mapId, modeId, comeback);
		}
	}
}
