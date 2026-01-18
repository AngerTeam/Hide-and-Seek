using System;

namespace InGameMenuModule
{
	public interface IRestoreInGameMenu : ISingleton
	{
		event Action RestoreButtonClicked;

		void EnableRestoreButton(bool enable);

		void SetRestoreButtonText(string text);
	}
}
