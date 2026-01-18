using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class SyncInstanceMessage : RemoteMessage
	{
		public PlayerMessage[] players;

		public MemberMessage[] members;

		public string instanceId;

		public double startTime;

		public int stage;

		public double stageTime;

		public TeamDataMessage[] teamData;

		public SyncInstanceMessage(PlayerMessage[] players, MemberMessage[] members, string instanceId, double startTime, int stage, double stageTime)
		{
			this.players = players;
			this.members = members;
			this.instanceId = instanceId;
			this.startTime = startTime;
			this.stage = stage;
			this.stageTime = stageTime;
		}

		public SyncInstanceMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			players = GetArray<PlayerMessage>(source, "players");
			members = GetArray<MemberMessage>(source, "members");
			instanceId = Get<string>(source, "instance_id", false);
			startTime = Get<double>(source, "start_time", false);
			stage = Get<int>(source, "stage", false);
			stageTime = Get<double>(source, "stage_time", false);
			teamData = GetArray<TeamDataMessage>(source, "team_data", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("SyncInstanceMessage: instanceId: {0}; startTime: {1}; stage: {2}; stageTime: {3};\n players: {4}\n members: {5}\n teamData: {6}", instanceId, startTime, stage, stageTime, ArrayUtils.ArrayToString(players, "\n\t"), ArrayUtils.ArrayToString(members, "\n\t"), ArrayUtils.ArrayToString(teamData, "\n\t"));
		}
	}
}
