using Interlace.Amf;

namespace RemoteData.Lua
{
	public class PurchaseLuaCommand : RemoteLuaCommand
	{
		private string pf;

		private string udid;

		private string orderId;

		private string inapp;

		private string currency;

		private double price;

		private int moneyType;

		private int money;

		public string signature;

		private string purchaseData;

		public int? notFromStore;

		public int? isOffer;

		public PurchaseLuaCommand(string pf, string udid, string orderId, string inapp, string currency, double price, int moneyType, int money, string purchaseData)
		{
			this.pf = pf;
			this.udid = udid;
			this.orderId = orderId;
			this.inapp = inapp;
			this.currency = currency;
			this.price = price;
			this.moneyType = moneyType;
			this.money = money;
			this.purchaseData = purchaseData;
			cmd = "purchase";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["pf"] = pf;
			amfObject.Properties["udid"] = udid;
			amfObject.Properties["order_id"] = orderId;
			amfObject.Properties["inapp"] = inapp;
			amfObject.Properties["currency"] = currency;
			amfObject.Properties["price"] = price;
			amfObject.Properties["money_type"] = moneyType;
			amfObject.Properties["money"] = money;
			if (signature != null)
			{
				amfObject.Properties["signature"] = signature;
			}
			amfObject.Properties["purchase_data"] = purchaseData;
			if (notFromStore.HasValue)
			{
				amfObject.Properties["notFromStore"] = notFromStore;
			}
			if (isOffer.HasValue)
			{
				amfObject.Properties["is_offer"] = isOffer;
			}
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
			return string.Format("PurchaseLuaCommand: pf: {0}; udid: {1}; orderId: {2}; inapp: {3}; currency: {4}; price: {5}; moneyType: {6}; money: {7}; signature: {8}; purchaseData: {9}; notFromStore: {10}; isOffer: {11};", pf, udid, orderId, inapp, currency, price, moneyType, money, signature, purchaseData, notFromStore, isOffer);
		}
	}
}
