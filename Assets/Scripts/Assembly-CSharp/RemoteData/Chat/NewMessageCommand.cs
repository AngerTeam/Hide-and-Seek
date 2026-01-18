using Interlace.Amf;

namespace RemoteData.Chat
{
	public class NewMessageCommand : RemoteCommand
	{
		private string channelId;

		private string lang;

		private int type;

		private string text;

		private string sid;

		private int userId;

		private string persId;

		public NewMessageCommand(string channelId, string lang, int type, string text, string sid, int userId, string persId)
		{
			this.channelId = channelId;
			this.lang = lang;
			this.type = type;
			this.text = text;
			this.sid = sid;
			this.userId = userId;
			this.persId = persId;
			cmd = "new_message";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["channel_id"] = channelId;
			amfObject.Properties["lang"] = lang;
			amfObject.Properties["type"] = type;
			amfObject.Properties["text"] = text;
			amfObject.Properties["sid"] = sid;
			amfObject.Properties["user_id"] = userId;
			amfObject.Properties["pers_id"] = persId;
			amfObject.Properties["cmd"] = cmd;
			amfObject.Properties["ts"] = ts;
			amfObject.Properties["sig"] = sig;
			if (!silent)
			{
				Log.Online(ToString());
			}
			return amfObject;
		}

		public override string ToString()
		{
			return string.Format("ChatNewMessageCommand: channelId: {0}; lang: {1}; type: {2}; text: {3}; userId: {4}; persId: {5};", channelId, lang, type, text, userId, persId);
		}
	}
}
