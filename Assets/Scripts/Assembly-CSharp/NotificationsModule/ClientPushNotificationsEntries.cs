using CraftyEngine.Content;

namespace NotificationsModule
{
	public class ClientPushNotificationsEntries : ContentItem
	{
		public int id;

		public string push_text;

		public int timer;

		public int group_id;

		public override void Deserialize()
		{
			id = TryGetInt(NotificationsContentKeys.id);
			intKey = id;
			push_text = TryGetString(NotificationsContentKeys.push_text, string.Empty);
			timer = TryGetInt(NotificationsContentKeys.timer);
			group_id = TryGetInt(NotificationsContentKeys.group_id);
			base.Deserialize();
		}
	}
}
