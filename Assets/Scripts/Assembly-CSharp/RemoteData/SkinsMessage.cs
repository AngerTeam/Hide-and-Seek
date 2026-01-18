using Interlace.Amf;

namespace RemoteData
{
	public class SkinsMessage : RemoteMessage
	{
		public int skinId;

		public double ctime;

		public SkinsMessage(int skinId, double ctime)
		{
			this.skinId = skinId;
			this.ctime = ctime;
		}

		public SkinsMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			skinId = Get<int>(source, "skin_id", false);
			ctime = Get<double>(source, "ctime", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("SkinsMessage: skinId: {0}; ctime: {1};", skinId, ctime);
		}
	}
}
