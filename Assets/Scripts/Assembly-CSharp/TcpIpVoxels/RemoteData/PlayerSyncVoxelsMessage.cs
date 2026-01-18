using CraftyEngine.Utils;
using Interlace.Amf;
using RemoteData;

namespace TcpIpVoxels.RemoteData
{
	public class PlayerSyncVoxelsMessage : PurchaseMessage
	{
		public LootMessage[] loot;

		public override void Deserialize(AmfObject source, bool silent)
		{
			loot = GetArray<LootMessage>(source, "loot", true);
			base.Deserialize(source, true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerSyncVoxelsMessage:\n loot: {0}", ArrayUtils.ArrayToString(loot, "\n\t")) + base.ToString();
		}
	}
}
