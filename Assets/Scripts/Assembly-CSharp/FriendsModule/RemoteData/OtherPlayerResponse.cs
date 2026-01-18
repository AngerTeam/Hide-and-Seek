using Interlace.Amf;
using RemoteData;

namespace FriendsModule.RemoteData
{
	public class OtherPlayerResponse : RemoteMessage
	{
		public OtherPlayerMessage otherPlayer;

		public OtherPlayerResponse(OtherPlayerMessage otherPlayer)
		{
			this.otherPlayer = otherPlayer;
		}

		public OtherPlayerResponse()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			otherPlayer = GetMessage<OtherPlayerMessage>(source, "other_player");
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("OtherPlayerResponse: otherPlayer: {0};", otherPlayer);
		}
	}
}
