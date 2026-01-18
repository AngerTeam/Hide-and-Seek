using Interlace.Amf;
using RemoteData;

namespace FriendsModule.RemoteData
{
	public class FriendRequestCancelResponse : RemoteMessage
	{
		public override void Deserialize(AmfObject source, bool silent)
		{
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("FriendRequestCancelResponse:");
		}
	}
}
