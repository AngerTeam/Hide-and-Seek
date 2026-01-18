using Interlace.Amf;

namespace RemoteData.Lua
{
	public class OfferMessage : RemoteMessage
	{
		public int offerId;

		public string inapp;

		public double started;

		public double closed;

		public int bonusId;

		public OfferMessage(int offerId, string inapp, double started, double closed, int bonusId)
		{
			this.offerId = offerId;
			this.inapp = inapp;
			this.started = started;
			this.closed = closed;
			this.bonusId = bonusId;
		}

		public OfferMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			offerId = Get<int>(source, "offer_id", false);
			inapp = Get<string>(source, "inapp", false);
			started = Get<double>(source, "started", false);
			closed = Get<double>(source, "closed", false);
			bonusId = Get<int>(source, "bonus_id", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("OfferMessage: offerId: {0}; inapp: {1}; started: {2}; closed: {3}; bonusId: {4};", offerId, inapp, started, closed, bonusId);
		}
	}
}
