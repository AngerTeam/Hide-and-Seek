using CraftyEngine.Content;

namespace MyPlayerInput
{
	public class MyPlayerInputContentMap : ContentMapBase
	{
		public static PlayerSettingsEntries PlayerSettings;

		public override void Deserialize()
		{
			MyPlayerInputContentKeys.Deserialize();
			PlayerSettings = FillSettings<PlayerSettingsEntries>("settings");
			base.Deserialize();
		}
	}
}
