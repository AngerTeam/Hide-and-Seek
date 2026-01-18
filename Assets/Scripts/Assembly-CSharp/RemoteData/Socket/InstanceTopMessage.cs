using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class InstanceTopMessage : RemoteMessage
	{
		public TopMessage[] top;

		public TeamTopMessage[] teamTop;

		public TeamDataMessage[] teamData;

		public TopRewardMessage[] topRewards;

		public string lastHider;

		public InstanceTopMessage(TopMessage[] top, TopRewardMessage[] topRewards)
		{
			this.top = top;
			this.topRewards = topRewards;
		}

		public InstanceTopMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			top = GetArray<TopMessage>(source, "top");
			teamTop = GetArray<TeamTopMessage>(source, "team_top", true);
			teamData = GetArray<TeamDataMessage>(source, "team_data", true);
			topRewards = GetArray<TopRewardMessage>(source, "top_rewards");
			lastHider = Get<string>(source, "last_hider", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("InstanceTopMessage: lastHider: {0};\n top: {1}\n teamTop: {2}\n teamData: {3}\n topRewards: {4}", lastHider, ArrayUtils.ArrayToString(top, "\n\t"), ArrayUtils.ArrayToString(teamTop, "\n\t"), ArrayUtils.ArrayToString(teamData, "\n\t"), ArrayUtils.ArrayToString(topRewards, "\n\t"));
		}
	}
}
