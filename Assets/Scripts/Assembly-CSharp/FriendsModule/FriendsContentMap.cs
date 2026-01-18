using CraftyEngine.Content;

namespace FriendsModule
{
	public class FriendsContentMap : ContentMapBase
	{
		public static FiendsSettingsEntries FiendsSettings;

		public override void Deserialize()
		{
			FriendsContentKeys.Deserialize();
			FiendsSettings = FillSettings<FiendsSettingsEntries>("settings");
			base.Deserialize();
		}
	}
}
