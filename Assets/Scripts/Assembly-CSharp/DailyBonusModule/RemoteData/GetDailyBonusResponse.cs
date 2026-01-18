using Interlace.Amf;
using RemoteData;

namespace DailyBonusModule.RemoteData
{
	public class GetDailyBonusResponse : PurchaseMessage
	{
		public double bonusTime;

		public GetDailyBonusResponse(double bonusTime)
		{
			this.bonusTime = bonusTime;
		}

		public GetDailyBonusResponse()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			bonusTime = Get<double>(source, "bonus_time", false);
			base.Deserialize(source, true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("GetDailyBonusResponse: bonusTime: {0};", bonusTime) + base.ToString();
		}
	}
}
