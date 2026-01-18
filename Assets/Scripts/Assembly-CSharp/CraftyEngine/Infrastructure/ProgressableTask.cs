using System;
using Extensions;

namespace CraftyEngine.Infrastructure
{
	public abstract class ProgressableTask : AsynchronousTask, IProgressable
	{
		public float Progress { get; private set; }

		public override float Weight
		{
			get
			{
				return 1f;
			}
			set
			{
			}
		}

		public event Action<float> Progressed;

		protected void ReportProgress(float progress)
		{
			Progress = progress;
			this.Progressed.SafeInvoke(progress);
		}
	}
}
