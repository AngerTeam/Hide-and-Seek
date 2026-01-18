using HudSystem;
using NguiTools;
using WindowsModule;

namespace RestoreServiceModule
{
	public class RestoreServiceWindow : GameWindow
	{
		private NguiManager nguiManager_;

		private RestoreServiceController restoreServiceController_;

		private RestoreServiceWindowHierarchy hierarchy_;

		private DialogWindowManager dialogWindowManager_;

		private RestoreServiceItemHierarchy currentItemHierarchy_;

		private RestoreServiceItemHierarchy remoteItemHierarchy_;

		public RestoreServiceWindow()
			: base(false)
		{
			SingletonManager.Get<NguiManager>(out nguiManager_);
			SingletonManager.Get<DialogWindowManager>(out dialogWindowManager_);
			SingletonManager.Get<RestoreServiceController>(out restoreServiceController_);
			prefabsManager.Load("RestoreServiceModule");
			hierarchy_ = prefabsManager.InstantiateIn<RestoreServiceWindowHierarchy>("UIRestoreServiceWindow", nguiManager_.UiRoot.transform);
			currentItemHierarchy_ = prefabsManager.InstantiateIn<RestoreServiceItemHierarchy>("UIRestoreServiceItem", hierarchy_.holderCurrent.transform);
			remoteItemHierarchy_ = prefabsManager.InstantiateIn<RestoreServiceItemHierarchy>("UIRestoreServiceItem", hierarchy_.holderRemote.transform);
			currentItemHierarchy_.money.title.text = Localisations.Get("UI_RestoreService_Crystals");
			remoteItemHierarchy_.money.title.text = Localisations.Get("UI_RestoreService_Crystals");
			ButtonSet.Up(currentItemHierarchy_.button, CurrentSelectedPressed, ButtonSetGroup.InWindow);
			ButtonSet.Up(remoteItemHierarchy_.button, RemoteSelectedPressed, ButtonSetGroup.InWindow);
			SetContent(hierarchy_.transform, true, true, false, false, true);
			hierarchy_.title.text = Localisations.Get("UI_RestoreService_WindowTitle");
			hierarchy_.description.text = Localisations.Get("UI_RestoreService_Description");
			hierarchy_.orLabel.text = Localisations.Get("UI_RestoreService_Or");
		}

		public void OpenWindow(string currentNickname, int currentLevel, int currentMoney, string remoteNickname, int remoteLevel, int remoteMoney)
		{
			currentItemHierarchy_.nickname.text = ((!string.IsNullOrEmpty(currentNickname)) ? currentNickname : Localisations.Get("UI_RestoreService_NoName"));
			currentItemHierarchy_.level.text = string.Format("[{0}]", currentLevel);
			currentItemHierarchy_.money.value.text = currentMoney.ToString();
			remoteItemHierarchy_.nickname.text = ((!string.IsNullOrEmpty(remoteNickname)) ? remoteNickname : Localisations.Get("UI_RestoreService_NoName"));
			remoteItemHierarchy_.level.text = string.Format("[{0}]", remoteLevel);
			remoteItemHierarchy_.money.value.text = remoteMoney.ToString();
			if (!Visible)
			{
				windowsManager.ToggleWindow(this);
			}
		}

		private void RemoteSelectedPressed()
		{
			dialogWindowManager_.ShowDialogue(Localisations.Get("UI_RestoreService_SelectRemoteWarning"), RemoteSelected);
		}

		private void RemoteSelected()
		{
			if (Visible)
			{
				windowsManager.ToggleWindow(this);
			}
			restoreServiceController_.SelectRemoteProfile();
		}

		private void CurrentSelectedPressed()
		{
			dialogWindowManager_.ShowDialogue(Localisations.Get("UI_RestoreService_SelectCurrentWarning"), CurrentSelected);
		}

		private void CurrentSelected()
		{
			if (Visible)
			{
				windowsManager.ToggleWindow(this);
			}
			restoreServiceController_.SelectCurrentProfile();
		}
	}
}
