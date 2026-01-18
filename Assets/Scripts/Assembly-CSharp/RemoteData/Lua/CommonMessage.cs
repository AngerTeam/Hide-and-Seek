using Interlace.Amf;

namespace RemoteData.Lua
{
	public class CommonMessage : RemoteMessage
	{
		public double serverTime;

		public int userFlags;

		public CommonMessage(double serverTime, int userFlags)
		{
			this.serverTime = serverTime;
			this.userFlags = userFlags;
		}

		public CommonMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			serverTime = Get<double>(source, "server_time", false);
			userFlags = Get<int>(source, "user_flags", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("CommonMessage: serverTime: {0}; userFlags: {1};", serverTime, userFlags);
		}
	}
}
