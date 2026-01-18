using Interlace.Amf;

namespace RemoteData
{
	public class HideVoxelsMessage : RemoteMessage
	{
		public int voxelId;

		public int count;

		public HideVoxelsMessage(int voxelId, int count)
		{
			this.voxelId = voxelId;
			this.count = count;
		}

		public HideVoxelsMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			voxelId = Get<int>(source, "voxel_id", false);
			count = Get<int>(source, "cnt", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("HideVoxelsMessage: voxelId: {0}; count: {1};", voxelId, count);
		}
	}
}
