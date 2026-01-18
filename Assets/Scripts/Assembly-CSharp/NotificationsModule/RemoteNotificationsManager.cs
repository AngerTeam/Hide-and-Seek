using System.Collections.Generic;
using ANMiniJSON;
using Authorization;
using SA.Common.Pattern;

namespace NotificationsModule
{
	public class RemoteNotificationsManager : PermanentSingleton
	{
		private AuthorizationModel authorizationModel_;

		public override void Init()
		{
			SingletonManager.Get<AuthorizationModel>(out authorizationModel_);
			if (CompileConstants.IOS)
			{
				Singleton<ISN_RemoteNotificationsController>.Instance.RegisterForRemoteNotifications(delegate(ISN_RemoteNotificationsRegistrationResult result)
				{
					if (result.IsSucceeded)
					{
						Log.Info("RemoteNotifications DeviceId: " + result.Token.DeviceId);
						authorizationModel_.pushDeviceId = result.Token.DeviceId;
					}
					else
					{
						Log.Error("Failed RegisterForRemoteNotifications: " + result.Error.Code + " / " + result.Error.Message);
					}
				});
			}
			else if (CompileConstants.ANDROID)
			{
				GoogleCloudMessageService.ActionCMDRegistrationResult += HandleRegistrationIdRecieved;
				GoogleCloudMessageService.ActionGCMPushLaunched += HandleActionGCMPushLaunched;
				GoogleCloudMessageService.ActionGCMPushReceived += HandleActionGCMPushReceived;
				Singleton<GoogleCloudMessageService>.Instance.Init();
				Singleton<GoogleCloudMessageService>.Instance.RgisterDevice();
			}
		}

		private void HandleRegistrationIdRecieved(GP_GCM_RegistrationResult res)
		{
			if (res.IsSucceeded)
			{
				Log.Info("RemoteNotifications registrationId:" + Singleton<GoogleCloudMessageService>.Instance.registrationId);
				authorizationModel_.pushDeviceId = Singleton<GoogleCloudMessageService>.Instance.registrationId;
			}
			else
			{
				Log.Error("Failed RegisterForRemoteNotifications");
			}
		}

		private void HandleActionGCMPushReceived(string message, Dictionary<string, object> data)
		{
			AN_PoupsProxy.showMessage(message, Json.Serialize(data));
		}

		private void HandleActionGCMPushLaunched(string message, Dictionary<string, object> data)
		{
			AN_PoupsProxy.showMessage(message, Json.Serialize(data));
		}
	}
}
