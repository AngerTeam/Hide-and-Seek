using UnityEngine;

namespace PlayerCameraModule
{
	public class CinematicCameraState : CameraState
	{
		public Vector3 TargetPosition { get; set; }

		public float Distance
		{
			get
			{
				return 0.01f;
			}
		}

		public CinematicCameraState(PlayerCamera camera, PlayerCameraInputModel cameraInputModel)
			: base("CinematicCameraState", camera, cameraInputModel)
		{
		}
	}
}
