namespace NotificationsModule
{
	public interface INotifications : ISingleton
	{
		void SetChestGotIdleNotification();

		void CancelAssassinsChestNotification();

		void SetChestOpenNotification(int secondsLeft);

		void CancelChestOpenNotification();

		void SetAssassinsChestNotification();

		void SetLuckyChestNotification(int secondsLeft);
	}
}
