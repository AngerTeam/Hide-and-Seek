namespace CraftyEngine.Content
{
	public class ExceptionsEntries : ContentItem
	{
		public int id;

		public string title;

		public string description;

		public string message;

		public int message_size;

		public string message_color;

		public int view_mode;

		public int is_critical;

		public int admin_only;

		public int event_counter;

		public int reset_timeout;

		public int for_stat;

		public override void Deserialize()
		{
			id = TryGetInt(CraftyEngineContentKeys.id);
			intKey = id;
			title = TryGetString(CraftyEngineContentKeys.title, string.Empty);
			description = TryGetString(CraftyEngineContentKeys.description, string.Empty);
			message = TryGetString(CraftyEngineContentKeys.message, string.Empty);
			message_size = TryGetInt(CraftyEngineContentKeys.message_size);
			message_color = TryGetString(CraftyEngineContentKeys.message_color, string.Empty);
			view_mode = TryGetInt(CraftyEngineContentKeys.view_mode);
			is_critical = TryGetInt(CraftyEngineContentKeys.is_critical);
			admin_only = TryGetInt(CraftyEngineContentKeys.admin_only);
			event_counter = TryGetInt(CraftyEngineContentKeys.event_counter);
			reset_timeout = TryGetInt(CraftyEngineContentKeys.reset_timeout);
			for_stat = TryGetInt(CraftyEngineContentKeys.for_stat);
			base.Deserialize();
		}
	}
}
