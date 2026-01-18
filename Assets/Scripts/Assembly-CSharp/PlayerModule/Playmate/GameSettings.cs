using CraftyEngine;

namespace PlayerModule.Playmate
{
	public class GameSettings : AdjustableSettings
	{
		protected PersistanceUserSettings userSettings;

		public GameSettings()
			: base(4)
		{
		}

		public override void Build()
		{
			PersistanceManager.Get<PersistanceUserSettings>(out userSettings);
			Update();
			Add("UI_InGameMenu_ShowNickName", userSettings.showEnemyNickname, Toggle);
		}

		private void Toggle(bool value)
		{
			userSettings.showEnemyNickname = value;
			PersistanceManager.Save(userSettings);
			Update();
		}

		private void Update()
		{
			GameModel gameModel = SingletonManager.Get<GameModel>();
			gameModel.showEnemyNickname = userSettings.showEnemyNickname;
		}
	}
}
