using CraftyEngine.Utils;
using Interlace.Amf;
using RemoteData;

namespace FriendsModule.RemoteData
{
	public class FriendsResponse : RemoteMessage
	{
		public FriendMessage[] friends;

		public FriendRequestMessage[] requests;

		public FriendRequestMessage[] sendRequests;

		public FriendsResponse(FriendMessage[] friends, FriendRequestMessage[] requests, FriendRequestMessage[] sendRequests)
		{
			this.friends = friends;
			this.requests = requests;
			this.sendRequests = sendRequests;
		}

		public FriendsResponse()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			friends = GetArray<FriendMessage>(source, "friends");
			requests = GetArray<FriendRequestMessage>(source, "requests");
			sendRequests = GetArray<FriendRequestMessage>(source, "send_requests");
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("FriendsResponse:\n friends: {0}\n requests: {1}\n sendRequests: {2}", ArrayUtils.ArrayToString(friends, "\n\t"), ArrayUtils.ArrayToString(requests, "\n\t"), ArrayUtils.ArrayToString(sendRequests, "\n\t"));
		}
	}
}
