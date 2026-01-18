using CraftyEngine;

namespace InGameMenuModule
{
	public class MainSettingsInGameMenu : AdjustableSettings
	{
		private InGameMenuManager inGameMenuManager_;

		public MainSettingsInGameMenu()
			: base(5)
		{
		}

		public override void Build()
		{
			SingletonManager.Get<InGameMenuManager>(out inGameMenuManager_);
			Add("UI_MainMenu_Settings");
			Add("UI_InGameMenu_Video", delegate
			{
				Toggle(2);
			});
			Add("UI_InGameMenu_Audio", delegate
			{
				Toggle(1);
			});
			Add("UI_InGameMenu_Controls", delegate
			{
				Toggle(3);
			});
			Add("UI_InGameMenu_GameSettings", delegate
			{
				Toggle(4);
			});
			string title = string.Format("v{0} ({1})", DataStorage.releaseVersion, DataStorage.version.Replace(".", string.Empty));
			Add(title);
		}

		private void Toggle(int settingsId)
		{
			inGameMenuManager_.Toggle(settingsId);
		}
	}
}
