using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class StartStageMessage : RemoteMessage
	{
		public int stage;

		public double started;

		public StagePlayerMessage[] stagePlayers;

		public MemberMessage[] membersUpdate;

		public StartStageMessage(int stage, double started)
		{
			this.stage = stage;
			this.started = started;
		}

		public StartStageMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			stage = Get<int>(source, "stage", false);
			started = Get<double>(source, "started", false);
			stagePlayers = GetArray<StagePlayerMessage>(source, "stage_players", true);
			membersUpdate = GetArray<MemberMessage>(source, "members_update", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("StartStageMessage: stage: {0}; started: {1};\n stagePlayers: {2}\n membersUpdate: {3}", stage, started, ArrayUtils.ArrayToString(stagePlayers, "\n\t"), ArrayUtils.ArrayToString(membersUpdate, "\n\t"));
		}
	}
}
