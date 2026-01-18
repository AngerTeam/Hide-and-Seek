using CraftyEngine.Utils;
using Interlace.Amf;
using RemoteData;

namespace FriendsModule.RemoteData
{
	public class PlayerSearchResponse : RemoteMessage
	{
		public FindPlayerMessage[] players;

		public PlayerSearchResponse(FindPlayerMessage[] players)
		{
			this.players = players;
		}

		public PlayerSearchResponse()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			players = GetArray<FindPlayerMessage>(source, "players");
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerSearchResponse:\n players: {0}", ArrayUtils.ArrayToString(players, "\n\t"));
		}
	}
}
