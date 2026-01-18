using Interlace.Amf;

namespace RemoteData.Lua
{
	public class PvpLastIslandsMessage : RemoteMessage
	{
		public int islandId;

		public string instanceId;

		public int ctime;

		public PvpLastIslandsMessage(int islandId, string instanceId)
		{
			this.islandId = islandId;
			this.instanceId = instanceId;
		}

		public PvpLastIslandsMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			islandId = Get<int>(source, "island_id", false);
			instanceId = Get<string>(source, "instance_id", false);
			ctime = Get<int>(source, "ctime", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PvpLastIslandsMessage: islandId: {0}; instanceId: {1}; ctime: {2};", islandId, instanceId, ctime);
		}
	}
}
