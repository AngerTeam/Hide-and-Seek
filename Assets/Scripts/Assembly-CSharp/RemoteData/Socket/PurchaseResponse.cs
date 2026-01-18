using Interlace.Amf;

namespace RemoteData.Socket
{
	public class PurchaseResponse : PurchaseMessage
	{
		public override void Deserialize(AmfObject source, bool silent)
		{
			base.Deserialize(source, true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PurchaseResponse:") + base.ToString();
		}
	}
}
