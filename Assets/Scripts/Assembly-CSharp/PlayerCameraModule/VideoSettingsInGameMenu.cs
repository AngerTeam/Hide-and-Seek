using CraftyEngine;
using UnityEngine;

namespace PlayerCameraModule
{
	public class VideoSettingsInGameMenu : AdjustableSettings
	{
		private PlayerCameraManager cameraManager_;

		private PersistanceUserSettings userSettings_;

		public VideoSettingsInGameMenu()
			: base(2)
		{
		}

		public override void Build()
		{
			PersistanceManager.Get<PersistanceUserSettings>(out userSettings_);
			SingletonManager.Get<PlayerCameraManager>(out cameraManager_);
			cameraManager_.SetFov(userSettings_.fieldOfView);
			Add("UI_InGameMenu_Video");
			if (!CompileConstants.MOBILE || CompileConstants.EDITOR)
			{
				Add("UI_InGameMenu_FullScreen", ToggleFullscreen);
			}
			Add("FOV:", userSettings_.fieldOfView, 60f, 80f, HandleFov);
		}

		protected string GetOnOff(bool value)
		{
			string key = ((!value) ? "UI_InGameMenu_Off" : "UI_InGameMenu_On");
			return Localisations.Get(key);
		}

		private void HandleFov(float value)
		{
			userSettings_.fieldOfView = (int)value;
			SingletonManager.Get<PlayerCameraManager>(out cameraManager_);
			cameraManager_.SetFov(userSettings_.fieldOfView);
			PersistanceManager.Save(userSettings_);
		}

		private void ToggleFullscreen()
		{
			if (Screen.fullScreen)
			{
				Screen.fullScreen = false;
				return;
			}
			Vector2 zero = Vector2.zero;
			Resolution[] resolutions = Screen.resolutions;
			for (int i = 0; i < resolutions.Length; i++)
			{
				Resolution resolution = resolutions[i];
				if ((float)resolution.width > zero.x)
				{
					zero.x = resolution.width;
				}
				if ((float)resolution.height > zero.y)
				{
					zero.y = resolution.height;
				}
			}
			Screen.SetResolution((int)zero.x, (int)zero.y, true);
		}
	}
}
