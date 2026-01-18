using System.Collections.Generic;
using CraftyVoxelEngine;
using UnityEngine;

namespace ProjectilesModule
{
	public class TrajectoryPhysics
	{
		private readonly VoxelEngine voxelEngine_;

		public static float timeStep = 0.05f;

		public static float friction = 0.6f;

		public static float fading = 0.1f;

		public static int subTrajectoryLimit = 8;

		public TrajectoryPhysics(VoxelEngine engine)
		{
			voxelEngine_ = engine;
		}

		public TrajectoryChain Calculate(Vector3 position, Vector3 velocity, float timeLimit)
		{
			List<Trajectory> list = new List<Trajectory>();
			float num = 0f;
			for (int i = 0; i < subTrajectoryLimit; i++)
			{
				Vector3 outVelocity;
				Trajectory trajectory = ParabolicCast(position, velocity, timeLimit, out outVelocity);
				list.Add(trajectory);
				position = trajectory.GetPosition(trajectory.endTime);
				velocity = outVelocity * friction;
				float endTime = trajectory.endTime;
				trajectory.startTime += num;
				trajectory.endTime += num;
				num += endTime;
				timeLimit -= endTime;
				if (timeLimit <= 0f || velocity.sqrMagnitude < fading)
				{
					break;
				}
			}
			return new TrajectoryChain(list.ToArray());
		}

		public Trajectory ParabolicCast(Vector3 position, Vector3 velocity, float timeLimit, out Vector3 outVelocity)
		{
			outVelocity = Vector3.zero;
			Trajectory trajectory = new Trajectory(position, velocity);
			trajectory.startTime = 0f;
			for (float num = 0f; num < timeLimit; num += timeStep)
			{
				Vector3 position2 = trajectory.GetPosition(num);
				Vector3 position3 = trajectory.GetPosition(num + timeStep);
				Vector3 vector = position3 - position2;
				VoxelRaycastHit voxelRaycastHit = voxelEngine_.Manager.RayCast(position2, vector.normalized, vector.magnitude, false);
				if (voxelRaycastHit.success)
				{
					trajectory.endTime = (voxelRaycastHit.Point.x - position.x) / velocity.x;
					Vector3 velocity2 = trajectory.GetVelocity(trajectory.endTime);
					Vector3 normalBySide = BoxSide.GetNormalBySide(voxelRaycastHit.side);
					outVelocity = Vector3.Reflect(velocity2, normalBySide);
					break;
				}
			}
			return trajectory;
		}
	}
}
