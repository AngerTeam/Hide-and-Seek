using CraftyEngine.Utils;
using Interlace.Amf;
using RemoteData;

namespace AuthorizationGame.RemoteData
{
	public class PvpInfoResponse : RemoteMessage
	{
		public MapInfoMessage[] mapInfo;

		public PvpInfoResponse(MapInfoMessage[] mapInfo)
		{
			this.mapInfo = mapInfo;
		}

		public PvpInfoResponse()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			mapInfo = GetArray<MapInfoMessage>(source, "map_info");
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PvpInfoResponse:\n mapInfo: {0}", ArrayUtils.ArrayToString(mapInfo, "\n\t"));
		}
	}
}
