using UnityEngine;

namespace ProjectilesModule
{
	public interface ITrajectory
	{
		float EndTime { get; }

		Vector3 GetPosition(float time);

		Vector3 GetVelocity(float time);
	}
}
