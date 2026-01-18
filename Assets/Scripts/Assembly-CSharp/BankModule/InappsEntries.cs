using CraftyEngine.Content;

namespace BankModule
{
	public class InappsEntries : ContentItem
	{
		public int id;

		public string inapp;

		public string pf;

		public string description;

		public int sort_val;

		public string currency;

		public float price;

		public int money_type;

		public int money;

		public string icon;

		public int flags;

		public int enabled;

		public override void Deserialize()
		{
			id = TryGetInt(BankContentKeys.id);
			intKey = id;
			inapp = TryGetString(BankContentKeys.inapp, string.Empty);
			pf = TryGetString(BankContentKeys.pf, string.Empty);
			description = TryGetString(BankContentKeys.description, string.Empty);
			sort_val = TryGetInt(BankContentKeys.sort_val);
			currency = TryGetString(BankContentKeys.currency, string.Empty);
			price = TryGetFloat(BankContentKeys.price);
			money_type = TryGetInt(BankContentKeys.money_type);
			money = TryGetInt(BankContentKeys.money);
			icon = TryGetString(BankContentKeys.icon, string.Empty);
			flags = TryGetInt(BankContentKeys.flags);
			enabled = TryGetInt(BankContentKeys.enabled);
			base.Deserialize();
		}
	}
}
