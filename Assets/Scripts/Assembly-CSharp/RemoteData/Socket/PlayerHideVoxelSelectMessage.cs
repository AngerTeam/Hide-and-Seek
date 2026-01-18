using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PlayerHideVoxelSelectMessage : RemoteMessage
	{
		public string persId;

		public int voxelId;

		public PlayerHideVoxelSelectMessage(string persId, int voxelId)
		{
			this.persId = persId;
			this.voxelId = voxelId;
		}

		public PlayerHideVoxelSelectMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			persId = Get<string>(source, "pers_id", false);
			voxelId = Get<int>(source, "voxel_id", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerHideVoxelSelectMessage: persId: {0}; voxelId: {1};", persId, voxelId);
		}
	}
}
