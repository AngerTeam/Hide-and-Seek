using UnityEngine;

namespace ProjectilesModule
{
	public class Trajectory : ITrajectory
	{
		public static float gravity = 9.8f;

		public Vector3 startPosition;

		public Vector3 startVelocity;

		public float startTime;

		public float endTime;

		public float EndTime
		{
			get
			{
				return endTime;
			}
		}

		public Trajectory(Vector3 position, Vector3 velocity)
		{
			startPosition = position;
			startVelocity = velocity;
		}

		public Vector3 GetPosition(float time)
		{
			time -= startTime;
			Vector3 result = default(Vector3);
			result.x = startPosition.x + startVelocity.x * time;
			result.y = startPosition.y + startVelocity.y * time - gravity * time * time / 2f;
			result.z = startPosition.z + startVelocity.z * time;
			return result;
		}

		public Vector3 GetVelocity(float time)
		{
			Vector3 result = default(Vector3);
			result.x = startVelocity.x;
			result.y = startVelocity.y - gravity * time;
			result.z = startVelocity.z;
			return result;
		}
	}
}
