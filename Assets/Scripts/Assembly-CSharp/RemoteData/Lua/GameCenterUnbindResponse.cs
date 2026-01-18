using Interlace.Amf;

namespace RemoteData.Lua
{
	public class GameCenterUnbindResponse : RemoteMessage
	{
		public override void Deserialize(AmfObject source, bool silent)
		{
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("GameCenterUnbindResponse:");
		}
	}
}
