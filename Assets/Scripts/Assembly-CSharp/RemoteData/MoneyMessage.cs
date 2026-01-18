using Interlace.Amf;

namespace RemoteData
{
	public class MoneyMessage : RemoteMessage
	{
		public int moneyType;

		public int money;

		public MoneyMessage(int moneyType, int money)
		{
			this.moneyType = moneyType;
			this.money = money;
		}

		public MoneyMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			moneyType = Get<int>(source, "money_type", false);
			money = Get<int>(source, "money", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("MoneyMessage: moneyType: {0}; money: {1};", moneyType, money);
		}
	}
}
