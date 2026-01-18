using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PlayerSeekMessage : SeekBasicMessage
	{
		public string actor;

		public double healthUtime;

		public PlayerSeekMessage(string actor, double healthUtime)
		{
			this.actor = actor;
			this.healthUtime = healthUtime;
		}

		public PlayerSeekMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			actor = Get<string>(source, "actor", false);
			healthUtime = Get<double>(source, "health_utime", false);
			base.Deserialize(source, true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerSeekMessage: actor: {0}; healthUtime: {1};", actor, healthUtime) + base.ToString();
		}
	}
}
