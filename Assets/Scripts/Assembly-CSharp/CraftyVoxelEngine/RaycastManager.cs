using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class RaycastManager : PermanentSingleton
	{
		private VoxelEngine voxelEngine_;

		private CameraManager cameraManager_;

		private InputManager inputManager_;

		public float distance = 10f;

		public float hitDistance;

		public Vector3 globalPosition;

		public override void Init()
		{
			SingletonManager.Get<InputManager>(out inputManager_);
			SingletonManager.Get<CameraManager>(out cameraManager_);
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
		}

		public override void Dispose()
		{
			inputManager_ = null;
			cameraManager_ = null;
			voxelEngine_ = null;
		}

		public VoxelRaycastHit VoxelRayCastWrap(float distance = -1f, bool ignoreNoCollide = false, Quaternion? rotationOffset = null)
		{
			if (inputManager_ == null)
			{
				return VoxelRaycastHit.EmptyMessage;
			}
			return VoxelRayCastWrap(inputManager_.Target, distance, ignoreNoCollide, rotationOffset);
		}

		public VoxelRaycastHit VoxelRayCastWrap(Vector3 screenPosition, float distance = -1f, bool ignoreNoCollide = false, Quaternion? rotationOffset = null)
		{
			if (cameraManager_.PlayerCamera == null || !cameraManager_.PlayerCamera.enabled)
			{
				return VoxelManager.EmptyRaycastHit;
			}
			globalPosition = cameraManager_.Transform.position;
			Vector3 vector = cameraManager_.PlayerCamera.ScreenPointToRay(screenPosition).direction;
			if (rotationOffset.HasValue)
			{
				vector = Quaternion.LookRotation(vector) * rotationOffset.Value * Vector3.forward;
			}
			if (distance < 0f)
			{
				distance = this.distance;
			}
			distance += cameraManager_.TargetDistance;
			VoxelRaycastHit result = voxelEngine_.Manager.RayCast(globalPosition, vector, distance, ignoreNoCollide);
			Debug.DrawLine(globalPosition, globalPosition + vector * distance, Color.cyan, 0f, true);
			if (result.success)
			{
				hitDistance = Vector3.Distance(result.Point, globalPosition);
			}
			return result;
		}

		public List<VoxelKey> GetVoxelsInSphere(Vector3 position, float radius)
		{
			VoxelKey voxelKey = new VoxelKey(position);
			List<VoxelKey> list = new List<VoxelKey>();
			float num = radius * radius;
			VoxelKey voxelKey2 = voxelKey - (int)Mathf.Ceil(radius);
			VoxelKey voxelKey3 = voxelKey + (int)Mathf.Ceil(radius);
			VoxelKey voxelKey4 = default(VoxelKey);
			voxelKey4.x = voxelKey2.x;
			while (voxelKey4.x <= voxelKey3.x)
			{
				voxelKey4.y = voxelKey2.y;
				while (voxelKey4.y <= voxelKey3.y)
				{
					voxelKey4.z = voxelKey2.z;
					while (voxelKey4.z <= voxelKey3.z)
					{
						Voxel voxel;
						VoxelData data;
						if ((voxelKey4 - voxelKey).ToVector().sqrMagnitude < num && voxelEngine_.core.GetVoxel(voxelKey4, out voxel) && voxel.Value != 0 && voxelEngine_.GetVoxelData(voxel.Value, out data) && data.Durability > 0)
						{
							list.Add(voxelKey4);
						}
						voxelKey4.z++;
					}
					voxelKey4.y++;
				}
				voxelKey4.x++;
			}
			return list;
		}
	}
}
