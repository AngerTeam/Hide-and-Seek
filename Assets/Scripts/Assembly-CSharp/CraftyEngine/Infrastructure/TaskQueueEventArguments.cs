using System;

namespace CraftyEngine.Infrastructure
{
	public class TaskQueueEventArguments : EventArgs
	{
		public ITask task;
	}
}
