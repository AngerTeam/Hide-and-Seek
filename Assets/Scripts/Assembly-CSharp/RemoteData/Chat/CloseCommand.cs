using Interlace.Amf;

namespace RemoteData.Chat
{
	public class CloseCommand : RemoteCommand
	{
		private string toSlotId;

		public CloseCommand(string toSlotId)
		{
			this.toSlotId = toSlotId;
			cmd = "close";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
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
			return string.Format("ChatCloseCommand: toSlotId: {0};", toSlotId);
		}
	}
}
