using System;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.SingletonManagerCore;

namespace WindowsModule
{
	public class DialogWindowManager : Singleton
	{
		private DialogWindow dialogWindow_;

		public static void AskFor(string localization, Action handler, bool cancelAvalible = true)
		{
			UnityEvent.OnNextUpdate(delegate
			{
				AskForUnityThread(localization, handler, cancelAvalible);
			});
		}

		public override void Init()
		{
			dialogWindow_ = new DialogWindow();
			dialogWindow_.Hide();
			SingletonManager.PhaseStarted += HandlePhaseStarted;
		}

		public void ShowDialogue(string message, Action okHandler = null, Action cancelHandler = null, string confirmation = "ok", string cancel = "cancel", bool closable = true)
		{
			if (CompileConstants.EDITOR)
			{
				Log.Info("ShowDialogue {0}\n{1}", message, Environment.StackTrace);
			}
			else
			{
				Log.Info("ShowDialogue {0}", message);
			}
			dialogWindow_.okHandler = okHandler;
			dialogWindow_.cancelHandler = cancelHandler;
			dialogWindow_.ShowDialogue(message, confirmation, cancel);
			dialogWindow_.closable = closable;
		}

		public void ShowMessage(string message, Action okHandler = null, string confirmation = "ok", bool closable = true)
		{
			if (CompileConstants.EDITOR)
			{
				Log.Info("ShowMessage {0}\n{1}", message, Environment.StackTrace);
			}
			else
			{
				Log.Info("ShowMessage {0}", message);
			}
			dialogWindow_.okHandler = okHandler;
			dialogWindow_.ShowMessage(message, confirmation);
			dialogWindow_.closable = closable;
		}

		private static void AskForUnityThread(string localization, Action handler, bool cancelAvalible)
		{
			DialogWindowManager dialogWindowManager = SingletonManager.Get<DialogWindowManager>();
			string message = Localisations.Get(localization);
			string confirmation = Localisations.Get("OK");
			string cancel = ((!cancelAvalible) ? string.Empty : Localisations.Get("UI_Cancel"));
			dialogWindowManager.ShowDialogue(message, handler, null, confirmation, cancel);
		}

		private void HandlePhaseStarted(SingletonPhase obj, int layer)
		{
			if (obj == SingletonPhase.Init && dialogWindow_ != null && dialogWindow_.closable)
			{
				dialogWindow_.Hide();
			}
		}
	}
}
