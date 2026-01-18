using Interlace.Amf;
using RemoteData;

namespace RateMeModule.RemoteData
{
	public class AppRatingRefusalLuaCommand : RemoteLuaCommand
	{
		private int forever;

		public AppRatingRefusalLuaCommand(int forever)
		{
			this.forever = forever;
			cmd = "app_rating_refusal";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["forever"] = forever;
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
			return string.Format("AppRatingRefusalLuaCommand: forever: {0};", forever);
		}
	}
}
