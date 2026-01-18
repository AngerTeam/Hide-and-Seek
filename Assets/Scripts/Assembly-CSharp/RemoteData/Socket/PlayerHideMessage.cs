using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PlayerHideMessage : RemoteMessage
	{
		public string persId;

		public int x;

		public int y;

		public int z;

		public int voxelId;

		public int rotation;

		public PlayerHideMessage(int voxelId, int rotation, IIntVector3 vector)
		{
			this.voxelId = voxelId;
			this.rotation = rotation;
			x = vector.X;
			y = vector.Y;
			z = vector.Z;
		}

		public PlayerHideMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			persId = Get<string>(source, "pers_id", true);
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
			return string.Format("PlayerHideMessage: persId: {0}; x: {1}; y: {2}; z: {3}; voxelId: {4}; rotation: {5};", persId, x, y, z, voxelId, rotation);
		}
	}
}
