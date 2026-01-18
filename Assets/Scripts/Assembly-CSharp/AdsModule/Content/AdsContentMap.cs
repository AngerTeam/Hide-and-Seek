using CraftyEngine.Content;

namespace AdsModule.Content
{
	public class AdsContentMap : ContentMapBase
	{
		public static AdsSettingsEntries AdsSettings;

		public override void Deserialize()
		{
			AdsContentKeys.Deserialize();
			AdsSettings = FillSettings<AdsSettingsEntries>("settings");
			base.Deserialize();
		}
	}
}
