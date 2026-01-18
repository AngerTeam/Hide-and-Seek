using CraftyEngine.Utils;
using Interlace.Amf;
using RemoteData;

namespace TcpIpVoxels.RemoteData
{
	public class VoxelDestroyResponse : RemoteMessage
	{
		public LootMessage loot;

		public LootMessage[] lootList;

		public override void Deserialize(AmfObject source, bool silent)
		{
			loot = GetMessage<LootMessage>(source, "loot", true);
			lootList = GetArray<LootMessage>(source, "loot_list", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("VoxelDestroyResponse: loot: {0};\n lootList: {1}", loot, ArrayUtils.ArrayToString(lootList, "\n\t"));
		}
	}
}
