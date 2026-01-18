using Interlace.Amf;

namespace RemoteData.Socket
{
	public class BattleStatMessage : RemoteMessage
	{
		public int kills;

		public int deads;

		public int skulls;

		public int damage;

		public int killSeriesMax;

		public int exp;

		public BattleStatMessage(int kills, int deads, int skulls, int damage, int killSeriesMax)
		{
			this.kills = kills;
			this.deads = deads;
			this.skulls = skulls;
			this.damage = damage;
			this.killSeriesMax = killSeriesMax;
		}

		public BattleStatMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			kills = Get<int>(source, "kills", false);
			deads = Get<int>(source, "deads", false);
			skulls = Get<int>(source, "skulls", false);
			damage = Get<int>(source, "damage", false);
			killSeriesMax = Get<int>(source, "kill_series_max", false);
			exp = Get<int>(source, "exp", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("BattleStatMessage: kills: {0}; deads: {1}; skulls: {2}; damage: {3}; killSeriesMax: {4}; exp: {5};", kills, deads, skulls, damage, killSeriesMax, exp);
		}
	}
}
