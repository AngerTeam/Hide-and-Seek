using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PlayerInMessage : RemoteMessage
	{
		public PlayerMessage player;

		public PlayerInMessage(PlayerMessage player)
		{
			this.player = player;
		}

		public PlayerInMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			player = GetMessage<PlayerMessage>(source, "player");
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerInMessage: player: {0};", player);
		}
	}
}
