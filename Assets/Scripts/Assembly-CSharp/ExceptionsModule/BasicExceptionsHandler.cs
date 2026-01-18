using CraftyEngine.Content;
using CraftyEngine.Infrastructure;
using UnityEngine;

namespace ExceptionsModule
{
	public class BasicExceptionsHandler : Singleton
	{
		private ExceptionsManager exceptionsManager_;

		private ExceptionsCounters exceptionsCounters_;

		public override void Init()
		{
			exceptionsCounters_ = new ExceptionsCounters();
			SingletonManager.Get<ExceptionsManager>(out exceptionsManager_);
			exceptionsManager_.AddDefaultHandler(Handle);
		}

		public bool Handle(ExceptionArgs args)
		{
			ExceptionsEntries exceptionEntry = args.exceptionEntry;
			if (exceptionEntry == null)
			{
				return false;
			}
			if (exceptionEntry.admin_only == 1 && !DataStorage.isAdmin)
			{
				return true;
			}
			if (exceptionEntry.event_counter > 1)
			{
				if (!exceptionsCounters_.IsCritical(exceptionEntry))
				{
					args.count = exceptionsCounters_.GetAmount(args.Id);
					return true;
				}
				args.count = exceptionEntry.event_counter;
			}
			bool flag = exceptionEntry.is_critical == 1;
			bool result = false;
			if (exceptionEntry.view_mode > 0)
			{
				ShowException(args);
				result = true;
			}
			if (exceptionEntry.view_mode != 3 && flag)
			{
				Restart();
				result = true;
			}
			return result;
		}

		private void ShowException(ExceptionArgs args)
		{
			ExceptionsEntries exceptionEntry = args.exceptionEntry;
			string text = exceptionEntry.message;
			if (args.context != null)
			{
				text = text.Replace("%context%", args.context.ToString());
			}
			if (args.data != null)
			{
				text = text.Replace("%data%", args.data.ToString());
			}
			if (exceptionEntry.view_mode == 3)
			{
				MessageBroadcaster.ReportError(text, exceptionEntry.is_critical == 1);
			}
			else if (exceptionEntry.view_mode == 1)
			{
				Color? color = null;
				if (!string.IsNullOrEmpty(exceptionEntry.message_color))
				{
					color = ColorUtils.HexToColor(exceptionEntry.message_color);
				}
				int message_size = exceptionEntry.message_size;
				MessageBroadcaster.ReportInfo(text, 0f, message_size, color);
			}
		}

		private void Restart()
		{
			GameModel gameModel = SingletonManager.Get<GameModel>();
			gameModel.restartPending = true;
		}
	}
}
