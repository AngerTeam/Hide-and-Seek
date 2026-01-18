using Interlace.Amf;

namespace RemoteData.Lua
{
	public class GameCenterBindResponse : RemoteMessage
	{
		public BindPlayerMessage bindPlayer;

		public override void Deserialize(AmfObject source, bool silent)
		{
			bindPlayer = GetMessage<BindPlayerMessage>(source, "bind_player", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("GameCenterBindResponse: bindPlayer: {0};", bindPlayer);
		}
	}
}
