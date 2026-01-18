using Interlace.Amf;

namespace RemoteData.Socket
{
	public class SlotUpdateMessage : RemoteMessage
	{
		public string slotId;

		public int artikulId;

		public int count;

		public int wear;

		public SlotUpdateMessage(string slotId, int artikulId, int count, int wear)
		{
			this.slotId = slotId;
			this.artikulId = artikulId;
			this.count = count;
			this.wear = wear;
		}

		public SlotUpdateMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			slotId = Get<string>(source, "slot_id", false);
			artikulId = Get<int>(source, "artikul_id", false);
			count = Get<int>(source, "cnt", false);
			wear = Get<int>(source, "wear", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("SlotUpdateMessage: slotId: {0}; artikulId: {1}; count: {2}; wear: {3};", slotId, artikulId, count, wear);
		}
	}
}
