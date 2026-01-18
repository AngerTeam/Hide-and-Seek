using Interlace.Amf;
using RemoteData;

namespace DailyBonusModule.RemoteData
{
	public class DailyBonusMessage : RemoteMessage
	{
		public double bonusTime;

		public DailyBonusMessage(double bonusTime)
		{
			this.bonusTime = bonusTime;
		}

		public DailyBonusMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			bonusTime = Get<double>(source, "bonus_time", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("DailyBonusMessage: bonusTime: {0};", bonusTime);
		}
	}
}
