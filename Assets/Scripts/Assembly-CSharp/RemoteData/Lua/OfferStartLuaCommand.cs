using Interlace.Amf;

namespace RemoteData.Lua
{
	public class OfferStartLuaCommand : RemoteLuaCommand
	{
		private string inapp;

		private int offerId;

		public OfferStartLuaCommand(string inapp, int offerId)
		{
			this.inapp = inapp;
			this.offerId = offerId;
			cmd = "offer_start";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["inapp"] = inapp;
			amfObject.Properties["offer_id"] = offerId;
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
			return string.Format("OfferStartLuaCommand: inapp: {0}; offerId: {1};", inapp, offerId);
		}
	}
}
