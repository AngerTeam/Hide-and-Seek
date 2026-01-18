using Interlace.Amf;
using RemoteData;

namespace TcpIpVoxels.RemoteData
{
	public class LootTakeCommand : RemoteCommand
	{
		private int artikulId;

		private int lootId;

		private string slotId;

		private int count;

		public LootTakeCommand(int artikulId, int lootId, string slotId, int count)
		{
			this.artikulId = artikulId;
			this.lootId = lootId;
			this.slotId = slotId;
			this.count = count;
			cmd = "loot_take";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["artikul_id"] = artikulId;
			amfObject.Properties["loot_id"] = lootId;
			amfObject.Properties["slot_id"] = slotId;
			amfObject.Properties["cnt"] = count;
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
			return string.Format("LootTakeCommand: artikulId: {0}; lootId: {1}; slotId: {2}; count: {3};", artikulId, lootId, slotId, count);
		}
	}
}
