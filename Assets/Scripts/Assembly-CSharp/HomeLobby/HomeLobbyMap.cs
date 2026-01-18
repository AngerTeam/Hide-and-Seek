using CraftyEngine.Content;

namespace HomeLobby
{
	public class HomeLobbyMap : ContentMapBase
	{
		public static HomeLobbySettingsEntries HomeLobbySettings;

		public static LangMap LangTextKeyshomeLobbySettings;

		public override void Deserialize()
		{
			HomeLobbyKeys.Deserialize();
			HomeLobbySettings = FillSettings<HomeLobbySettingsEntries>("settings");
			LangTextKeyshomeLobbySettings = FillSettings<LangMap>("settings");
			base.Deserialize();
		}
	}
}
