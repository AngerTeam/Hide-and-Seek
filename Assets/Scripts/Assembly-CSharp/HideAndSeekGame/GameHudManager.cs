using HudSystem;
using MyPlayerInput;
using WindowsModule;

namespace HideAndSeekGame
{
	public class GameHudManager : Singleton
	{
		private GameModel gameModel_;

		private WindowsManager windowsManager_;

		private HudStateSwitcher hudStateSwitcher_;

		private MouseCursorManager mouseCursorManager_;

		private MyPlayerInputModel inputModel_;

		public override void Init()
		{
			SingletonManager.Get<MouseCursorManager>(out mouseCursorManager_);
			SingletonManager.Get<GameModel>(out gameModel_);
			SingletonManager.Get<WindowsManager>(out windowsManager_);
			SingletonManager.Get<HudStateSwitcher>(out hudStateSwitcher_);
			SingletonManager.Get<MyPlayerInputModel>(out inputModel_);
			inputModel_.EnabledByUi = true;
			gameModel_.CurrentGameHudStateChanged += HandleHudStateChanged;
			windowsManager_.AnyWindowToggled += HandleAnyWindowToggled;
		}

		private void HandleAnyWindowToggled()
		{
			bool flag = !windowsManager_.AnyWindowIsOpen;
			inputModel_.EnabledByUi = flag;
			mouseCursorManager_.visibleByOpenedWindow = !flag;
			Update();
		}

		private void Update()
		{
			hudStateSwitcher_.SwitchHighest((!windowsManager_.AnyWindowIsOpen) ? (-1) : windowsManager_.FrontWindow.HudState);
			hudStateSwitcher_.SwitchLow(gameModel_.CurrentGameHudState);
		}

		private void HandleHudStateChanged()
		{
			Update();
		}
	}
}
