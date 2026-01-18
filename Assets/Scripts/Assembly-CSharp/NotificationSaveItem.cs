using System;

[Serializable]
public class NotificationSaveItem
{
	public int notificationId;

	public int groupId;

	public NotificationSaveItem(int notificationId, int groupId)
	{
		this.notificationId = notificationId;
		this.groupId = groupId;
	}
}
