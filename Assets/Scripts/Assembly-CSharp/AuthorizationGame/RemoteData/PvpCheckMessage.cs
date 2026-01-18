using Interlace.Amf;
using RemoteData;

namespace AuthorizationGame.RemoteData
{
	public class PvpCheckMessage : RemoteMessage
	{
		public PvpInfoMessage pvpInfo;

		public override void Deserialize(AmfObject source, bool silent)
		{
			pvpInfo = GetMessage<PvpInfoMessage>(source, "pvp_info", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PvpCheckMessage: pvpInfo: {0};", pvpInfo);
		}
	}
}
