using MyPlayerInput;

namespace CraftyEngine.Infrastructure
{
	public class InputSettings : AdjustableSettings
	{
		protected PersistanceUserSettings userSettings;

		private InputManager inputManager_;

		private float max_ = 100f;

		private float min_ = 1f;

		public InputSettings()
			: base(3)
		{
		}

		public override void Build()
		{
			PersistanceManager.Get<PersistanceUserSettings>(out userSettings);
			if (!userSettings.defaultInputValuesVetsion1Set)
			{
				userSettings.defaultInputValuesVetsion1Set = true;
				userSettings.touchSensitivity = MyPlayerInputContentMap.PlayerSettings.touchSensitivity;
				PersistanceManager.Save(userSettings);
			}
			Add("UI_InGameMenu_Controls");
			Add("UI_InGameMenu_Touch_Sensitivity", userSettings.touchSensitivity, min_, max_, HandleTouch);
			if (MyPlayerInputContentMap.PlayerSettings.allowAutoAiming > 0 || DataStorage.isAdmin)
			{
				Add("UI_InGameMenu_Autoaiming", userSettings.autoAiming, delegate(bool value)
				{
					userSettings.autoAiming = value;
					PersistanceManager.Save(userSettings);
				});
				Add("UI_InGameMenu_Autoshoot", userSettings.autoShoot, delegate(bool value)
				{
					userSettings.autoShoot = value;
					PersistanceManager.Save(userSettings);
				});
			}
			if (MyPlayerInputContentMap.PlayerSettings.allowAlignTpsCamera > 0 || DataStorage.isAdmin)
			{
				Add("UI_InGameMenu_AlignTpsCamera", userSettings.autoAlignTpsCamera, delegate(bool value)
				{
					userSettings.autoAlignTpsCamera = value;
					PersistanceManager.Save(userSettings);
				});
			}
			Apply();
		}

		private void HandleTouch(float value)
		{
			userSettings.touchSensitivity = value;
			PersistanceManager.Save(userSettings);
			Apply();
		}

		private void Apply()
		{
			float touchSensitivity = ToRange(1f - userSettings.touchSensitivity / max_, 0.05f, 0.4f);
			SingletonManager.Get<InputManager>(out inputManager_);
			if (inputManager_.MobileInput != null)
			{
				inputManager_.MobileInput.touchSensitivity = touchSensitivity;
			}
		}

		private float ToRange(float value, float min, float max)
		{
			return (max - min) * value + min;
		}
	}
}
