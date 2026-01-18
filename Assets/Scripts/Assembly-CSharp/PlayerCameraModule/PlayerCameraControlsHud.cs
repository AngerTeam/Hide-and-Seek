using CraftyEngine.Infrastructure;
using HudSystem;
using UnityEngine;

namespace PlayerCameraModule
{
	public class PlayerCameraControlsHud : HeadUpDisplay
	{
		private PlayerCameraManager cameraManager_;

		public PlayerCameraControlsHud()
		{
			SingletonManager.Get<PlayerCameraManager>(out cameraManager_);
			KeyboardInputManager singlton;
			SingletonManager.Get<KeyboardInputManager>(out singlton);
			ActionButtonHierarchy actionButtonHierarchy = prefabsManager.InstantiateNGUIIn<ActionButtonHierarchy>("UICameraModeButton", nguiManager.UiRoot.CameraModeButtonContainer.gameObject);
			hudStateSwitcher.Register(1, actionButtonHierarchy);
			ButtonSet.Up(actionButtonHierarchy.button, HandleSwitchCameraMode, ButtonSetGroup.Hud);
			singlton.AddHotkey(KeyCode.F5, HandleSwitchCameraMode);
		}

		public override void Dispose()
		{
			if (cameraManager_ != null)
			{
				cameraManager_.Dispose();
			}
		}

		private void HandleSwitchCameraMode()
		{
			if (cameraManager_ != null)
			{
				cameraManager_.StatesController.TogglePersonMode();
			}
		}
	}
}
