using System.Collections.Generic;
using CraftyEngine;
using WindowsModule;

namespace InGameMenuModule
{
	public class InGameMenuManager : Singleton
	{
		private WindowsManager windowsManager_;

		private Dictionary<int, GameWindow> windows_;

		public override void OnDataLoaded()
		{
			windows_ = new Dictionary<int, GameWindow>();
			AdjustableSettings.Register<MainSettingsInGameMenu>();
			SingletonManager.Get<WindowsManager>(out windowsManager_);
			foreach (AdjustableSettings value in AdjustableSettings.allSettings.Values)
			{
				Build(value);
			}
		}

		public override void Dispose()
		{
			AdjustableSettings.allSettings.Clear();
			if (windows_ == null)
			{
				return;
			}
			foreach (GameWindow value in windows_.Values)
			{
				if (value != null)
				{
					value.Dispose();
				}
			}
			windows_.Clear();
		}

		private void Build(AdjustableSettings settings)
		{
			MenuWindow menuWindow = new MenuWindow();
			windows_[settings.id] = menuWindow;
			settings.Build();
			for (int i = 0; i < settings.settings.Count; i++)
			{
				AdjustableSetting adjustableSetting = settings.settings[i];
				switch (adjustableSetting.type)
				{
				case AdjustableSettingType.Title:
					menuWindow.AddTitle(adjustableSetting.title);
					break;
				case AdjustableSettingType.Button:
					menuWindow.AddButton(adjustableSetting.title, adjustableSetting.buttonHandler);
					break;
				case AdjustableSettingType.Toggle:
					menuWindow.AddToggle(adjustableSetting.title, adjustableSetting.toggle, adjustableSetting.toggleHandler);
					break;
				case AdjustableSettingType.Slider:
					menuWindow.AddSlider(adjustableSetting.title, adjustableSetting.value, adjustableSetting.valueMin, adjustableSetting.valueMax, adjustableSetting.floatHandler);
					break;
				}
			}
			menuWindow.RefreshTitles();
			menuWindow.SetContentWithBackground();
		}

		public void Toggle(int id)
		{
			GameWindow value;
			if (windows_.TryGetValue(id, out value))
			{
				windowsManager_.ToggleWindow(value);
				return;
			}
			Log.Error("Unable to find settings window {0}", id);
		}

		public static void InitModule()
		{
			SingletonManager.Add<InGameMenuManager>(1);
		}
	}
}
