using System;
using System.Collections.Generic;
using CraftyEngine.Content;

namespace ExceptionsModule
{
	public class ExceptionsManager : Singleton
	{
		private Dictionary<int, List<ExceptionHandler>> customHandlers_;

		private List<ExceptionHandler> defaultHandlers_;

		private ExceptionsStatistics statistics_;

		public ExceptionsManager()
		{
			defaultHandlers_ = new List<ExceptionHandler>();
			customHandlers_ = new Dictionary<int, List<ExceptionHandler>>();
		}

		public void AddDefaultHandler(ExceptionHandler handler)
		{
			defaultHandlers_.Add(handler);
		}

		public void AddHandler(ExceptionHandler handler, params int[] exceptionIds)
		{
			if (exceptionIds != null)
			{
				foreach (int key in exceptionIds)
				{
					customHandlers_.GetOrSet(key).Add(handler);
				}
			}
		}

		public override void Init()
		{
			Exc.ExceptionRecieved += ProcessException;
			SingletonManager.Get<ExceptionsStatistics>(out statistics_);
		}

		public void RemoveHandler(ExceptionHandler handler)
		{
			foreach (List<ExceptionHandler> value in customHandlers_.Values)
			{
				for (int num = value.Count - 1; num >= 0; num--)
				{
					if (value[num] == handler)
					{
						value.RemoveAt(num);
					}
				}
			}
		}

		private void LogException(ExceptionArgs args, bool processed)
		{
			string text = ((!processed) ? "Unhandled" : "Handled");
			string text2 = ((args.exceptionEntry != null) ? args.exceptionEntry.title : null);
			string text3 = ((!args.debug) ? string.Empty : "[DEBUG]");
			string text4 = ((args.data != null) ? (" message: " + args.data) : null);
			string text5 = ((args.context != null) ? (" in " + args.context) : null);
			string text6 = ((args.exceptionEntry == null || args.exceptionEntry.event_counter <= 1) ? string.Empty : string.Format(" {0}/{1}", args.count, args.exceptionEntry.event_counter));
			string text7 = string.Format("{0}{5} {6}Exception id:{1} {2}{3}{4}", text, args.Id, text2, text5, text4, text6, text3);
			if (processed)
			{
				Log.Warning(text7);
			}
			else
			{
				Exception ex = args.data as Exception;
				if (ex == null)
				{
					ex = args.context as Exception;
				}
				if (ex != null)
				{
					Log.Exception(ex);
				}
				Log.Error(text7);
			}
			if (!CompileConstants.EDITOR && !args.debug && (args.exceptionEntry == null || args.exceptionEntry.for_stat != 0) && (!processed || args.exceptionEntry.view_mode != 1))
			{
				statistics_.Report(args, text7);
			}
		}

		private void ProcessException(ExceptionArgs args)
		{
			bool processed = false;
			if (CraftyEngineContentMap.Exceptions != null)
			{
				CraftyEngineContentMap.Exceptions.TryGetValue(args.Id, out args.exceptionEntry);
			}
			List<ExceptionHandler> value;
			if (customHandlers_.TryGetValue(args.Id, out value))
			{
				foreach (ExceptionHandler item in value)
				{
					if (item(args))
					{
						processed = true;
					}
				}
			}
			foreach (ExceptionHandler item2 in defaultHandlers_)
			{
				if (item2(args))
				{
					processed = true;
				}
			}
			LogException(args, processed);
		}
	}
}
