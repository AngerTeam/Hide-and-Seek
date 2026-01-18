using Interlace.Amf;
using RemoteData;

namespace RateMeModule.RemoteData
{
	public class AppRatingResponse : PurchaseMessage
	{
		public override void Deserialize(AmfObject source, bool silent)
		{
			base.Deserialize(source, true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("AppRatingResponse:") + base.ToString();
		}
	}
}
