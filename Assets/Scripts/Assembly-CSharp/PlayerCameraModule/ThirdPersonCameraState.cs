using UnityEngine;

namespace PlayerCameraModule
{
	public class ThirdPersonCameraState : CameraState
	{
		private float distance_;

		private float cameraDistanceVelocity_;

		public float Distance
		{
			get
			{
				return distance_;
			}
			set
			{
				distance_ = value;
			}
		}

		public float MaxDistance { get; set; }

		public ThirdPersonCameraState(PlayerCamera camera, PlayerCameraInputModel cameraInputModel)
			: this("ThirdPersonCameraState", camera, cameraInputModel)
		{
		}

		protected ThirdPersonCameraState(string stateName, PlayerCamera camera, PlayerCameraInputModel cameraInputModel)
			: base(stateName, camera, cameraInputModel)
		{
		}

		protected override void OnEnter()
		{
			base.OnEnter();
			cameraInputModel_.autoAimEnabled = true;
		}

		protected override void OnExit()
		{
			cameraInputModel_.autoAimEnabled = false;
			base.OnExit();
		}

		protected override void UpdatePosition()
		{
			float num = CorrectNearestDistance(camera_.TargetOffset, distance_);
			float smoothTime = 0.5f;
			if (num <= 0f)
			{
				smoothTime = 0.1f;
			}
			camera_.Distance = Mathf.SmoothDamp(camera_.Distance, num, ref cameraDistanceVelocity_, smoothTime);
			camera_.SetTargetOffset(Vector3.Lerp(camera_.TargetOffset, base.TargetOffset, Time.deltaTime * 5f));
			if (base.Target != null)
			{
				targetPosition_ = Vector3.SmoothDamp(targetPosition_, base.Target.position, ref positionVelocity_, positionSmoothTime_);
				camera_.SetTarget(targetPosition_);
			}
			Vector3 resultOffset;
			if (CheckTargetOffsetObstacle(camera_.TargetOffset, out resultOffset))
			{
				camera_.SetTargetOffset(resultOffset);
			}
			CheckDistanceObstacle();
		}
	}
}
