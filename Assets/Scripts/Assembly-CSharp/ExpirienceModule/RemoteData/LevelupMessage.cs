using Interlace.Amf;
using RemoteData;

namespace ExpirienceModule.RemoteData
{
	public class LevelupMessage : PurchaseMessage
	{
		public LevelUpdateMessage expLevelUpdate;

		public LevelupMessage(LevelUpdateMessage expLevelUpdate)
		{
			this.expLevelUpdate = expLevelUpdate;
		}

		public LevelupMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			expLevelUpdate = GetMessage<LevelUpdateMessage>(source, "exp_level_update");
			base.Deserialize(source, true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("LevelupMessage: expLevelUpdate: {0};", expLevelUpdate) + base.ToString();
		}
	}
}
