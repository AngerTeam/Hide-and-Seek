using Interlace.Amf;

namespace RemoteData.Socket
{
	public class MemberMessage : RemoteMessage
	{
		public string persId;

		public int side;

		public int exp;

		public int skulls;

		public int series;

		public int kills;

		public int points;

		public MemberMessage(string persId, int side, int exp, int skulls, int series, int kills, int points)
		{
			this.persId = persId;
			this.side = side;
			this.exp = exp;
			this.skulls = skulls;
			this.series = series;
			this.kills = kills;
			this.points = points;
		}

		public MemberMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			persId = Get<string>(source, "pers_id", false);
			side = Get<int>(source, "side", false);
			exp = Get<int>(source, "exp", false);
			skulls = Get<int>(source, "skulls", false);
			series = Get<int>(source, "series", false);
			kills = Get<int>(source, "kills", false);
			points = Get<int>(source, "points", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("MemberMessage: persId: {0}; side: {1}; exp: {2}; skulls: {3}; series: {4}; kills: {5}; points: {6};", persId, side, exp, skulls, series, kills, points);
		}
	}
}
