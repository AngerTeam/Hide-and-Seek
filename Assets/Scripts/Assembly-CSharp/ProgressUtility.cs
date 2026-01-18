using System;
using CraftyEngine.Infrastructure;
using DG.Tweening;
using Extensions;

public class ProgressUtility : IDisposable
{
	public float tweenTime;

	private ProgressSegment defaultSegment_;

	private float progress_;

	private Tweener tweener_;

	private UnityEvent unityEvent_;

	private float lastProgress_;

	public float Progress
	{
		get
		{
			return progress_;
		}
		private set
		{
			if (value != progress_)
			{
				progress_ = value;
				this.Progressed.SafeInvoke(progress_);
			}
		}
	}

	public event Action<float> Progressed;

	public ProgressUtility(int layer)
	{
		tweenTime = 0.5f;
		defaultSegment_ = new ProgressSegment();
		SingletonManager.Get<UnityEvent>(out unityEvent_, layer);
		unityEvent_.Subscribe(UnityEventType.Update, Update);
	}

	public void RemoveQueue(TaskQueue queue)
	{
		queue.TaskAdded -= HandleTaskAdded;
	}

	public void AddQueue(TaskQueue queue)
	{
		queue.TaskAdded += HandleTaskAdded;
	}

	public void AddTask(IProgressable task)
	{
		defaultSegment_.AddTask(task);
	}

	public void AddTask(AsynchronousTask task)
	{
		defaultSegment_.AddTask(task);
	}

	public void Dispose()
	{
		this.Progressed = null;
		unityEvent_.Unsubscribe(UnityEventType.Update, Update);
		defaultSegment_.Dispose();
	}

	private void HandleTaskAdded(object sender, TaskQueueEventArguments e)
	{
		AsynchronousTask asynchronousTask = e.task as AsynchronousTask;
		if (asynchronousTask != null)
		{
			AddTask(asynchronousTask);
		}
	}

	public void Clear()
	{
		progress_ = 0f;
		defaultSegment_.Clear();
	}

	private void Update()
	{
		defaultSegment_.Update();
		float progress = defaultSegment_.Progress;
		if (lastProgress_ == progress)
		{
			return;
		}
		lastProgress_ = progress;
		if (tweenTime > 0f)
		{
			if (tweener_ != null)
			{
				tweener_.Kill();
			}
			tweener_ = DOTween.To(() => Progress, delegate(float p)
			{
				Progress = p;
			}, progress, tweenTime).SetEase(Ease.Linear);
		}
		else
		{
			Progress = progress;
		}
	}
}
