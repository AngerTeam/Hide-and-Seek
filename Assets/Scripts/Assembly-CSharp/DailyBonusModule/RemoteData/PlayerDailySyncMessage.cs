using CraftyEngine.Utils;
using Interlace.Amf;
using RemoteData;

namespace DailyBonusModule.RemoteData
{
	public class PlayerDailySyncMessage : RemoteMessage
	{
		public DailyBonusMessage[] dailyBonus;

		public override void Deserialize(AmfObject source, bool silent)
		{
			dailyBonus = GetArray<DailyBonusMessage>(source, "daily_bonus", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerDailySyncMessage:\n dailyBonus: {0}", ArrayUtils.ArrayToString(dailyBonus, "\n\t"));
		}
	}
}
