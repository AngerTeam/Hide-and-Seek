using CraftyEngine.Content;

namespace Chat
{
	public class ChatSettingsEntries : ContentItem
	{
		public int ChatFontSize = 40;

		public string ChatLinePlayersColors = "FF7212;FC1FED;29FFE5;41E800;E10003;7286FF;C3C3C3;";

		public string ChatLineSystemColors = "FFFF32;FF2277;cccccc";

		public int ChatMaxLines = 15;

		public float chatMessageLifetime = 9f;

		public int chatMessageLimitCount = 3;

		public float chatMessageLimitTime = 5f;

		public float ChatReconnectDelay;

		public override void Deserialize()
		{
			ChatFontSize = TryGetInt(ChatContentKeys.ChatFontSize, 40);
			ChatLinePlayersColors = TryGetString(ChatContentKeys.ChatLinePlayersColors, "FF7212;FC1FED;29FFE5;41E800;E10003;7286FF;C3C3C3;");
			ChatLineSystemColors = TryGetString(ChatContentKeys.ChatLineSystemColors, "FFFF32;FF2277;cccccc");
			ChatMaxLines = TryGetInt(ChatContentKeys.ChatMaxLines, 15);
			chatMessageLifetime = TryGetFloat(ChatContentKeys.chatMessageLifetime, 9f);
			chatMessageLimitCount = TryGetInt(ChatContentKeys.chatMessageLimitCount, 3);
			chatMessageLimitTime = TryGetFloat(ChatContentKeys.chatMessageLimitTime, 5f);
			ChatReconnectDelay = TryGetFloat(ChatContentKeys.ChatReconnectDelay);
			base.Deserialize();
		}
	}
}
