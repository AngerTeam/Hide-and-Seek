using Interlace.Amf;
using RemoteData;

namespace TcpIpVoxels.RemoteData
{
	public class VoxelCreateCommand : RemoteCommand
	{
		private int artikulId;

		private string slotId;

		private int x;

		private int y;

		private int z;

		public int? rotation;

		public VoxelCreateCommand(int artikulId, string slotId, IIntVector3 vector)
		{
			this.artikulId = artikulId;
			this.slotId = slotId;
			x = vector.X;
			y = vector.Y;
			z = vector.Z;
			cmd = "voxel_create";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["artikul_id"] = artikulId;
			amfObject.Properties["slot_id"] = slotId;
			amfObject.Properties["x"] = x;
			amfObject.Properties["y"] = y;
			amfObject.Properties["z"] = z;
			if (rotation.HasValue)
			{
				amfObject.Properties["rotation"] = rotation;
			}
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
			return string.Format("VoxelCreateCommand: artikulId: {0}; slotId: {1}; x: {2}; y: {3}; z: {4}; rotation: {5};", artikulId, slotId, x, y, z, rotation);
		}
	}
}
