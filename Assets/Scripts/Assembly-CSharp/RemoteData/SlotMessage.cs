using Interlace.Amf;

namespace RemoteData
{
	public class SlotMessage : RemoteMessage
	{
		public string slotId;

		public int artikulId;

		public int count;

		public int wear;

		public int tmp;

		public SlotMessage(string slotId, int artikulId, int count, int wear)
		{
			this.slotId = slotId;
			this.artikulId = artikulId;
			this.count = count;
			this.wear = wear;
		}

		public SlotMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			slotId = Get<string>(source, "slot_id", false);
			artikulId = Get<int>(source, "artikul_id", false);
			count = Get<int>(source, "cnt", false);
			wear = Get<int>(source, "wear", false);
			tmp = Get<int>(source, "tmp", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("SlotMessage: slotId: {0}; artikulId: {1}; count: {2}; wear: {3}; tmp: {4};", slotId, artikulId, count, wear, tmp);
		}
	}
}
