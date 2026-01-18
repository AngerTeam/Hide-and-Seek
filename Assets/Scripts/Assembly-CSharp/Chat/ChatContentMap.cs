using CraftyEngine.Content;

namespace Chat
{
	public class ChatContentMap : ContentMapBase
	{
		public static ChatSettingsEntries ChatSettings;

		public override void Deserialize()
		{
			ChatContentKeys.Deserialize();
			ChatSettings = FillSettings<ChatSettingsEntries>("settings");
			base.Deserialize();
		}
	}
}
