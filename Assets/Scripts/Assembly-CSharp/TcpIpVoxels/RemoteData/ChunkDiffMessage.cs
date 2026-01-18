using Interlace.Amf;
using RemoteData;

namespace TcpIpVoxels.RemoteData
{
	public class ChunkDiffMessage : RemoteMessage
	{
		public int x;

		public int y;

		public int z;

		public string voxelsDiff;

		public string rotationsDiff;

		public ChunkDiffMessage(string voxelsDiff, string rotationsDiff, IIntVector3 vector)
		{
			this.voxelsDiff = voxelsDiff;
			this.rotationsDiff = rotationsDiff;
			x = vector.X;
			y = vector.Y;
			z = vector.Z;
		}

		public ChunkDiffMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			x = Get<int>(source, "x", false);
			y = Get<int>(source, "y", false);
			z = Get<int>(source, "z", false);
			voxelsDiff = Get<string>(source, "voxels_diff", false);
			rotationsDiff = Get<string>(source, "rotations_diff", false);
		}

		public override string ToString()
		{
			return string.Format("ChunkDiffMessage: x: {0}; y: {1}; z: {2}; voxelsDiff: {3}; rotationsDiff: {4};", x, y, z, voxelsDiff, rotationsDiff);
		}
	}
}
