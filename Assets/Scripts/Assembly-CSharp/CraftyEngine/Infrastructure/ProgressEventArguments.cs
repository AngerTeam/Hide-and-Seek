using System;

namespace CraftyEngine.Infrastructure
{
	public class ProgressEventArguments : EventArgs
	{
		public float Progress { get; private set; }

		public ProgressEventArguments(float progress)
		{
			Progress = progress;
		}
	}
}
