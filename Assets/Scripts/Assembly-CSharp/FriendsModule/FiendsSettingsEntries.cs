using CraftyEngine.Content;

namespace FriendsModule
{
	public class FiendsSettingsEntries : ContentItem
	{
		public int friendsLimit = 50;

		public int friendsRequestTTL = 86400;

		public int friendsRequestLimit = 50;

		public int friendsRequestLimitPeriod = 10;

		public int friendsUpdateTimeout = 60;

		public int friendsOnlineUpdateTimeout = 60;

		public override void Deserialize()
		{
			friendsLimit = TryGetInt(FriendsContentKeys.friendsLimit, 50);
			friendsRequestTTL = TryGetInt(FriendsContentKeys.friendsRequestTTL, 86400);
			friendsRequestLimit = TryGetInt(FriendsContentKeys.friendsRequestLimit, 50);
			friendsRequestLimitPeriod = TryGetInt(FriendsContentKeys.friendsRequestLimitPeriod, 10);
			friendsUpdateTimeout = TryGetInt(FriendsContentKeys.friendsUpdateTimeout, 60);
			friendsOnlineUpdateTimeout = TryGetInt(FriendsContentKeys.friendsOnlineUpdateTimeout, 60);
			base.Deserialize();
		}
	}
}
