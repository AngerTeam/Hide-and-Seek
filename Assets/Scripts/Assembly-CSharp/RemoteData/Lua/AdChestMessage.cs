using Interlace.Amf;

namespace RemoteData.Lua
{
	public class AdChestMessage : RemoteMessage
	{
		public int slotId;

		public double viewTime;

		public int total;

		public AdChestMessage(int slotId, double viewTime, int total)
		{
			this.slotId = slotId;
			this.viewTime = viewTime;
			this.total = total;
		}

		public AdChestMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			slotId = Get<int>(source, "slot_id", false);
			viewTime = Get<double>(source, "view_time", false);
			total = Get<int>(source, "total", false);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("AdChestMessage: slotId: {0}; viewTime: {1}; total: {2};", slotId, viewTime, total);
		}
	}
}
