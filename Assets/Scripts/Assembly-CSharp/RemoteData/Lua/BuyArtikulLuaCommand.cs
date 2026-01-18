using Interlace.Amf;

namespace RemoteData.Lua
{
	public class BuyArtikulLuaCommand : RemoteLuaCommand
	{
		private int artikulId;

		public BuyArtikulLuaCommand(int artikulId)
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
			return string.Format("BuyArtikulLuaCommand: artikulId: {0};", artikulId);
		}
	}
}
