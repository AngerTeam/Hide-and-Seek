using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PlayerDamageMessage : RemoteMessage
	{
		public string target;

		public int damage;

		public int health;

		public PlayerDamageMessage(string target, int damage, int health)
		{
			this.target = target;
			this.damage = damage;
			this.health = health;
		}

		public PlayerDamageMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			target = Get<string>(source, "target", false);
			damage = Get<int>(source, "damage", false);
			health = Get<int>(source, "health", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerDamageMessage: target: {0}; damage: {1}; health: {2};", target, damage, health);
		}
	}
}
