using Interlace.Amf;
using RemoteData;

namespace AuthorizationGame.RemoteData
{
	public class MapInfoMessage : RemoteMessage
	{
		public int islandId;

		public int instances;

		public MapInfoMessage(int islandId, int instances)
		{
			this.islandId = islandId;
			this.instances = instances;
		}

		public MapInfoMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			islandId = Get<int>(source, "island_id", false);
			instances = Get<int>(source, "instances", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("MapInfoMessage: islandId: {0}; instances: {1};", islandId, instances);
		}
	}
}
