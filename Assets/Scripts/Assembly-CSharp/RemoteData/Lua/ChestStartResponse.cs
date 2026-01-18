using Interlace.Amf;

namespace RemoteData.Lua
{
	public class ChestStartResponse : RemoteMessage
	{
		public double startTime;

		public ChestStartResponse(double startTime)
		{
			this.startTime = startTime;
		}

		public ChestStartResponse()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			startTime = Get<double>(source, "start_time", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("ChestStartResponse: startTime: {0};", startTime);
		}
	}
}
