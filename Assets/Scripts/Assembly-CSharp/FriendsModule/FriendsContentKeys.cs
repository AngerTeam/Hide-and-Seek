namespace FriendsModule
{
	public class FriendsContentKeys
	{
		public static string friendsLimit;

		public static string friendsRequestTTL;

		public static string friendsRequestLimit;

		public static string friendsRequestLimitPeriod;

		public static string friendsUpdateTimeout;

		public static string friendsOnlineUpdateTimeout;

		public static string fiends_settings;

		public static void Deserialize()
		{
			friendsLimit = "friendsLimit";
			friendsRequestTTL = "friendsRequestTTL";
			friendsRequestLimit = "friendsRequestLimit";
			friendsRequestLimitPeriod = "friendsRequestLimitPeriod";
			friendsUpdateTimeout = "friendsUpdateTimeout";
			friendsOnlineUpdateTimeout = "friendsOnlineUpdateTimeout";
			fiends_settings = "fiends_settings";
		}
	}
}
