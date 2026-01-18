using System.Collections.Generic;
using CraftyEngine.Utils;

namespace NotificationsModule
{
	public class NotificationsDataSaver : PermanentSingleton
	{
		private NotificationsSaveData notificationsSaveData_;

		private string saveFileName = "NotificationsData";

		public List<NotificationSaveItem> Notifications { get; private set; }

		public int GameStartsCount
		{
			get
			{
				return notificationsSaveData_.gameStartsCount;
			}
		}

		public override void Init()
		{
			Load();
			notificationsSaveData_.gameStartsCount++;
			Save();
		}

		public void Add(int notificationId, int groupId)
		{
			NotificationSaveItem item = new NotificationSaveItem(notificationId, groupId);
			Notifications.Add(item);
		}

		public void RemoveGroup(int groupId)
		{
			Notifications.RemoveAll((NotificationSaveItem x) => x.groupId == groupId);
		}

		public void Save()
		{
			notificationsSaveData_.notifications = Notifications.ToArray();
			DataSaver.Save(notificationsSaveData_, saveFileName);
		}

		private void Load()
		{
			Notifications = new List<NotificationSaveItem>();
			notificationsSaveData_ = DataSaver.Load<NotificationsSaveData>(saveFileName);
			if (notificationsSaveData_ == null)
			{
				notificationsSaveData_ = new NotificationsSaveData();
				return;
			}
			NotificationSaveItem[] notifications = notificationsSaveData_.notifications;
			foreach (NotificationSaveItem item in notifications)
			{
				Notifications.Add(item);
			}
		}
	}
}
