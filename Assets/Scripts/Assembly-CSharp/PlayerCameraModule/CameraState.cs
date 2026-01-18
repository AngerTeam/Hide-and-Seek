using CraftyEngine.States;
using UnityEngine;

namespace PlayerCameraModule
{
	public abstract class CameraState : State
	{
		protected readonly PlayerCamera camera_;

		protected readonly PlayerCameraInputModel cameraInputModel_;

		protected float positionSmoothTime_ = 0.1f;

		protected Vector3 positionVelocity_;

		protected Vector3 targetPosition_;

		public Transform Target { get; set; }

		public Vector3 TargetOffset { get; set; }

		public ICameraObstacleSensor ObstacleSensor { get; set; }

		public CameraState(string name, PlayerCamera camera, PlayerCameraInputModel cameraInputModel)
			: base(name)
		{
			camera_ = camera;
			cameraInputModel_ = cameraInputModel;
		}

		public virtual void Update()
		{
			UpdatePosition();
		}

		public virtual void Reset()
		{
			if (Target != null)
			{
				targetPosition_ = Target.position;
			}
			UpdatePosition();
		}

		protected override void OnEnter()
		{
			if (Target != null)
			{
				targetPosition_ = Target.position;
			}
		}

		protected virtual void UpdatePosition()
		{
			if (Target != null)
			{
				targetPosition_ = Vector3.SmoothDamp(targetPosition_, Target.position, ref positionVelocity_, positionSmoothTime_);
				camera_.SetTarget(targetPosition_);
				camera_.Distance = 0.001f;
			}
		}

		protected bool CheckTargetOffsetObstacle(Vector3 targetOffset, out Vector3 resultOffset)
		{
			resultOffset = targetOffset;
			if (ObstacleSensor == null)
			{
				return false;
			}
			Vector3 vector = CameraUtils.CalcTargetWithOffset(camera_.Transform, camera_.Target, targetOffset);
			Vector3 vector2 = CameraUtils.ProjectPointOnPlane(camera_.Transform.right, camera_.Target, vector);
			Vector3 vector3 = vector - vector2;
			float num = 0.15f;
			CameraObstacleSensorHit cameraObstacleSensorHit = ObstacleSensor.Raycast(vector2, vector3.normalized, vector3.magnitude + num);
			if (cameraObstacleSensorHit != null)
			{
				float x = (cameraObstacleSensorHit.point - vector2).magnitude - num;
				resultOffset.x = x;
				return true;
			}
			return false;
		}

		protected void CheckDistanceObstacle()
		{
			if (ObstacleSensor != null)
			{
				CameraObstacleSensorHit cameraObstacleSensorHit = ObstacleSensor.Raycast(camera_.TargetWithOffset, -camera_.Transform.forward, camera_.Distance + 0.2f);
				if (cameraObstacleSensorHit != null)
				{
					camera_.Distance = (cameraObstacleSensorHit.point - camera_.TargetWithOffset).magnitude - 0.2f;
				}
			}
		}

		protected float CorrectNearestDistance(Vector3 targetOffset, float distance)
		{
			float num = Vector3.Angle(camera_.Transform.forward, Vector3.up);
			if (Mathf.Abs(targetOffset.x) < 0.4f && Mathf.Abs(targetOffset.z) < 0.4f && num < 15f)
			{
				distance = 0f;
			}
			return distance;
		}
	}
}
