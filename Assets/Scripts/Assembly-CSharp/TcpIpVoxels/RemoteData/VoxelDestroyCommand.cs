using Interlace.Amf;
using RemoteData;

namespace TcpIpVoxels.RemoteData
{
	public class VoxelDestroyCommand : RemoteCommand
	{
		private int artikulId;

		private int x;

		private int y;

		private int z;

		public VoxelDestroyCommand(int artikulId, IIntVector3 vector)
		{
			this.artikulId = artikulId;
			x = vector.X;
			y = vector.Y;
			z = vector.Z;
			cmd = "voxel_destroy";
		}

		public override AmfObject Serialize(bool silent = false)
		{
			AmfObject amfObject = GetAmfObject();
			amfObject.Properties["artikul_id"] = artikulId;
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
			return string.Format("VoxelDestroyCommand: artikulId: {0}; x: {1}; y: {2}; z: {3};", artikulId, x, y, z);
		}
	}
}
