using CraftyEngine.Utils;

namespace CraftyEngine.Infrastructure
{
	public class WaitTask : AsynchronousTask
	{
		private UnityTimer timer_;

		private float delay_;

		public WaitTask(float delay)
		{
			delay_ = delay;
		}

		public override void Start()
		{
			UnityTimerManager unityTimerManager = SingletonManager.Get<UnityTimerManager>();
			timer_ = unityTimerManager.SetTimer(delay_);
			timer_.Completeted += HandleCompleteted;
		}

		private void HandleCompleteted()
		{
			Complete();
		}
	}
}
