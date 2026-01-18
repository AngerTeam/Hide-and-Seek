using System;
using Extensions;
using UnityEngine;

namespace CraftyEngine.Utils
{
	public class UnityTimer
	{
		private float momentStart_;

		private float momentEnd_;

		public bool repeat;

		public bool enable;

		public float duration;

		public bool Completed { get; private set; }

		public float Time
		{
			get
			{
				return UnityEngine.Time.time - momentStart_;
			}
		}

		public event Action Completeted;

		private UnityTimer(float seconds, bool enable = true)
		{
			duration = seconds;
			this.enable = enable;
			if (this.enable)
			{
				Reset();
			}
		}

		public static UnityTimer Set(float seconds, bool enable = true)
		{
			return new UnityTimer(seconds, enable);
		}

		public void Update()
		{
			if (!Completed && enable && UnityEngine.Time.time >= momentEnd_)
			{
				if (repeat)
				{
					Reset();
				}
				else
				{
					Completed = true;
				}
				this.Completeted.SafeInvoke();
			}
		}

		public void Stop()
		{
			enable = false;
			Completed = true;
			this.Completeted = null;
		}

		public void Reset()
		{
			momentEnd_ = UnityEngine.Time.time + duration;
			momentStart_ = UnityEngine.Time.time;
		}
	}
}
