using Interlace.Amf;
using RemoteData;

namespace ExpirienceModule.RemoteData
{
	public class LevelUpdateMessage : RemoteMessage
	{
		public int level;

		public int exp;

		public int expAcc;

		public LevelUpdateMessage(int level, int exp, int expAcc)
		{
			this.level = level;
			this.exp = exp;
			this.expAcc = expAcc;
		}

		public LevelUpdateMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			level = Get<int>(source, "level", false);
			exp = Get<int>(source, "exp", false);
			expAcc = Get<int>(source, "exp_acc", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("LevelUpdateMessage: level: {0}; exp: {1}; expAcc: {2};", level, exp, expAcc);
		}
	}
}
