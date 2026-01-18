using System;

namespace CraftyEngine.Infrastructure
{
	public interface ITask
	{
		string CreateCallStack { get; }

		event EventHandler<EventArgs> Completed;

		void Start();
	}
}
