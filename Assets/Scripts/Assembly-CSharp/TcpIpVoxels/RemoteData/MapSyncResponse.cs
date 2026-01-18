using Interlace.Amf;
using RemoteData;

namespace TcpIpVoxels.RemoteData
{
	public class MapSyncResponse : RemoteMessage
	{
		public int packets;

		public MapSyncResponse(int packets)
		{
			this.packets = packets;
		}

		public MapSyncResponse()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			packets = Get<int>(source, "packets", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("MapSyncResponse: packets: {0};", packets);
		}
	}
}
