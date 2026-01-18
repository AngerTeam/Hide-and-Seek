using Interlace.Amf;

namespace RemoteData.Lua
{
	public class ChestOpenLuaCommand : RemoteLuaCommand
	{
		private int slotId;

		public int? money;

		public ChestOpenLuaCommand(int slotId)
		{
			this.slotId = slotId;
			cmd = "chest_open";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["slot_id"] = slotId;
			if (money.HasValue)
			{
				amfObject.Properties["money"] = money;
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
			return string.Format("ChestOpenLuaCommand: slotId: {0}; money: {1};", slotId, money);
		}
	}
}
