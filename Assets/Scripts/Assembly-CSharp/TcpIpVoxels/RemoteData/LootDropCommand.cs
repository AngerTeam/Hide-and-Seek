using Interlace.Amf;
using RemoteData;

namespace TcpIpVoxels.RemoteData
{
	public class LootDropCommand : RemoteCommand
	{
		private string slotId;

		private int artikulId;

		private int count;

		private int lootId;

		private double lootX;

		private double lootY;

		private double lootZ;

		public LootDropCommand(string slotId, int artikulId, int count, int lootId, double lootX, double lootY, double lootZ)
		{
			this.slotId = slotId;
			this.artikulId = artikulId;
			this.count = count;
			this.lootId = lootId;
			this.lootX = lootX;
			this.lootY = lootY;
			this.lootZ = lootZ;
			cmd = "loot_drop";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["slot_id"] = slotId;
			amfObject.Properties["artikul_id"] = artikulId;
			amfObject.Properties["cnt"] = count;
			amfObject.Properties["loot_id"] = lootId;
			amfObject.Properties["loot_x"] = lootX;
			amfObject.Properties["loot_y"] = lootY;
			amfObject.Properties["loot_z"] = lootZ;
			amfObject.Properties["cmd"] = cmd;
			amfObject.Properties["ts"] = ts;
			amfObject.Properties["sig"] = sig;
			if (!silent)
			{
				Log.Online(ToString());
			}
			return amfObject;
		}

		public override string ToString()
		{
			return string.Format("LootDropCommand: slotId: {0}; artikulId: {1}; count: {2}; lootId: {3}; lootX: {4}; lootY: {5}; lootZ: {6};", slotId, artikulId, count, lootId, lootX, lootY, lootZ);
		}
	}
}
