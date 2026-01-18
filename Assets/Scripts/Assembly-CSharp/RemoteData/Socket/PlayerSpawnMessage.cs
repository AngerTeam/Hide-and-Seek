using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PlayerSpawnMessage : RemoteMessage
	{
		public string persId;

		public double started;

		public int health;

		public PlayerSpawnMessage(string persId, double started, int health)
		{
			this.persId = persId;
			this.started = started;
			this.health = health;
		}

		public PlayerSpawnMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			persId = Get<string>(source, "pers_id", false);
			started = Get<double>(source, "started", false);
			health = Get<int>(source, "health", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerSpawnMessage: persId: {0}; started: {1}; health: {2};", persId, started, health);
		}
	}
}
