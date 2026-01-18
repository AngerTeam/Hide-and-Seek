using Interlace.Amf;

namespace RemoteData.Chat
{
	public class ChatMessageMessage : RemoteMessage
	{
		private const int CHAT_MSG_TYPE_NOTICE_PLAYER_PVP_ENTER = 1003;

		private const int CHAT_MSG_TYPE_NOTICE_PLAYER_PVP_EXIT = 1004;

		private const int CHAT_MSG_TYPE_NOTICE_PLAYER_PVP_KILL = 1005;

		private const int CHAT_MSG_TYPE_NOTICE_PLAYER_FOUND = 1006;

		private const int CHAT_MSG_TYPE_NOTICE_PLAYER_BECAME_SEEKER = 1007;

		public static bool hideNSeek;

		public long timestamp;

		public bool isCurrentPlayer;

		public string persId;

		public string name;

		public int userType;

		public string lang;

		public int type;

		public string text;

		public double ts;

		public ValuesMessage values;

		public ChatMessageMessage(string name, int userType, string lang, int type, string text, double ts)
		{
			this.name = name;
			this.userType = userType;
			this.lang = lang;
			this.type = type;
			this.text = text;
			this.ts = ts;
		}

		public ChatMessageMessage()
		{
		}

		public string ToBbCode(string color)
		{
			return GetText(values, name, text, userType, type, color);
		}

		private string GetText(ValuesMessage textValues, string userName, string text, int usrType, int messageType, string color)
		{
			string arg;
			switch (messageType)
			{
			case 1003:
			{
				string key2 = ((!hideNSeek) ? "UI_Chat_Enter" : "UI_Chat_Enter_HideAndSeek");
				arg = string.Format(Localisations.Get(key2), textValues.name);
				break;
			}
			case 1004:
			{
				string key = ((!hideNSeek) ? "UI_Chat_Exit" : "UI_Chat_Exit_HideAndSeek");
				arg = string.Format(Localisations.Get(key), textValues.name);
				break;
			}
			case 1005:
				arg = string.Format(Localisations.Get("UI_Chat_Frag"), textValues.killer, textValues.deadman);
				break;
			case 1006:
				arg = string.Format(Localisations.Get("UI_Chat_Player_Found"), textValues.seeker, textValues.hider);
				break;
			case 1007:
				arg = string.Format(Localisations.Get("UI_Chat_Player_Become_Seeker"), textValues.name);
				break;
			default:
				arg = string.Format("{0}: {1}", userName, text);
				break;
			}
			return string.Format("[{0}]{1}[-]", color, arg);
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			persId = Get<string>(source, "pers_id", true);
			name = Get<string>(source, "name", false);
			userType = Get<int>(source, "user_type", false);
			lang = Get<string>(source, "lang", false);
			type = Get<int>(source, "type", false);
			text = Get<string>(source, "text", false);
			ts = Get<double>(source, "ts", false);
			values = GetMessage<ValuesMessage>(source, "values", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("ChatChatMessageMessage: persId: {0}; name: {1}; userType: {2}; lang: {3}; type: {4}; text: {5}; ts: {6}; values: {7};", persId, name, userType, lang, type, text, ts, values);
		}
	}
}
