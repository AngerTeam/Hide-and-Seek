using Interlace.Amf;

namespace RemoteData.Lua
{
	public class AdViewResponse : PurchaseMessage
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
			return string.Format("AdViewResponse:") + base.ToString();
		}
	}
}
