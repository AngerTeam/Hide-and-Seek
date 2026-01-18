using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;

public class ProgressSegment : IDisposable
{
	public float weight;

	private List<AsynchronousTask> asynchronousTasks_;

	private List<IProgressable> progressableTasks_;

	public float Progress { get; private set; }

	public ProgressSegment()
	{
		weight = 1f;
		asynchronousTasks_ = new List<AsynchronousTask>();
		progressableTasks_ = new List<IProgressable>();
	}

	public void Update()
	{
		float num = 0f;
		float num2 = 0f;
		for (int i = 0; i < asynchronousTasks_.Count; i++)
		{
			AsynchronousTask asynchronousTask = asynchronousTasks_[i];
			if (asynchronousTask != null)
			{
				num += asynchronousTask.Weight;
				if (asynchronousTask.IsCompleted)
				{
					num2 += asynchronousTask.Weight;
				}
			}
		}
		for (int j = 0; j < progressableTasks_.Count; j++)
		{
			IProgressable progressable = progressableTasks_[j];
			if (progressable != null)
			{
				num += progressable.Weight;
				num2 += progressable.Weight * progressable.Progress;
			}
		}
		Progress = ((num != 0f) ? (num2 / num) : 0f);
	}

	internal void AddTask(IProgressable task)
	{
		progressableTasks_.Add(task);
	}

	public void AddTask(AsynchronousTask task)
	{
		IProgressable progressable = task as IProgressable;
		if (progressable == null)
		{
			asynchronousTasks_.Add(task);
		}
		else
		{
			AddTask(progressable);
		}
	}

	public void Dispose()
	{
		Clear();
	}

	public void Clear()
	{
		Progress = 0f;
		asynchronousTasks_.Clear();
		progressableTasks_.Clear();
	}
}
