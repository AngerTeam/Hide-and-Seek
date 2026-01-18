using System;

namespace CraftyEngine.Infrastructure
{
	public abstract class AsynchronousTask : ITask
	{
		public static long lastAsyncTaskTime;

		public virtual float Weight { get; set; }

		public bool IsCompleted { get; private set; }

		public string CreateCallStack { get; private set; }

		public event EventHandler<EventArgs> Completed;

		public event EventHandler<ErrorEventArguments> Error;

		public AsynchronousTask()
		{
			CreateCallStack = SyncTask.GetStackTrace();
		}

		public abstract void Start();

		protected void CompleteWithError(string errorMessage, int errorCode = -1)
		{
			if (this.Error != null)
			{
				this.Error(this, new ErrorEventArguments(errorMessage, errorCode));
			}
			Complete();
		}

		public void UnsubscribeAll()
		{
			this.Completed = null;
		}

		protected void Complete()
		{
			try
			{
				IsCompleted = true;
				if (this.Completed != null)
				{
					this.Completed(this, new EventArgs());
				}
			}
			catch (Exception exc)
			{
				Log.Exception(exc);
			}
		}
	}
}
