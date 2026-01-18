namespace MyPlayerInput
{
	public class FirstPersonInputController : PersonInputController
	{
		public FirstPersonInputController(BodySmoothTransformController bodySmoothTransformController)
			: base(bodySmoothTransformController)
		{
		}

		public override void Update()
		{
			base.Update();
			AlignRotationWithCamera();
		}

		protected override void AlignRotationWithCamera()
		{
			bodySmoothTransformController_.SetRotation(cameraManager_.Transform.eulerAngles);
		}
	}
}
