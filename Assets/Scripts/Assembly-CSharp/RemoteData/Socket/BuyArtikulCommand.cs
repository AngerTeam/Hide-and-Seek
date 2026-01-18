using Interlace.Amf;

namespace RemoteData.Socket
{
	public class BuyArtikulCommand : RemoteCommand
	{
		private int artikulId;

		public BuyArtikulCommand(int artikulId)
		{
			this.artikulId = artikulId;
			cmd = "buy_artikul";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["artikul_id"] = artikulId;
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
			return string.Format("BuyArtikulCommand: artikulId: {0};", artikulId);
		}
	}
}
