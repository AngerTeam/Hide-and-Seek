using CraftyEngine.Content;

namespace DailyBonusModule
{
	public class DailyBonusContentMap : ContentMapBase
	{
		public static DailyBonusSettingsEntries DailyBonusSettings;

		public override void Deserialize()
		{
			DailyBonusKeys.Deserialize();
			DailyBonusSettings = FillSettings<DailyBonusSettingsEntries>("settings");
			base.Deserialize();
		}
	}
}
