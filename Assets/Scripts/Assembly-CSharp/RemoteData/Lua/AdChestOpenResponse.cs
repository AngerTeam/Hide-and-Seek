using Interlace.Amf;

namespace RemoteData.Lua
{
	public class AdChestOpenResponse : PurchaseMessage
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
			return string.Format("AdChestOpenResponse:") + base.ToString();
		}
	}
}
