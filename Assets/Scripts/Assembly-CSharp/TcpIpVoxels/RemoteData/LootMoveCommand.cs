using Interlace.Amf;
using RemoteData;

namespace TcpIpVoxels.RemoteData
{
	public class LootMoveCommand : RemoteCommand
	{
		private int artikulId;

		private int lootId;

		private int x;

		private int y;

		private int z;

		public LootMoveCommand(int artikulId, int lootId, IIntVector3 vector)
		{
			this.artikulId = artikulId;
			this.lootId = lootId;
			x = vector.X;
			y = vector.Y;
			z = vector.Z;
			cmd = "loot_move";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["artikul_id"] = artikulId;
			amfObject.Properties["loot_id"] = lootId;
			amfObject.Properties["x"] = x;
			amfObject.Properties["y"] = y;
			amfObject.Properties["z"] = z;
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
			return string.Format("LootMoveCommand: artikulId: {0}; lootId: {1}; x: {2}; y: {3}; z: {4};", artikulId, lootId, x, y, z);
		}
	}
}
