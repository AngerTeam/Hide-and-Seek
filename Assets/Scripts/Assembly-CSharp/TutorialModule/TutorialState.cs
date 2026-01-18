using System;

namespace TutorialModule
{
	public abstract class TutorialState
	{
		public string title;

		public bool invisible;

		public TutorialHighlight label;

		public TutorialHighlight arrow;

		public event Action Completed;

		public event Action<bool> Failed;

		public TutorialState()
		{
			label = new TutorialHighlight();
		}

		protected void ReportFail(bool critical)
		{
			this.Failed(critical);
		}

		protected void Complete()
		{
			OnComplete();
			this.Completed();
		}

		public virtual void OnStart()
		{
		}

		public virtual void OnComplete()
		{
		}

		public void Start()
		{
			OnStart();
		}
	}
}
