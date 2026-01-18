using System;
using System.Collections.Generic;
using CraftyEngine.Content;
using CraftyEngine.Utils;
using SA.Common.Pattern;
using UnityEngine;

namespace NotificationsModule
{
	public class NotificationsManager : Singleton, INotifications, ISingleton
	{
		private class PushGroupId
		{
			public const int InitialComeBack = 1;

			public const int SecondaryComeBack = 2;

			public const int ChestOpened = 3;

			public const int ChestGotIdle = 4;

			public const int AssassinsChest = 5;

			public const int SpecialOffer = 6;

			public const int InstaReturn = 7;

			public const int LuckyChest = 8;
		}

		private NotificationsDataSaver notificationsDataSaver_;

		private UnityTimer instaReturnTimer_;

		private int instaReturnInterval_ = 30;

		private List<NotificationSaveItem> saveData
		{
			get
			{
				return notificationsDataSaver_.Notifications;
			}
		}

		public override void Init()
		{
			SingletonManager.Get<NotificationsDataSaver>(out notificationsDataSaver_);
			if (CompileConstants.IOS)
			{
				Singleton<ISN_LocalNotificationsController>.Instance.RequestNotificationPermissions();
			}
		}

		public override void OnLogicLoaded()
		{
			ContentDeserializer.Deserialize<NotificationsContentMap>();
			CancelGroupNotification(1);
			CancelGroupNotification(2);
			if (notificationsDataSaver_.GameStartsCount == 1)
			{
				ScheduleGroupNotification(1);
				StartInstaReturnScheduling();
			}
			else
			{
				ScheduleGroupNotification(2);
			}
			if (CompileConstants.IOS)
			{
				IOSNativeUtility.SetApplicationBagesNumber(0);
			}
		}

		private void StartInstaReturnScheduling()
		{
			UnityTimerManager unityTimerManager = SingletonManager.Get<UnityTimerManager>();
			instaReturnTimer_ = unityTimerManager.SetTimer(instaReturnInterval_);
			instaReturnTimer_.repeat = true;
			instaReturnTimer_.Completeted += OnInstaReturnTimerCompleted;
			OnInstaReturnTimerCompleted();
		}

		private void OnInstaReturnTimerCompleted()
		{
			ScheduleGroupNotification(7, instaReturnInterval_);
		}

		public void SetChestOpenNotification(int secondsLeft)
		{
			CancelGroupNotification(4);
			ScheduleGroupNotification(3, secondsLeft);
		}

		public void CancelChestOpenNotification()
		{
			CancelGroupNotification(3);
			notificationsDataSaver_.Save();
		}

		public void SetChestGotIdleNotification()
		{
			foreach (NotificationSaveItem saveDatum in saveData)
			{
				if (saveDatum.groupId == 3)
				{
					return;
				}
			}
			ScheduleGroupNotification(4);
		}

		public void SetAssassinsChestNotification()
		{
			ScheduleGroupNotification(5);
		}

		public void CancelAssassinsChestNotification()
		{
			CancelGroupNotification(5);
			notificationsDataSaver_.Save();
		}

		public void SetLuckyChestNotification(int secondsLeft)
		{
			ScheduleGroupNotification(8, secondsLeft);
		}

		public void SetSpecialOfferNotification(int secondsLeft)
		{
			ScheduleGroupNotification(6, secondsLeft, true);
		}

		public void CancelSpecialOfferNotification()
		{
			CancelGroupNotification(6);
			notificationsDataSaver_.Save();
		}

		private void ScheduleGroupNotification(int groupId, int timeOffset = 0, bool reverseTimer = false)
		{
			CancelGroupNotification(groupId);
			if (NotificationsContentMap.ClientPushNotifications != null)
			{
				foreach (ClientPushNotificationsEntries value in NotificationsContentMap.ClientPushNotifications.Values)
				{
					if (value.group_id == groupId)
					{
						int notificationId = ScheduleLocalNotification(value.push_text, timeOffset + value.timer * ((!reverseTimer) ? 1 : (-1)));
						notificationsDataSaver_.Add(notificationId, value.group_id);
					}
				}
			}
			notificationsDataSaver_.Save();
		}

		private void CancelGroupNotification(int groupId)
		{
			foreach (NotificationSaveItem saveDatum in saveData)
			{
				if (saveDatum.groupId == groupId && saveDatum.notificationId != 0)
				{
					Singleton<UM_NotificationController>.Instance.CancelLocalNotification(saveDatum.notificationId);
				}
			}
			notificationsDataSaver_.RemoveGroup(groupId);
		}

		private int ScheduleLocalNotification(string message, int seconds)
		{
			bool flag = CheckIfSilentHours(seconds);
			if (CompileConstants.ANDROID)
			{
				AndroidNotificationBuilder builder = new AndroidNotificationBuilder(Singleton<AndroidNotificationManager>.Instance.GetNextId, Application.productName, message, seconds);
				return Singleton<AndroidNotificationManager>.Instance.ScheduleLocalNotification(builder);
			}
			if (CompileConstants.IOS)
			{
				ISN_LocalNotification iSN_LocalNotification = new ISN_LocalNotification(DateTime.Now.AddSeconds(seconds), message, !flag);
				if (!flag)
				{
					iSN_LocalNotification.SetSoundName("local_push.wav");
				}
				iSN_LocalNotification.SetBadgesNumber(1);
				iSN_LocalNotification.Schedule();
				return iSN_LocalNotification.Id;
			}
			return 0;
		}

		private bool CheckIfSilentHours(int seconds)
		{
			DateTime dateTime = DateTime.Now.AddSeconds(seconds);
			TimeSpan timeSpan = new TimeSpan(10, 0, 0);
			TimeSpan timeSpan2 = new TimeSpan(22, 0, 0);
			TimeSpan timeOfDay = dateTime.TimeOfDay;
			return !(timeOfDay > timeSpan) || !(timeOfDay < timeSpan2);
		}
	}
}
