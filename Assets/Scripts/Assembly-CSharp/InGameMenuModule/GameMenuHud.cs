using System;
using Extensions;
using HudSystem;

namespace InGameMenuModule
{
	public class GameMenuHud : HeadUpDisplay
	{
		public event Action ButtonClicked;

		public GameMenuHud()
		{
			prefabsManager.Load("InGameMenu");
			UIButton uIButton = prefabsManager.InstantiateNGUIIn<UIButton>("UIMenuButton", nguiManager.UiRoot.TopRightContainer.gameObject);
			hudStateSwitcher.Register(8192, uIButton);
			ButtonSet.Up(uIButton, HandleMenuClick, ButtonSetGroup.Hud);
		}

		private void HandleMenuClick()
		{
			this.ButtonClicked.SafeInvoke();
		}

		public override void Dispose()
		{
		}
	}
}
