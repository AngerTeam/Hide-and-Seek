using Interlace.Amf;

namespace RemoteData.Socket
{
	public class FinInstanceMessage : RemoteMessage
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
			return string.Format("FinInstanceMessage:");
		}
	}
}
