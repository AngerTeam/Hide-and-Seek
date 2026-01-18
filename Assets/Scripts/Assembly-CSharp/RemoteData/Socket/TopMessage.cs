using Interlace.Amf;

namespace RemoteData.Socket
{
	public class TopMessage : RemoteMessage
	{
		public int pos;

		public int side;

		public string persId;

		public int exp;

		public int skulls;

		public int series;

		public int kills;

		public int points;

		public TopMessage(int pos, int side, string persId, int exp, int skulls, int series, int kills, int points)
		{
			this.pos = pos;
			this.side = side;
			this.persId = persId;
			this.exp = exp;
			this.skulls = skulls;
			this.series = series;
			this.kills = kills;
			this.points = points;
		}

		public TopMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			pos = Get<int>(source, "pos", false);
			side = Get<int>(source, "side", false);
			persId = Get<string>(source, "pers_id", false);
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
			return string.Format("TopMessage: pos: {0}; side: {1}; persId: {2}; exp: {3}; skulls: {4}; series: {5}; kills: {6}; points: {7};", pos, side, persId, exp, skulls, series, kills, points);
		}
	}
}
