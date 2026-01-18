using Interlace.Amf;

namespace RemoteData.Socket
{
	public class SetSkinCommand : RemoteCommand
	{
		private int skinId;

		public SetSkinCommand(int skinId)
		{
			this.skinId = skinId;
			cmd = "set_skin";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["skin_id"] = skinId;
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
			return string.Format("SetSkinCommand: skinId: {0};", skinId);
		}
	}
}
