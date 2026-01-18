using Interlace.Amf;

namespace RemoteData.Socket
{
	public class BuySkinCommand : RemoteCommand
	{
		private int skinId;

		public BuySkinCommand(int skinId)
		{
			this.skinId = skinId;
			cmd = "buy_skin";
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
			return string.Format("BuySkinCommand: skinId: {0};", skinId);
		}
	}
}
