using Interlace.Amf;

namespace RemoteData.Lua
{
	public class PurchaseResponse : PurchaseMessage
	{
		public string orderId;

		public PurchaseResponse(string orderId)
		{
			this.orderId = orderId;
		}

		public PurchaseResponse()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			orderId = Get<string>(source, "order_id", false);
			base.Deserialize(source, true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PurchaseResponse: orderId: {0};", orderId) + base.ToString();
		}
	}
}
