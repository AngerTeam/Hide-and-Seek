using System;
using MyPlayerInput;
using PlayerCameraModule;

namespace PlayerModule.MyPlayer
{
	public class MyPlayerVisibleStatesController : IDisposable
	{
		private readonly MyPlayerStatsModel myPlayerStatsModel_;

		private readonly PlayerCameraManager cameraManager_;

		public MyPlayerVisibleStatesController(MyPlayerInputController inputController)
		{
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			SingletonManager.Get<PlayerCameraManager>(out cameraManager_);
			myPlayerStatsModel_.stats.visibility.ByCameraMode = false;
			cameraManager_.StatesController.StateFirstPerson.Target = inputController.EyesTransform;
			cameraManager_.StatesController.StateThirdPerson.Target = inputController.EyesTransform;
			cameraManager_.StatesController.StateAiming.Target = inputController.EyesTransform;
			cameraManager_.StatesController.CameraModeChanged += HandleCameraModeChanged;
			cameraManager_.StatesController.SwitchFirstPersonState(true);
		}

		public void Dispose()
		{
			cameraManager_.StatesController.CameraModeChanged -= HandleCameraModeChanged;
			myPlayerStatsModel_.input.EnabledByCameraMode = true;
		}

		private void HandleCameraModeChanged(CameraMode cameraMode)
		{
			switch (cameraMode)
			{
			case CameraMode.ThirdPerson:
				myPlayerStatsModel_.input.EnabledByCameraMode = true;
				myPlayerStatsModel_.myVisibility.VisibleByCameraMode = false;
				myPlayerStatsModel_.stats.resultVisibility = myPlayerStatsModel_.stats.visibility;
				myPlayerStatsModel_.stats.visibility.ByCameraMode = true;
				myPlayerStatsModel_.stats.visual.byCamera3Rd.enabled = true;
				myPlayerStatsModel_.stats.visual.byCamera1St.enabled = false;
				break;
			case CameraMode.FirstPerson:
			case CameraMode.Aiming:
				myPlayerStatsModel_.input.EnabledByCameraMode = true;
				myPlayerStatsModel_.stats.visibility.ByCameraMode = false;
				myPlayerStatsModel_.stats.resultVisibility = myPlayerStatsModel_.myVisibility;
				myPlayerStatsModel_.myVisibility.VisibleByCameraMode = true;
				myPlayerStatsModel_.stats.visual.byCamera3Rd.enabled = false;
				myPlayerStatsModel_.stats.visual.byCamera1St.enabled = true;
				break;
			case CameraMode.Static:
				myPlayerStatsModel_.input.EnabledByCameraMode = false;
				myPlayerStatsModel_.stats.visibility.ByCameraMode = false;
				myPlayerStatsModel_.stats.resultVisibility = myPlayerStatsModel_.myVisibility;
				myPlayerStatsModel_.myVisibility.VisibleByCameraMode = false;
				myPlayerStatsModel_.stats.visual.byCamera3Rd.enabled = false;
				myPlayerStatsModel_.stats.visual.byCamera1St.enabled = false;
				break;
			case CameraMode.Cinematic:
				myPlayerStatsModel_.input.EnabledByCameraMode = false;
				myPlayerStatsModel_.stats.visibility.ByCameraMode = false;
				myPlayerStatsModel_.stats.resultVisibility = myPlayerStatsModel_.myVisibility;
				myPlayerStatsModel_.myVisibility.VisibleByCameraMode = false;
				myPlayerStatsModel_.stats.visual.byCamera3Rd.enabled = false;
				myPlayerStatsModel_.stats.visual.byCamera1St.enabled = true;
				break;
			}
		}
	}
}
