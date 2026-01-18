using System;
using UnityEngine;

namespace ProjectilesModule
{
	public class PlaymatePushMotionController : IDisposable
	{
		public float startTime;

		public float endTime;

		private TrajectoryChain trajectory_;

		public void StartTrajectory(TrajectoryChain trajectory, int pushTime)
		{
			trajectory_ = trajectory;
			startTime = Time.time;
			endTime = trajectory.EndTime;
		}

		public Vector3 GetCurrentPosition(Vector3 serverPos)
		{
			Vector3 result = serverPos;
			float num = Time.time - startTime;
			if (num <= endTime)
			{
				int section;
				Vector3 position = trajectory_.GetPosition(num, out section);
				if (position != Vector3.zero)
				{
					result = Vector3.Lerp(position, serverPos, num / endTime);
				}
			}
			return result;
		}

		public void Dispose()
		{
		}
	}
}
