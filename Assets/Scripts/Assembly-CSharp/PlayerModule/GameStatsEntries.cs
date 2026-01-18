using CraftyEngine.Content;

namespace PlayerModule
{
	public class GameStatsEntries : ContentItem
	{
		public string id;

		public int group_id;

		public string title;

		public string description;

		public int visible;

		public override void Deserialize()
		{
			id = TryGetString(PlayerContentKeys.id, string.Empty);
			stringKey = id;
			group_id = TryGetInt(PlayerContentKeys.group_id);
			title = TryGetString(PlayerContentKeys.title, string.Empty);
			description = TryGetString(PlayerContentKeys.description, string.Empty);
			visible = TryGetInt(PlayerContentKeys.visible);
			base.Deserialize();
		}
	}
}
