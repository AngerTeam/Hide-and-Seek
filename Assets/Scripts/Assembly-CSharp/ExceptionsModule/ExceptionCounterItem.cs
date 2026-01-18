using CraftyEngine.Content;
using CraftyNetworkEngine;

namespace ExceptionsModule
{
	public class ExceptionCounterItem
	{
		public ExceptionsEntries entry;

		public GreedyCounter greedyCounter;

		public ExceptionCounterItem(ExceptionsEntries entry)
		{
			this.entry = entry;
			greedyCounter = new GreedyCounter(entry.event_counter, entry.reset_timeout);
			greedyCounter.Start();
		}
	}
}
