using CraftyEngine.Content;

namespace SpecialOffersModule
{
	public class OffersEntries : ContentItem
	{
		public int id;

		public string inapp;

		public string pf;

		public string currency;

		public float price;

		public float price_coef;

		public int bonus_id;

		public int ttl;

		public string title;

		public string description;

		public string picture;

		public string icon;

		public int reusable;

		public string logic_code;

		public int need_battles;

		public int need_hns_matches;

		public int purchased_money_min;

		public int purchased_money_max;

		public int t1;

		public int t2;

		public int time_from_reg;

		public float sort_val;

		public string GetFullPicturePath()
		{
			return SpecialOffersContentKeys.GetFullPicturePath8 + picture;
		}

		public string GetFullIconPath()
		{
			return SpecialOffersContentKeys.GetFullIconPath9 + icon;
		}

		public override void Deserialize()
		{
			id = TryGetInt(SpecialOffersContentKeys.id);
			intKey = id;
			inapp = TryGetString(SpecialOffersContentKeys.inapp, string.Empty);
			pf = TryGetString(SpecialOffersContentKeys.pf, string.Empty);
			currency = TryGetString(SpecialOffersContentKeys.currency, string.Empty);
			price = TryGetFloat(SpecialOffersContentKeys.price);
			price_coef = TryGetFloat(SpecialOffersContentKeys.price_coef);
			bonus_id = TryGetInt(SpecialOffersContentKeys.bonus_id);
			ttl = TryGetInt(SpecialOffersContentKeys.ttl);
			title = TryGetString(SpecialOffersContentKeys.title, string.Empty);
			description = TryGetString(SpecialOffersContentKeys.description, string.Empty);
			picture = TryGetString(SpecialOffersContentKeys.picture, string.Empty);
			icon = TryGetString(SpecialOffersContentKeys.icon, string.Empty);
			reusable = TryGetInt(SpecialOffersContentKeys.reusable);
			logic_code = TryGetString(SpecialOffersContentKeys.logic_code, string.Empty);
			need_battles = TryGetInt(SpecialOffersContentKeys.need_battles);
			need_hns_matches = TryGetInt(SpecialOffersContentKeys.need_hns_matches);
			purchased_money_min = TryGetInt(SpecialOffersContentKeys.purchased_money_min);
			purchased_money_max = TryGetInt(SpecialOffersContentKeys.purchased_money_max);
			t1 = TryGetInt(SpecialOffersContentKeys.t1);
			t2 = TryGetInt(SpecialOffersContentKeys.t2);
			time_from_reg = TryGetInt(SpecialOffersContentKeys.time_from_reg);
			sort_val = TryGetFloat(SpecialOffersContentKeys.sort_val);
			base.Deserialize();
		}
	}
}
