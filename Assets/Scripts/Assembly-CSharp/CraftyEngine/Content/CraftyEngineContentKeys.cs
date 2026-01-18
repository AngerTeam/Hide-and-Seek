namespace CraftyEngine.Content
{
	public class CraftyEngineContentKeys
	{
		public static string id;

		public static string title;

		public static string description;

		public static string message;

		public static string message_size;

		public static string message_color;

		public static string view_mode;

		public static string is_critical;

		public static string admin_only;

		public static string event_counter;

		public static string reset_timeout;

		public static string for_stat;

		public static string exceptions;

		public static void Deserialize()
		{
			id = "id";
			title = "title";
			description = "description";
			message = "message";
			message_size = "message_size";
			message_color = "message_color";
			view_mode = "view_mode";
			is_critical = "is_critical";
			admin_only = "admin_only";
			event_counter = "event_counter";
			reset_timeout = "reset_timeout";
			for_stat = "for_stat";
			exceptions = "exceptions";
		}
	}
}
