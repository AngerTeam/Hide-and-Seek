using Interlace.Amf;
using RemoteData;

namespace RateMeModule.RemoteData
{
	public class AppRatingLuaCommand : RemoteLuaCommand
	{
		private int rating;

		public AppRatingLuaCommand(int rating)
		{
			this.rating = rating;
			cmd = "app_rating";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["rating"] = rating;
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
			return string.Format("AppRatingLuaCommand: rating: {0};", rating);
		}
	}
}
