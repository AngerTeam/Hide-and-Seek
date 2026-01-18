namespace Chat
{
	public class ChatContentKeys
	{
		public static string ChatFontSize;

		public static string ChatLinePlayersColors;

		public static string ChatLineSystemColors;

		public static string ChatMaxLines;

		public static string chatMessageLifetime;

		public static string chatMessageLimitCount;

		public static string chatMessageLimitTime;

		public static string ChatReconnectDelay;

		public static string chat_settings;

		public static void Deserialize()
		{
			ChatFontSize = "ChatFontSize";
			ChatLinePlayersColors = "ChatLinePlayersColors";
			ChatLineSystemColors = "ChatLineSystemColors";
			ChatMaxLines = "ChatMaxLines";
			chatMessageLifetime = "chatMessageLifetime";
			chatMessageLimitCount = "chatMessageLimitCount";
			chatMessageLimitTime = "chatMessageLimitTime";
			ChatReconnectDelay = "ChatReconnectDelay";
			chat_settings = "chat_settings";
		}
	}
}
