using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PlayerSyncExperienceMessage : RemoteMessage
	{
		public int level;

		public string persId;

		public int expAcc;

		public int exp;

		public PlayerSyncExperienceMessage(int level, string persId, int expAcc, int exp)
		{
			this.level = level;
			this.persId = persId;
			this.expAcc = expAcc;
			this.exp = exp;
		}

		public PlayerSyncExperienceMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			level = Get<int>(source, "level", false);
			persId = Get<string>(source, "pers_id", false);
			expAcc = Get<int>(source, "exp_acc", false);
			exp = Get<int>(source, "exp", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerSyncExperienceMessage: level: {0}; persId: {1}; expAcc: {2}; exp: {3};", level, persId, expAcc, exp);
		}
	}
}
