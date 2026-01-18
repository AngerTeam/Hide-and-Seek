using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PlayerMessage : RemoteMessage
	{
		public string name;

		public string persId;

		public int health;

		public int level;

		public int skinId;

		public double started;

		public int side;

		public int ready;

		public int hideVoxelId;

		public PlayerHideMessage hidePosition;

		public PlayerMessage(string name, string persId, int skinId, int ready, int hideVoxelId)
		{
			this.name = name;
			this.persId = persId;
			this.skinId = skinId;
			this.ready = ready;
			this.hideVoxelId = hideVoxelId;
		}

		public PlayerMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			name = Get<string>(source, "name", false);
			persId = Get<string>(source, "pers_id", false);
			health = Get<int>(source, "health", true);
			level = Get<int>(source, "level", true);
			skinId = Get<int>(source, "skin_id", false);
			started = Get<double>(source, "started", true);
			side = Get<int>(source, "side", true);
			ready = Get<int>(source, "ready", false);
			hideVoxelId = Get<int>(source, "hide_voxel_id", false);
			hidePosition = GetMessage<PlayerHideMessage>(source, "hide_position", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerMessage: name: {0}; persId: {1}; health: {2}; level: {3}; skinId: {4}; started: {5}; side: {6}; ready: {7}; hideVoxelId: {8}; hidePosition: {9};", name, persId, health, level, skinId, started, side, ready, hideVoxelId, hidePosition);
		}
	}
}
