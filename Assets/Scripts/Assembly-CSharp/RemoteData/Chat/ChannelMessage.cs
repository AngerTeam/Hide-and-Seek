using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Chat
{
	public class ChannelMessage : RemoteMessage
	{
		public string id;

		public ChatMessageMessage[] messages;

		public string name;

		public int type;

		public ChannelMessage(string id, ChatMessageMessage[] messages, string name, int type)
		{
			this.id = id;
			this.messages = messages;
			this.name = name;
			this.type = type;
		}

		public ChannelMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			id = Get<string>(source, "id", false);
			messages = GetArray<ChatMessageMessage>(source, "messages");
			name = Get<string>(source, "name", false);
			type = Get<int>(source, "type", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("ChatChannelMessage: id: {0}; name: {1}; type: {2};\n messages: {3}", id, name, type, ArrayUtils.ArrayToString(messages, "\n\t"));
		}
	}
}
