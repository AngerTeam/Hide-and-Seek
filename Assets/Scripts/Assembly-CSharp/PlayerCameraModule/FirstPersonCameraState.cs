using UnityEngine;

namespace PlayerCameraModule
{
	public class FirstPersonCameraState : CameraState
	{
		private readonly Camera weaponCamera_;

		public FirstPersonCameraState(PlayerCamera camera, PlayerCameraInputModel cameraInputModel)
			: base("FirstPersonState", camera, cameraInputModel)
		{
			GameObject gameObject = new GameObject("weapon camera");
			weaponCamera_ = gameObject.AddComponent<Camera>();
			weaponCamera_.cullingMask = 512;
			weaponCamera_.clearFlags = CameraClearFlags.Depth;
			weaponCamera_.depth = 4f;
			weaponCamera_.nearClipPlane = 0.1f;
			weaponCamera_.farClipPlane = 10f;
			weaponCamera_.enabled = false;
			gameObject.transform.SetParent(camera.Transform);
			gameObject.transform.localPosition = Vector3.zero;
			gameObject.transform.localRotation = Quaternion.identity;
			positionSmoothTime_ = 0.05f;
		}

		protected override void OnEnter()
		{
			base.OnEnter();
			weaponCamera_.enabled = true;
			cameraInputModel_.autoAimEnabled = true;
			camera_.SetTargetOffset(Vector3.zero);
			camera_.Distance = 0.001f;
		}

		protected override void OnExit()
		{
			cameraInputModel_.autoAimEnabled = false;
			weaponCamera_.enabled = false;
			base.OnExit();
		}
	}
}
