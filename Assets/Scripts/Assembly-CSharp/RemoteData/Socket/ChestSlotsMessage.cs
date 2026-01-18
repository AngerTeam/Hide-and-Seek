using Interlace.Amf;

namespace RemoteData.Socket
{
	public class ChestSlotsMessage : RemoteMessage
	{
		public int slotId;

		public double ctime;

		public double startTime;

		public int artikulId;

		public ChestSlotsMessage(int slotId, double ctime, double startTime, int artikulId)
		{
			this.slotId = slotId;
			this.ctime = ctime;
			this.startTime = startTime;
			this.artikulId = artikulId;
		}

		public ChestSlotsMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			slotId = Get<int>(source, "slot_id", false);
			ctime = Get<double>(source, "ctime", false);
			startTime = Get<double>(source, "start_time", false);
			artikulId = Get<int>(source, "artikul_id", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("ChestSlotsMessage: slotId: {0}; ctime: {1}; startTime: {2}; artikulId: {3};", slotId, ctime, startTime, artikulId);
		}
	}
}
