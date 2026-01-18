using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PlayersUpdateMessage : RemoteMessage
	{
		public PlayerStatusMessage[] players;

		public PlayersUpdateMessage(PlayerStatusMessage[] players)
		{
			this.players = players;
		}

		public PlayersUpdateMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			players = GetArray<PlayerStatusMessage>(source, "players");
		}

		public override string ToString()
		{
			return string.Format("PlayersUpdateMessage:\n players: {0}", ArrayUtils.ArrayToString(players, "\n\t"));
		}
	}
}
