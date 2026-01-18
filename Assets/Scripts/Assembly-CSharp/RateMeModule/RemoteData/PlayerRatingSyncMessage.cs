using CraftyEngine.Utils;
using Interlace.Amf;
using RemoteData;

namespace RateMeModule.RemoteData
{
	public class PlayerRatingSyncMessage : RemoteMessage
	{
		public AppRatingMessage[] appRating;

		public override void Deserialize(AmfObject source, bool silent)
		{
			appRating = GetArray<AppRatingMessage>(source, "app_rating", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerRatingSyncMessage:\n appRating: {0}", ArrayUtils.ArrayToString(appRating, "\n\t"));
		}
	}
}
