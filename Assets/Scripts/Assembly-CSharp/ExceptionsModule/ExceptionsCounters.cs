using System.Collections.Generic;
using CraftyEngine.Content;

namespace ExceptionsModule
{
	public class ExceptionsCounters
	{
		public Dictionary<int, ExceptionCounterItem> CurrentExceptions;

		public ExceptionsCounters()
		{
			CurrentExceptions = new Dictionary<int, ExceptionCounterItem>();
		}

		public bool IsCritical(ExceptionsEntries exceptionsEntry)
		{
			if (!CurrentExceptions.ContainsKey(exceptionsEntry.id))
			{
				CurrentExceptions[exceptionsEntry.id] = new ExceptionCounterItem(exceptionsEntry);
			}
			return CurrentExceptions[exceptionsEntry.id].greedyCounter.PushError();
		}

		public int GetAmount(int id)
		{
			ExceptionCounterItem value;
			if (CurrentExceptions.TryGetValue(id, out value))
			{
				return value.greedyCounter.CurrentAmount;
			}
			return 1;
		}
	}
}
