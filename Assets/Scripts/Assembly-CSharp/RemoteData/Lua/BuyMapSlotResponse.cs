using Interlace.Amf;

namespace RemoteData.Lua
{
	public class BuyMapSlotResponse : PurchaseMessage
	{
		public int slotId;

		public BuyMapSlotResponse(int slotId)
		{
			this.slotId = slotId;
		}

		public BuyMapSlotResponse()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			slotId = Get<int>(source, "slot_id", false);
			base.Deserialize(source, true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("BuyMapSlotResponse: slotId: {0};", slotId) + base.ToString();
		}
	}
}
