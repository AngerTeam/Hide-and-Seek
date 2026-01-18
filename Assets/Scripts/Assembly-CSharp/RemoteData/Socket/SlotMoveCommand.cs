using Interlace.Amf;

namespace RemoteData.Socket
{
	public class SlotMoveCommand : RemoteCommand
	{
		private int artikulId;

		private string fromSlotId;

		private string toSlotId;

		private int count;

		public SlotMoveCommand(int artikulId, string fromSlotId, string toSlotId, int count)
		{
			this.artikulId = artikulId;
			this.fromSlotId = fromSlotId;
			this.toSlotId = toSlotId;
			this.count = count;
			cmd = "slot_move";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["artikul_id"] = artikulId;
			amfObject.Properties["from_slot_id"] = fromSlotId;
			amfObject.Properties["to_slot_id"] = toSlotId;
			amfObject.Properties["cnt"] = count;
			amfObject.Properties["cmd"] = cmd;
			amfObject.Properties["ts"] = ts;
			amfObject.Properties["sig"] = sig;
			if (!silent)
			{
				Log.Online(ToString());
			}
			return amfObject;
		}

		public override string ToString()
		{
			return string.Format("SlotMoveCommand: artikulId: {0}; fromSlotId: {1}; toSlotId: {2}; count: {3};", artikulId, fromSlotId, toSlotId, count);
		}
	}
}
