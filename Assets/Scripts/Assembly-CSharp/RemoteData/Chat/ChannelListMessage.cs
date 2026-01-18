using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Chat
{
	public class ChannelListMessage : RemoteMessage
	{
		public ChannelMessage[] channelList;

		public ChannelListMessage(ChannelMessage[] channelList)
		{
			this.channelList = channelList;
		}

		public ChannelListMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			channelList = GetArray<ChannelMessage>(source, "channel_list");
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("ChatChannelListMessage:\n channelList: {0}", ArrayUtils.ArrayToString(channelList, "\n\t"));
		}
	}
}
