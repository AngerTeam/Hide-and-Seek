using Interlace.Amf;

namespace RemoteData.Socket
{
	public class SlotCleanCommand : RemoteCommand
	{
		private string slotId;

		public SlotCleanCommand(string slotId)
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
			if (!silent)
			{
				Log.Online(ToString());
			}
			return amfObject;
		}

		public override string ToString()
		{
			return string.Format("SlotCleanCommand: slotId: {0};", slotId);
		}
	}
}
