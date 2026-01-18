namespace CraftyEngine.Infrastructure
{
	public class PauseQueueTask : AsynchronousTask
	{
		private bool completed_;

		private bool started_;

		public void Done()
		{
			completed_ = true;
			if (started_)
			{
				Complete();
			}
		}

		public override void Start()
		{
			started_ = true;
			if (completed_)
			{
				Complete();
			}
		}
	}
}
