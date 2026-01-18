using Interlace.Amf;

namespace RemoteData.Socket
{
	public class HideVoxelSelectResponse : PurchaseMessage
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
			return string.Format("HideVoxelSelectResponse:") + base.ToString();
		}
	}
}
