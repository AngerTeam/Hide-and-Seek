using CraftyVoxelEngine;
using PlayerCameraModule;
using UnityEngine;

namespace MyPlayerInput
{
	public class CameraVoxelObstacleSensor : ICameraObstacleSensor
	{
		private VoxelEngine voxelEngine_;

		public CameraObstacleSensorHit Raycast(Vector3 origin, Vector3 direction, float distance)
		{
			voxelEngine_ = voxelEngine_ ?? SingletonManager.Get<VoxelEngine>();
			if (voxelEngine_ == null)
			{
				return null;
			}
			VoxelRaycastHit voxelRaycastHit = voxelEngine_.Manager.RayCast(origin, direction, distance, true);
			object result;
			if (voxelRaycastHit.success)
			{
				CameraObstacleSensorHit cameraObstacleSensorHit = new CameraObstacleSensorHit();
				cameraObstacleSensorHit.point = voxelRaycastHit.Point;
				result = cameraObstacleSensorHit;
			}
			else
			{
				result = null;
			}
			return (CameraObstacleSensorHit)result;
		}
	}
}
