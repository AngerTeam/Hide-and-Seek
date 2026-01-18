using System;
using System.Timers;
using CraftyEngine.Infrastructure;

namespace CraftyEngine.Utils
{
	public class UnityTimerLegacy : IDisposable
	{
		public bool repeat;

		private bool completed_;

		private long startTime_;

		private bool subsribed_;

		private Timer timer_;

		private UnityEvent unityEvent;

		private bool disposed_;

		public float Time
		{
			get
			{
				double num = (double)(DateTime.Now.Ticks - startTime_) / 10000000.0;
				return (float)num;
			}
		}

		public event Action Completeted;

		public UnityTimerLegacy(float seconds, bool autoStart = true, bool isPermanent = false)
		{
			completed_ = false;
			timer_ = new Timer(seconds * 1000f);
			timer_.Stop();
			if (isPermanent)
			{
				Log.Error("Unable to start timer!");
			}
			else if (SingletonManager.TryGet<UnityEvent>(out unityEvent))
			{
				unityEvent.Subscribe(UnityEventType.Update, Update);
			}
			else
			{
				Log.Error("Unable to start timer!");
			}
			if (autoStart)
			{
				Start();
			}
		}

		~UnityTimerLegacy()
		{
			Dispose();
		}

		public void Dispose()
		{
			if (!disposed_)
			{
				if (unityEvent != null)
				{
					unityEvent.Unsubscribe(UnityEventType.Update, Update);
				}
				disposed_ = true;
			}
		}

		public void Start()
		{
			subsribed_ = true;
			startTime_ = DateTime.Now.Ticks;
			timer_.Elapsed += HandleTimerElapsed;
			timer_.Start();
		}

		public void Stop()
		{
			timer_.Stop();
			Dispose();
			subsribed_ = false;
		}

		public void Update()
		{
			if (subsribed_ && completed_ && this.Completeted != null)
			{
				completed_ = false;
				if (!repeat)
				{
					Stop();
				}
				this.Completeted();
			}
		}

		private void HandleTimerElapsed(object sender, ElapsedEventArgs e)
		{
			completed_ = true;
			if (!repeat)
			{
				timer_.Elapsed -= HandleTimerElapsed;
				timer_.Stop();
			}
		}
	}
}
