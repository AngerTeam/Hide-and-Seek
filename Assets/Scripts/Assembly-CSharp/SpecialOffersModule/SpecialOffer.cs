using System.Collections.Generic;

namespace SpecialOffersModule
{
	public class SpecialOffer
	{
		public string inappId;

		public int started;

		public int closed;

		public UM_InAppProduct umInApp;

		public OffersEntries entry;

		public bool updated;

		public List<SpecialOfferItem> offerItems;

		public SpecialOffer(OffersEntries entry)
		{
			this.entry = entry;
			inappId = entry.inapp;
		}
	}
}
