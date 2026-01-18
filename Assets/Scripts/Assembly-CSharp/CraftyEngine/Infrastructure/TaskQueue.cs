using System;
using System.Collections.Generic;

namespace CraftyEngine.Infrastructure
{
	public class TaskQueue : IDisposable
	{
		public bool allowSync;

		protected ITask activeTask;

		protected Queue<ITask> tasks;

		public int TaskCount
		{
			get
			{
				return tasks.Count;
			}
		}

		public event EventHandler<TaskQueueEventArguments> TaskAdded;

		public event EventHandler<EventArgs> AllTasksCompleted;

		public TaskQueue()
		{
			allowSync = true;
			tasks = new Queue<ITask>();
		}

		public virtual void Add(ITask task, bool first = false)
		{
			if (task == null)
			{
				throw new ArgumentNullException("task");
			}
			tasks.Enqueue(task);
			if (this.TaskAdded != null)
			{
				this.TaskAdded(this, new TaskQueueEventArguments
				{
					task = task
				});
			}
			if (allowSync)
			{
				Update();
			}
		}

		public virtual void Dispose()
		{
			allowSync = false;
		}

		protected void Update()
		{
			if (activeTask == null && tasks.Count > 0)
			{
				activeTask = tasks.Dequeue();
				activeTask.Completed += HandleActiveTaskCompleted;
				try
				{
					activeTask.Start();
				}
				catch (Exception ex)
				{
					string context = string.Format("Unable to start task {0} /exception: {1}", activeTask, ex.Message);
					Exc.Report(3001, context);
					HandleActiveTaskCompleted(null, null);
				}
			}
		}

		private void HandleActiveTaskCompleted(object sender, EventArgs args)
		{
			activeTask.Completed -= HandleActiveTaskCompleted;
			IDisposable disposable = activeTask as IDisposable;
			if (disposable != null)
			{
				disposable.Dispose();
			}
			if (allowSync)
			{
				activeTask = null;
				Update();
			}
			else
			{
				activeTask = null;
			}
			if (this.AllTasksCompleted != null && tasks.Count == 0 && activeTask == null)
			{
				this.AllTasksCompleted(this, new EventArgs());
			}
		}

		public void Clear()
		{
			tasks.Clear();
			if (activeTask != null)
			{
				activeTask.Completed -= HandleActiveTaskCompleted;
				activeTask = null;
			}
		}
	}
}
