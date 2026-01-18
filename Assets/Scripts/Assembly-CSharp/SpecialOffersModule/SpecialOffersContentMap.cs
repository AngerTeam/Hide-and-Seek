using System.Collections.Generic;
using CraftyEngine.Content;

namespace SpecialOffersModule
{
	public class SpecialOffersContentMap : ContentMapBase
	{
		public static Dictionary<int, OffersEntries> Offers;

		public override void Deserialize()
		{
			SpecialOffersContentKeys.Deserialize();
			Offers = ReadInt<OffersEntries>(SpecialOffersContentKeys.offers);
			base.Deserialize();
		}
	}
}
