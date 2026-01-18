using Interlace.Amf;

namespace RemoteData.Socket
{
	public class VoxelMessage : RemoteMessage
	{
		public int x;

		public int y;

		public int z;

		public int voxelId;

		public int rotation;

		public VoxelMessage(int voxelId, int rotation, IIntVector3 vector)
		{
			this.voxelId = voxelId;
			this.rotation = rotation;
			x = vector.X;
			y = vector.Y;
			z = vector.Z;
		}

		public VoxelMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			x = Get<int>(source, "x", false);
			y = Get<int>(source, "y", false);
			z = Get<int>(source, "z", false);
			voxelId = Get<int>(source, "voxel_id", false);
			rotation = Get<int>(source, "rotation", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("VoxelMessage: x: {0}; y: {1}; z: {2}; voxelId: {3}; rotation: {4};", x, y, z, voxelId, rotation);
		}
	}
}
