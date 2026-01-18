using Interlace.Amf;

namespace RemoteData.Socket
{
	public class TopRewardMessage : RemoteMessage
	{
		public string persId;

		public int moneyType;

		public int money;

		public int chestArtikulId;

		public TopRewardMessage(string persId, int moneyType, int money)
		{
			this.persId = persId;
			this.moneyType = moneyType;
			this.money = money;
		}

		public TopRewardMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			persId = Get<string>(source, "pers_id", false);
			moneyType = Get<int>(source, "money_type", false);
			money = Get<int>(source, "money", false);
			chestArtikulId = Get<int>(source, "chest_artikul_id", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("TopRewardMessage: persId: {0}; moneyType: {1}; money: {2}; chestArtikulId: {3};", persId, moneyType, money, chestArtikulId);
		}
	}
}
