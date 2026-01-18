using Interlace.Amf;

namespace RemoteData.Lua
{
	public class AssassinChestOpenResponse : PurchaseMessage
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
			return string.Format("AssassinChestOpenResponse:") + base.ToString();
		}
	}
}
