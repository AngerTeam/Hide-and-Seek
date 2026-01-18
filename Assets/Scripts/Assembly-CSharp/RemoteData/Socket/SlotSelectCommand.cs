using Interlace.Amf;

namespace RemoteData.Socket
{
	public class SlotSelectCommand : RemoteCommand
	{
		private string slotId;

		public SlotSelectCommand(string slotId)
		{
			this.slotId = slotId;
			cmd = "slot_select";
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
			return string.Format("SlotSelectCommand: slotId: {0};", slotId);
		}
	}
}
