using CraftyEngine.Infrastructure;
using HudSystem;
using WindowsModule;

namespace MiniGameCraft.Gui
{
	public class SupportIdWindow : GameWindow
	{
		private SupportIdManager supportIdManager_;

		private SupportIdWindowHierarchy windowHierarchy_;

		public SupportIdWindow()
		{
			SingletonManager.Get<SupportIdManager>(out supportIdManager_);
			windowHierarchy_ = prefabsManager.InstantiateNGUIIn<SupportIdWindowHierarchy>("UISupportIdWindow", nguiManager.UiRoot.gameObject);
			windowHierarchy_.title.text = Localisations.Get("UI_InGameMenu_SupportId");
			windowHierarchy_.copyButtonLabel.text = Localisations.Get("UI_Copy");
			ButtonSet.Up(windowHierarchy_.copyButton, CopyToClipboard, ButtonSetGroup.InWindow);
			SetContent(windowHierarchy_.transform);
			base.ViewChanged += HandleViewChanged;
		}

		private void HandleViewChanged(object sender, BoolEventArguments e)
		{
			if (Visible)
			{
				windowHierarchy_.supportIdLabel.text = supportIdManager_.SupportId;
			}
		}

		private void CopyToClipboard()
		{
			UniClipboard.SetText(supportIdManager_.SupportId);
			MessageBroadcaster.ReportInfo(Localisations.Get("UI_CopiedToClipboard"), 0f);
		}

		public override void Clear()
		{
			base.ViewChanged -= HandleViewChanged;
		}
	}
}
