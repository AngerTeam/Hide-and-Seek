using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PvpBattleMessage : RemoteMessage
	{
		public int health;

		public double hit1Time;

		public int hit1Cooldown;

		public double hit2Time;

		public int hit2Cooldown;

		public int ready;

		public double started;

		public int visible;

		public double healthUtime;

		public int kills;

		public int side;

		public int defaultHideVoxelId;

		public int hideVoxelId;

		public PvpBattleMessage(int health, double hit1Time, int hit1Cooldown, double hit2Time, int hit2Cooldown, int ready, double started, double healthUtime, int kills, int side, int defaultHideVoxelId, int hideVoxelId)
		{
			this.health = health;
			this.hit1Time = hit1Time;
			this.hit1Cooldown = hit1Cooldown;
			this.hit2Time = hit2Time;
			this.hit2Cooldown = hit2Cooldown;
			this.ready = ready;
			this.started = started;
			this.healthUtime = healthUtime;
			this.kills = kills;
			this.side = side;
			this.defaultHideVoxelId = defaultHideVoxelId;
			this.hideVoxelId = hideVoxelId;
		}

		public PvpBattleMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			health = Get<int>(source, "health", false);
			hit1Time = Get<double>(source, "hit1_time", false);
			hit1Cooldown = Get<int>(source, "hit1_cooldown", false);
			hit2Time = Get<double>(source, "hit2_time", false);
			hit2Cooldown = Get<int>(source, "hit2_cooldown", false);
			ready = Get<int>(source, "ready", false);
			started = Get<double>(source, "started", false);
			visible = Get<int>(source, "visible", true);
			healthUtime = Get<double>(source, "health_utime", false);
			kills = Get<int>(source, "kills", false);
			side = Get<int>(source, "side", false);
			defaultHideVoxelId = Get<int>(source, "default_hide_voxel_id", false);
			hideVoxelId = Get<int>(source, "hide_voxel_id", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PvpBattleMessage: health: {0}; hit1Time: {1}; hit1Cooldown: {2}; hit2Time: {3}; hit2Cooldown: {4}; ready: {5}; started: {6}; visible: {7}; healthUtime: {8}; kills: {9}; side: {10}; defaultHideVoxelId: {11}; hideVoxelId: {12};", health, hit1Time, hit1Cooldown, hit2Time, hit2Cooldown, ready, started, visible, healthUtime, kills, side, defaultHideVoxelId, hideVoxelId);
		}
	}
}
