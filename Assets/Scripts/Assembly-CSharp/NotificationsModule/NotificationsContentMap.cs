using System.Collections.Generic;
using CraftyEngine.Content;

namespace NotificationsModule
{
	public class NotificationsContentMap : ContentMapBase
	{
		public static Dictionary<int, ClientPushNotificationsEntries> ClientPushNotifications;

		public override void Deserialize()
		{
			NotificationsContentKeys.Deserialize();
			ClientPushNotifications = ReadInt<ClientPushNotificationsEntries>(NotificationsContentKeys.client_push_notifications);
			base.Deserialize();
		}
	}
}
