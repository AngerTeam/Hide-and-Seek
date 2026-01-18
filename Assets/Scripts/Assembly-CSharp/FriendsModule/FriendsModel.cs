using FriendsModule.RemoteData;

namespace FriendsModule
{
	public class FriendsModel : Singleton
	{
		public OtherPlayerMessage otherPlayer;

		public FriendMessage[] friends;

		public FriendRequestMessage[] input;

		public FriendRequestMessage[] output;

		public FindPlayerMessage[] players;

		public string lastFriendName;

		public void Clear()
		{
			otherPlayer = null;
			friends = null;
			input = null;
			output = null;
			players = null;
			lastFriendName = string.Empty;
		}
	}
}
