using NotificationsModule;

namespace GameInfrastructure
{
	public class NotificationsModuleController
	{
		public static void InitModule()
		{
			int layer = 1;
			SingletonManager.AddAlias<NotificationsManager, INotifications>(layer);
			SingletonManager.Add<NotificationsDataSaver>(layer);
		}
	}
}
