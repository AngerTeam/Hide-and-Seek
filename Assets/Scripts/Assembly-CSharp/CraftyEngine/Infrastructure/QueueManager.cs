using System;
using System.Collections.Generic;

namespace CraftyEngine.Infrastructure
{
	public class QueueManager : Singleton
	{
		private List<TaskQueue> queueList_;

		public TaskQueue DefaultQueue { get; private set; }

		public QueueManager()
		{
			queueList_ = new List<TaskQueue>();
		}

		public override void Init()
		{
			DefaultQueue = AddUnityThreadQueue();
		}

		public TaskQueue AddTaskQueue()
		{
			TaskQueue taskQueue = new TaskQueue();
			queueList_.Add(taskQueue);
			return taskQueue;
		}

		public UnityThreadQueue AddUnityThreadQueue()
		{
			UnityThreadQueue unityThreadQueue = new UnityThreadQueue();
			unityThreadQueue.allowSync = true;
			queueList_.Add(unityThreadQueue);
			return unityThreadQueue;
		}

		public void AddTask(Action action, TaskQueue queue = null)
		{
			AddTask(new ActionTask(action), queue);
		}

		public void AddTask(ITask task, TaskQueue queue = null)
		{
			if (queue == null)
			{
				queue = DefaultQueue;
			}
			queue.Add(task);
		}

		public override void Dispose()
		{
			foreach (TaskQueue item in queueList_)
			{
				item.Dispose();
			}
		}
	}
}
