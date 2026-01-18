using Interlace.Amf;

namespace RemoteData.Socket
{
	public class CommonMessage : RemoteMessage
	{
		public double serverTime;

		public CommonMessage(double serverTime)
		{
			this.serverTime = serverTime;
		}

		public CommonMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			serverTime = Get<double>(source, "server_time", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("CommonMessage: serverTime: {0};", serverTime);
		}
	}
}
