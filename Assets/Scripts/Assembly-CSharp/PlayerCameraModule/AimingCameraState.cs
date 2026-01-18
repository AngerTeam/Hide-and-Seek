namespace PlayerCameraModule
{
	public class AimingCameraState : CameraState
	{
		public float FovMultiplier { get; set; }

		public AimingCameraState(PlayerCamera camera, PlayerCameraInputModel cameraInputModel)
			: base("AimingCameraState", camera, cameraInputModel)
		{
			FovMultiplier = 1f;
		}

		protected override void OnEnter()
		{
			base.OnEnter();
			camera_.FovMultiplier = FovMultiplier;
			cameraInputModel_.autoAimEnabled = true;
		}

		protected override void OnExit()
		{
			cameraInputModel_.autoAimEnabled = false;
			camera_.FovMultiplier = 1f;
			base.OnExit();
		}
	}
}
