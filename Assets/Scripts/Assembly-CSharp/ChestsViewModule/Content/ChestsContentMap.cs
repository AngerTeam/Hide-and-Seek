using CraftyEngine.Content;

namespace ChestsViewModule.Content
{
	public class ChestsContentMap : ContentMapBase
	{
		public static ChestSettingsEntries ChestSettings;

		public override void Deserialize()
		{
			ChestsContentKeys.Deserialize();
			ChestSettings = FillSettings<ChestSettingsEntries>("settings");
			base.Deserialize();
		}
	}
}
