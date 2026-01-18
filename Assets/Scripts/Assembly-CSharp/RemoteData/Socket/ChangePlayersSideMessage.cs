using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class ChangePlayersSideMessage : RemoteMessage
	{
		public StagePlayerMessage[] stagePlayers;

		public ChangePlayersSideMessage(StagePlayerMessage[] stagePlayers)
		{
			this.stagePlayers = stagePlayers;
		}

		public ChangePlayersSideMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			stagePlayers = GetArray<StagePlayerMessage>(source, "stage_players");
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("ChangePlayersSideMessage:\n stagePlayers: {0}", ArrayUtils.ArrayToString(stagePlayers, "\n\t"));
		}
	}
}
