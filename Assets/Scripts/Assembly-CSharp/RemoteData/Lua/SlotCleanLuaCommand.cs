using Interlace.Amf;

namespace RemoteData.Lua
{
	public class SlotCleanLuaCommand : RemoteLuaCommand
	{
		private string slotId;

		public SlotCleanLuaCommand(string slotId)
		{
			this.slotId = slotId;
			cmd = "slot_clean";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["slot_id"] = slotId;
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
			return string.Format("SlotCleanLuaCommand: slotId: {0};", slotId);
		}
	}
}
