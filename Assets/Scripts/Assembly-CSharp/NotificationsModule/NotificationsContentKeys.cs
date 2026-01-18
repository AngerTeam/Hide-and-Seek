namespace NotificationsModule
{
	public class NotificationsContentKeys
	{
		public static string id;

		public static string push_text;

		public static string timer;

		public static string group_id;

		public static string client_push_notifications;

		public static void Deserialize()
		{
			id = "id";
			push_text = "push_text";
			timer = "timer";
			group_id = "group_id";
			client_push_notifications = "client_push_notifications";
		}
	}
}
