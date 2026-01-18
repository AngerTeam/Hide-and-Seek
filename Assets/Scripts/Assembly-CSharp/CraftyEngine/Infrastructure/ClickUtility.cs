using System;
using Extensions;
using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class ClickUtility<T> : IDisposable
	{
		public class ClickState
		{
			public const int CLICKED = 3;

			public const int HOLDING = 4;

			public const int IDLE = 1;

			public const int PRESSED = 2;
		}

		private float clickMoment_;

		protected T instance;

		protected InputModel model;

		private UnityEvent unityEvent_;

		public int State { get; private set; }

		public bool IsPressed
		{
			get
			{
				return State != 1;
			}
		}

		protected virtual bool InsideThreshold
		{
			get
			{
				return true;
			}
		}

		public event Action<T> Clicked;

		public event Action<T> ClickFailed;

		public event Action<T> HoldEnded;

		public event Action<T> HoldStarted;

		public event Action<T> HoldStartedByDistance;

		public event Action<T> HoldStartedByDuration;

		public event Action<T> Pressed;

		public event Action<T> Released;

		public ClickUtility(T instance)
		{
			this.instance = instance;
			SingletonManager.Get<InputModel>(out model);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			unityEvent_.Subscribe(UnityEventType.Update, Update);
			State = 1;
		}

		public void Dispose()
		{
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			this.HoldStarted = null;
			this.Clicked = null;
			this.ClickFailed = null;
			this.HoldEnded = null;
			this.Pressed = null;
			this.Released = null;
		}

		public void Press()
		{
			State = 2;
			clickMoment_ = Time.unscaledTime + model.clickDurationTreshold;
			this.Pressed.SafeInvoke(instance);
		}

		public void Release()
		{
			if (State == 4)
			{
				this.HoldEnded.SafeInvoke(instance);
			}
			else if (State == 2)
			{
				if (Time.unscaledTime < clickMoment_ && InsideThreshold)
				{
					State = 3;
					this.Clicked.SafeInvoke(instance);
				}
				clickMoment_ = 0f;
			}
			this.Released.SafeInvoke(instance);
			State = 1;
		}

		public void Update()
		{
			if (State != 2)
			{
				return;
			}
			bool flag = Time.unscaledTime > clickMoment_;
			bool flag2 = !InsideThreshold;
			if (flag || flag2)
			{
				State = 4;
				this.ClickFailed.SafeInvoke(instance);
				this.HoldStarted.SafeInvoke(instance);
				if (flag)
				{
					this.HoldStartedByDuration.SafeInvoke(instance);
				}
				else
				{
					this.HoldStartedByDistance.SafeInvoke(instance);
				}
			}
		}
	}
}
