using System;

namespace CraftyEngine.Infrastructure
{
	public abstract class SyncTask : ITask
	{
		public string CreateCallStack { get; private set; }

		public event EventHandler<EventArgs> Completed;

		public SyncTask()
		{
			CreateCallStack = GetStackTrace();
		}

		public abstract void Body();

		public void Start()
		{
			try
			{
				Body();
			}
			catch (Exception exc)
			{
				Log.Exception(exc);
			}
			finally
			{
				if (this.Completed != null)
				{
					this.Completed(this, new EventArgs());
				}
			}
		}

		internal static string GetStackTrace()
		{
			return null;
		}
	}
}
