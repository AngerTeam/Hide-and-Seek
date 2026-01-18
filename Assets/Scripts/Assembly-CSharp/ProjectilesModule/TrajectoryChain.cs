using System;
using UnityEngine;

namespace ProjectilesModule
{
	public class TrajectoryChain : ITrajectory
	{
		public Trajectory[] sections;

		public float StartTime
		{
			get
			{
				return sections[0].startTime;
			}
		}

		public float EndTime
		{
			get
			{
				return sections[sections.Length - 1].endTime;
			}
		}

		public TrajectoryChain(Trajectory[] chain = null)
		{
			sections = chain;
		}

		public TrajectoryChain(Vector3[] list)
		{
			FromArray(list);
		}

		public Vector3 GetPosition(float time)
		{
			for (int i = 0; i < sections.Length; i++)
			{
				if (sections[i].startTime < time && time <= sections[i].endTime)
				{
					return sections[i].GetPosition(time);
				}
			}
			return sections[sections.Length - 1].GetPosition(time);
		}

		public Vector3 GetPosition(float time, out int section)
		{
			for (int i = 0; i < sections.Length; i++)
			{
				if (sections[i].startTime < time && time <= sections[i].endTime)
				{
					section = i;
					return sections[i].GetPosition(time);
				}
			}
			section = sections.Length - 1;
			return sections[section].GetPosition(time);
		}

		public Vector3 GetVelocity(float time)
		{
			for (int i = 0; i < sections.Length; i++)
			{
				if (sections[i].startTime < time && time <= sections[i].endTime)
				{
					return sections[i].GetVelocity(time);
				}
			}
			return sections[sections.Length].GetVelocity(time);
		}

		public Vector3 GetFinalPosition()
		{
			return sections[sections.Length - 1].startPosition;
		}

		public Vector3[] ToArray()
		{
			Vector3[] array = new Vector3[sections.Length * 3];
			for (int i = 0; i < sections.Length; i++)
			{
				array[i * 3] = sections[i].startPosition;
				array[i * 3 + 1] = sections[i].startVelocity;
				array[i * 3 + 2].x = sections[i].startTime;
				array[i * 3 + 2].y = sections[i].endTime;
			}
			return array;
		}

		public void FromArray(Vector3[] list)
		{
			if (list.Length % 3 != 0)
			{
				throw new ArgumentException("Incorrect array length! Must be a multiple of 3!", "list");
			}
			int num = list.Length / 3;
			sections = new Trajectory[num];
			for (int i = 0; i < num; i++)
			{
				Trajectory trajectory = new Trajectory(list[i * 3], list[i * 3 + 1]);
				trajectory.startTime = list[i * 3 + 2].x;
				trajectory.endTime = list[i * 3 + 2].y;
				sections[i] = trajectory;
			}
		}
	}
}
