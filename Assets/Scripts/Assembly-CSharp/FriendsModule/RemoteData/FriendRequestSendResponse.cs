using Interlace.Amf;
using RemoteData;

namespace FriendsModule.RemoteData
{
	public class FriendRequestSendResponse : RemoteMessage
	{
		public int friendAdded;

		public override void Deserialize(AmfObject source, bool silent)
		{
			friendAdded = Get<int>(source, "friend_added", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("FriendRequestSendResponse: friendAdded: {0};", friendAdded);
		}
	}
}
