using System;
using HudSystem;
using NguiTools;

namespace WindowsModule
{
	public class DialogWindow : GameWindow
	{
		public Action okHandler;

		public Action cancelHandler;

		private UIDialogWindowHierarchy dialogHierarchy;

		public DialogWindow()
			: base(true, false)
		{
			base.HudState = 8192;
			base.DontCloseOnEsc = true;
			PrefabsManagerNGUI singlton;
			SingletonManager.Get<PrefabsManagerNGUI>(out singlton);
			singlton.Load("WindowsModule");
			dialogHierarchy = singlton.InstantiateNGUIIn<UIDialogWindowHierarchy>("UIDialogWindow", nguiManager.UiRoot.gameObject);
			ButtonSet.Up(dialogHierarchy.cancelButton, Hide, ButtonSetGroup.Undefined);
			minimumDepth = 1002;
			SetContent(dialogHierarchy.transform, true, true, false, false, true);
			ButtonSet.Up(dialogHierarchy.okButton, delegate
			{
				Hide();
				if (okHandler != null)
				{
					okHandler();
					Reset();
				}
			}, ButtonSetGroup.Undefined);
			cancelHandler = null;
			ButtonSet.Up(dialogHierarchy.cancelButton, delegate
			{
				Hide();
				if (cancelHandler != null)
				{
					cancelHandler();
					Reset();
				}
			}, ButtonSetGroup.Undefined);
		}

		private void Reset()
		{
			okHandler = null;
			cancelHandler = null;
		}

		public void ShowDialogue(string message, string confirmation = "ok", string cancel = "cancel")
		{
			if (cancel == "cancel")
			{
				cancel = Localisations.Get("UI_Cancel");
			}
			ShowMessage(message, confirmation);
			dialogHierarchy.cancelButton.gameObject.SetActive(true);
			dialogHierarchy.cancelButtonMessage.text = cancel;
			dialogHierarchy.okButton.GetComponent<UIWidget>().rightAnchor.absolute = -100;
			dialogHierarchy.okButton.GetComponent<UIWidget>().leftAnchor.absolute = -450;
		}

		public void ShowMessage(string message, string confirmation = "ok")
		{
			if (confirmation == "ok")
			{
				confirmation = Localisations.Get("OK");
			}
			dialogHierarchy.cancelButton.gameObject.SetActive(false);
			dialogHierarchy.message.text = message;
			dialogHierarchy.okButtonMessage.text = confirmation;
			dialogHierarchy.gameObject.SetActive(true);
			dialogHierarchy.okButton.GetComponent<UIWidget>().rightAnchor.absolute = -300;
			dialogHierarchy.okButton.GetComponent<UIWidget>().leftAnchor.absolute = -800;
			Show();
		}

		private void Show()
		{
			if (!Visible)
			{
				Toggle();
			}
		}

		public void Hide()
		{
			if (Visible)
			{
				Toggle();
			}
		}

		private void Toggle()
		{
			windowsManager.ToggleWindow(this);
		}
	}
}
