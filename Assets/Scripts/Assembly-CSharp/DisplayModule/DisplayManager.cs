using CraftyEngine.Infrastructure;
using UnityEngine;

namespace DisplayModule
{
	public class DisplayManager : PermanentSingleton
	{
		private UnityEvent unityEvent_;

		private float lastInteractionMoment_;

		private int sleepTimeout_;

		public int SleepTimeout
		{
			get
			{
				return sleepTimeout_;
			}
			set
			{
				sleepTimeout_ = value;
				if (sleepTimeout_ <= 0)
				{
					sleepTimeout_ = 0;
					Screen.sleepTimeout = -1;
				}
				else
				{
					RefreshLastInteractionMoment();
				}
			}
		}

		public int Fps
		{
			get
			{
				return Application.targetFrameRate;
			}
			set
			{
				Application.targetFrameRate = value;
			}
		}

		public override void Init()
		{
			base.Init();
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			SleepTimeout = 0;
			if (CompileConstants.MOBILE)
			{
				unityEvent_.Subscribe(UnityEventType.ApplicationFocus, OnApplicationFocusChanged);
				unityEvent_.Subscribe(UnityEventType.Update, Update);
			}
		}

		public override void Dispose()
		{
			if (CompileConstants.MOBILE)
			{
				unityEvent_.Unsubscribe(UnityEventType.ApplicationFocus, OnApplicationFocusChanged);
				unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			}
			base.Dispose();
		}

		private void Update()
		{
			UpdateSleepTimeout();
		}

		private void UpdateSleepTimeout()
		{
			if (sleepTimeout_ != 0)
			{
				if (Input.touchCount > 0)
				{
					RefreshLastInteractionMoment();
				}
				if (Time.realtimeSinceStartup > lastInteractionMoment_ + (float)sleepTimeout_ && Screen.sleepTimeout != -2)
				{
					Screen.sleepTimeout = -2;
				}
			}
		}

		private void OnApplicationFocusChanged()
		{
			if (unityEvent_.HasFocus)
			{
				RefreshLastInteractionMoment();
			}
		}

		private void RefreshLastInteractionMoment()
		{
			lastInteractionMoment_ = Time.realtimeSinceStartup;
			Screen.sleepTimeout = -1;
		}
	}
}
