using Interlace.Amf;

namespace RemoteData.Socket
{
	public class TeamDataMessage : RemoteMessage
	{
		public int side;

		public int kills;

		public int leave;

		public TeamDataMessage(int side, int kills, int leave)
		{
			this.side = side;
			this.kills = kills;
			this.leave = leave;
		}

		public TeamDataMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			side = Get<int>(source, "side", false);
			kills = Get<int>(source, "kills", false);
			leave = Get<int>(source, "leave", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("TeamDataMessage: side: {0}; kills: {1}; leave: {2};", side, kills, leave);
		}
	}
}
