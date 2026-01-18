using Interlace.Amf;

namespace RemoteData.Socket
{
	public class SlotSwapCommand : RemoteCommand
	{
		private string fromSlotId;

		private string toSlotId;

		public SlotSwapCommand(string fromSlotId, string toSlotId)
		{
			this.fromSlotId = fromSlotId;
			this.toSlotId = toSlotId;
			cmd = "slot_swap";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["from_slot_id"] = fromSlotId;
			amfObject.Properties["to_slot_id"] = toSlotId;
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
			return string.Format("SlotSwapCommand: fromSlotId: {0}; toSlotId: {1};", fromSlotId, toSlotId);
		}
	}
}
