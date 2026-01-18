using Interlace.Amf;

namespace RemoteData.Chat
{
	public class AbuseCommand : RemoteCommand
	{
		private string channelId;

		private string authorId;

		private string text;

		public AbuseCommand(string channelId, string authorId, string text)
		{
			this.channelId = channelId;
			this.authorId = authorId;
			this.text = text;
			cmd = "abuse";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["channel_id"] = channelId;
			amfObject.Properties["author_id"] = authorId;
			amfObject.Properties["text"] = text;
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
			return string.Format("ChatAbuseCommand: channelId: {0}; authorId: {1}; text: {2};", channelId, authorId, text);
		}
	}
}
