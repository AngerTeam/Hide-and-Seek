using UnityEngine;

namespace PlayerCameraModule
{
	public interface ICameraObstacleSensor
	{
		CameraObstacleSensorHit Raycast(Vector3 origin, Vector3 direction, float distance);
	}
}
