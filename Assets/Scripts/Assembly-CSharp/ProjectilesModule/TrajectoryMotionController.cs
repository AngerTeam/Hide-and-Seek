using System;
using Extensions;
using UnityEngine;

namespace ProjectilesModule
{
	public class TrajectoryMotionController : IDisposable
	{
		public float startTime;

		public float endTime;

		public float outTime;

		private readonly TrajectoryChain trajectory_;

		private readonly ProjectileView view_;

		private int trajectorySection_;

		public bool Finished { get; private set; }

		public bool Flying { get; private set; }

		public Vector3 Position
		{
			get
			{
				return (view_ == null) ? Vector3.zero : view_.Position;
			}
		}

		public event Action<Vector3> HitHappens;

		public event Action<Vector3> Grounded;

		public event Action<Vector3> TimeOut;

		public TrajectoryMotionController(ProjectileView view, TrajectoryChain trajectory)
		{
			trajectory_ = trajectory;
			startTime = Time.time;
			endTime = trajectory.EndTime - trajectory.StartTime;
			outTime = endTime;
			Flying = true;
			Finished = false;
			view_ = view;
			view_.Position = trajectory.GetPosition(0f);
		}

		public void Dispose()
		{
		}

		public void Update()
		{
			if (Finished)
			{
				return;
			}
			float num = Time.time - startTime;
			if (outTime <= num)
			{
				Finished = true;
				this.TimeOut.SafeInvoke(view_.Position);
			}
			else if (Flying)
			{
				int section;
				view_.Position = trajectory_.GetPosition(num, out section);
				if (section > trajectorySection_)
				{
					view_.OnHit();
					this.HitHappens.SafeInvoke(view_.Position);
					trajectorySection_ = section;
				}
				if (endTime <= num)
				{
					Flying = false;
					view_.OnStop();
					view_.Position = trajectory_.GetPosition(endTime);
					this.Grounded.SafeInvoke(view_.Position);
				}
			}
		}
	}
}
