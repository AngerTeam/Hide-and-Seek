using Interlace.Amf;

namespace RemoteData.Lua
{
	public class OfferStartResponse : RemoteMessage
	{
		public double started;

		public OfferStartResponse(double started)
		{
			this.started = started;
		}

		public OfferStartResponse()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			started = Get<double>(source, "started", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("OfferStartResponse: started: {0};", started);
		}
	}
}
