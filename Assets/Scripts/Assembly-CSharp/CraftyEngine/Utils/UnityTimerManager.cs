using System.Collections.Generic;
using CraftyEngine.Infrastructure;

namespace CraftyEngine.Utils
{
	public class UnityTimerManager : Singleton
	{
		private UnityEvent unityEvent_;

		private List<UnityTimer> timers_;

		public UnityTimerManager()
		{
			timers_ = new List<UnityTimer>();
		}

		public override void Init()
		{
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			unityEvent_.Subscribe(UnityEventType.Update, Update);
		}

		public UnityTimer SetTimer(float duration = 1f, bool enable = true)
		{
			UnityTimer unityTimer = UnityTimer.Set(duration, enable);
			timers_.Add(unityTimer);
			return unityTimer;
		}

		private bool Check(int i)
		{
			UnityTimer unityTimer = timers_[i];
			if (unityTimer.enable)
			{
				unityTimer.Update();
			}
			return unityTimer.Completed;
		}

		public override void Dispose()
		{
			timers_.IterateAndRemove(Stop);
		}

		private bool Stop(int i)
		{
			UnityTimer unityTimer = timers_[i];
			unityTimer.Stop();
			return true;
		}

		private void Update()
		{
			timers_.IterateAndRemove(Check);
		}
	}
}
