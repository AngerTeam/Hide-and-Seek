using System;
using CraftyEngine.Infrastructure;
using Extensions;
using PopUpModule;

namespace WindowsModule
{
	public class MessageDisplay : Singleton
	{
		private MessageBroadcaster broadcaster_;

		private DialogWindowManager dialogWindowManager_;

		private PopUpManager popUpManager_;

		public event Action CriticalErrorConfirmed;

		public override void Init()
		{
			SingletonManager.Get<MessageBroadcaster>(out broadcaster_);
			SingletonManager.Get<DialogWindowManager>(out dialogWindowManager_);
			SingletonManager.Get<PopUpManager>(out popUpManager_);
			broadcaster_.MessageAdded += HandleMessageAdded;
		}

		public override void Dispose()
		{
			this.CriticalErrorConfirmed = null;
			broadcaster_.MessageAdded -= HandleMessageAdded;
		}

		private void HandleMessageAdded(MessageEventArguments args)
		{
			string text = Localisations.Get(args.Message);
			if (args.type == MessageType.Info)
			{
				if (args.color.HasValue)
				{
					popUpManager_.AddMessage(text, args.fontSize, args.color.Value);
				}
				else
				{
					popUpManager_.AddMessage(text, args.fontSize);
				}
			}
			else if (DataStorage.isAdmin)
			{
				dialogWindowManager_.ShowDialogue(text, (!args.isCritical) ? null : new Action(ReportCriticalErrorConfirm), null, "ok", "Я админ, мне все равно!", !args.isCritical);
			}
			else
			{
				dialogWindowManager_.ShowMessage(closable: !args.isCritical, message: text, okHandler: (!args.isCritical) ? null : new Action(ReportCriticalErrorConfirm));
			}
		}

		private void ReportCriticalErrorConfirm()
		{
			this.CriticalErrorConfirmed.SafeInvoke();
		}
	}
}
