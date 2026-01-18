using CraftyEngine.Content;

namespace DailyBonusModule
{
	public class DailyBonusSettingsEntries : ContentItem
	{
		public int dailyBonusID = 162;

		public int dailyBonusTimeout = 14400;

		public int dailyBonusPrice = 10;

		public int DAILY_CHEST_ARTIKUL_ID = 482;

		public override void Deserialize()
		{
			dailyBonusID = TryGetInt(DailyBonusKeys.dailyBonusID, 162);
			dailyBonusTimeout = TryGetInt(DailyBonusKeys.dailyBonusTimeout, 14400);
			dailyBonusPrice = TryGetInt(DailyBonusKeys.dailyBonusPrice, 10);
			DAILY_CHEST_ARTIKUL_ID = TryGetInt(DailyBonusKeys.DAILY_CHEST_ARTIKUL_ID, 482);
			base.Deserialize();
		}
	}
}
