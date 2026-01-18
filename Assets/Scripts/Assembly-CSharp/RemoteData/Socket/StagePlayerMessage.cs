using Interlace.Amf;

namespace RemoteData.Socket
{
	public class StagePlayerMessage : RemoteMessage
	{
		public string persId;

		public int side;

		public int hideVoxelId;

		public VectorMessage position;

		public VectorMessage rotation;

		public StagePlayerMessage(string persId, int side)
		{
			this.persId = persId;
			this.side = side;
		}

		public StagePlayerMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			persId = Get<string>(source, "pers_id", false);
			side = Get<int>(source, "side", false);
			hideVoxelId = Get<int>(source, "hide_voxel_id", true);
			position = GetMessage<VectorMessage>(source, "position", true);
			rotation = GetMessage<VectorMessage>(source, "rotation", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("StagePlayerMessage: persId: {0}; side: {1}; hideVoxelId: {2}; position: {3}; rotation: {4};", persId, side, hideVoxelId, position, rotation);
		}
	}
}
