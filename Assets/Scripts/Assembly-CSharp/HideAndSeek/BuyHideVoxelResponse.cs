using Interlace.Amf;
using RemoteData;

namespace HideAndSeek
{
	public class BuyHideVoxelResponse : PurchaseMessage
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
			return string.Format("BuyHideVoxelResponse:") + base.ToString();
		}
	}
}
