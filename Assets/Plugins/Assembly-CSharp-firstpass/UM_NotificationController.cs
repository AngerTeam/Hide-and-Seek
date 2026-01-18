using System;
using SA.Common.Pattern;
using UnityEngine;

public class UM_NotificationController : Singleton<UM_NotificationController>
{
	private bool IsPushListnersRegistred;

	public static event Action<UM_PushRegistrationResult> OnPushIdLoadResult;

	static UM_NotificationController()
	{
		UM_NotificationController.OnPushIdLoadResult = delegate
		{
		};
	}

	private void Awake()
	{
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
	}

	public void RetrieveDevicePushId()
	{
		switch (Application.platform)
		{
		case RuntimePlatform.Android:
			if (!IsPushListnersRegistred)
			{
				GoogleCloudMessageService.ActionCMDRegistrationResult += HandleActionCMDRegistrationResult;
			}
			Singleton<GoogleCloudMessageService>.Instance.RgisterDevice();
			break;
		}
		IsPushListnersRegistred = true;
	}

	public void ShowNotificationPoup(string title, string messgae)
	{
		switch (Application.platform)
		{
		case RuntimePlatform.Android:
			Singleton<AndroidNotificationManager>.Instance.ShowToastNotification(messgae);
			break;
		case RuntimePlatform.IPhonePlayer:
			Singleton<ISN_LocalNotificationsController>.Instance.ShowGmaeKitNotification(title, messgae);
			break;
		case RuntimePlatform.PS3:
		case RuntimePlatform.XBOX360:
			break;
		}
	}

	public int ScheduleLocalNotification(string title, string message, int seconds)
	{
		switch (Application.platform)
		{
		case RuntimePlatform.Android:
			return Singleton<AndroidNotificationManager>.Instance.ScheduleLocalNotification(title, message, seconds);
		case RuntimePlatform.IPhonePlayer:
		{
			ISN_LocalNotification iSN_LocalNotification = new ISN_LocalNotification(DateTime.Now.AddSeconds(seconds), message);
			iSN_LocalNotification.Schedule();
			return iSN_LocalNotification.Id;
		}
		default:
			return 0;
		}
	}

	public void CancelLocalNotification(int id)
	{
		switch (Application.platform)
		{
		case RuntimePlatform.Android:
			Singleton<AndroidNotificationManager>.Instance.CancelLocalNotification(id);
			break;
		case RuntimePlatform.IPhonePlayer:
			Singleton<ISN_LocalNotificationsController>.Instance.CancelLocalNotificationById(id);
			break;
		case RuntimePlatform.PS3:
		case RuntimePlatform.XBOX360:
			break;
		}
	}

	public void CancelAllLocalNotifications()
	{
		switch (Application.platform)
		{
		case RuntimePlatform.Android:
			Singleton<AndroidNotificationManager>.Instance.CancelAllLocalNotifications();
			break;
		case RuntimePlatform.IPhonePlayer:
			Singleton<ISN_LocalNotificationsController>.Instance.CancelAllLocalNotifications();
			break;
		case RuntimePlatform.PS3:
		case RuntimePlatform.XBOX360:
			break;
		}
	}

	private void HandleActionCMDRegistrationResult(GP_GCM_RegistrationResult res)
	{
		if (res.IsSucceeded)
		{
			OnRegstred();
		}
		else
		{
			OnRegFailed();
		}
	}

	private void OnRegFailed()
	{
		UM_PushRegistrationResult obj = new UM_PushRegistrationResult(string.Empty, false);
		UM_NotificationController.OnPushIdLoadResult(obj);
	}

	private void OnRegstred()
	{
		UM_PushRegistrationResult obj = new UM_PushRegistrationResult(Singleton<GoogleCloudMessageService>.Instance.registrationId, true);
		UM_NotificationController.OnPushIdLoadResult(obj);
	}

	private void IOSPushTokenReceived(ISN_RemoteNotificationsRegistrationResult res)
	{
		UM_PushRegistrationResult obj = new UM_PushRegistrationResult(res.Token.DeviceId, true);
		UM_NotificationController.OnPushIdLoadResult(obj);
	}
}
