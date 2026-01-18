using UnityEngine;

namespace PlayerCameraModule
{
	public class StaticCameraState : CameraState
	{
		public Vector3 CameraPosition { get; set; }

		public Quaternion CameraRotation { get; set; }

		public StaticCameraState(PlayerCamera camera, PlayerCameraInputModel cameraInputModel)
			: base("StaticCameraState", camera, cameraInputModel)
		{
		}

		protected override void OnEnter()
		{
			base.OnEnter();
			cameraInputModel_.EnabledByState = false;
			camera_.SetTarget(CameraPosition);
			camera_.SetRotationAroundTarget(CameraRotation);
			camera_.Distance = 0.001f;
		}

		protected override void UpdatePosition()
		{
		}

		protected override void OnExit()
		{
			cameraInputModel_.EnabledByState = true;
			base.OnExit();
		}
	}
}
