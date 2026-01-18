using Interlace.Amf;

namespace RemoteData.Lua
{
	public class SlotMoveLuaCommand : RemoteLuaCommand
	{
		private string fromSlotId;

		private string toSlotId;

		private int artikulId;

		private int count;

		public SlotMoveLuaCommand(string fromSlotId, string toSlotId, int artikulId, int count)
		{
			this.fromSlotId = fromSlotId;
			this.toSlotId = toSlotId;
			this.artikulId = artikulId;
			this.count = count;
			cmd = "slot_move";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["from_slot_id"] = fromSlotId;
			amfObject.Properties["to_slot_id"] = toSlotId;
			amfObject.Properties["artikul_id"] = artikulId;
			amfObject.Properties["cnt"] = count;
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
			return string.Format("SlotMoveLuaCommand: fromSlotId: {0}; toSlotId: {1}; artikulId: {2}; count: {3};", fromSlotId, toSlotId, artikulId, count);
		}
	}
}
