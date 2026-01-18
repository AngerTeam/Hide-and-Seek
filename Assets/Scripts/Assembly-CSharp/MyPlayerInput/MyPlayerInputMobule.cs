using System;
using CraftyEngine;
using CraftyEngine.Infrastructure;
using CraftyVoxelEngine;
using HudSystem;
using PlayerCameraModule;
using PlayerModule.MyPlayer;
using UnityEngine;

namespace MyPlayerInput
{
	public class MyPlayerInputMobule : IDisposable
	{
		public MyPlayerInputController inputController;

		private KeyboardInputManager inputManager_;

		private MyPlayerStatsModel model_;

		private PlayerControlsHud playerHud_;

		private PlayerCameraManager cameraManager_;

		public MyPlayerInputMobule()
		{
			inputController = new MyPlayerInputController();
			Init();
		}

		public MyPlayerInputMobule(Vector3 position, Vector3 rotation)
		{
			inputController = new MyPlayerInputController();
			inputController.Start();
			inputController.Reset(position, rotation);
			inputController.PositionUpdated += HandlePositionUpdated;
			Init();
		}

		private void Init()
		{
			SingletonManager.Get<MyPlayerStatsModel>(out model_);
			SingletonManager.Get<KeyboardInputManager>(out inputManager_);
			SingletonManager.Get<PlayerCameraManager>(out cameraManager_);
			GuiModuleHolder.Get<PlayerControlsHud>(out playerHud_);
			playerHud_.JumpButtonPressed += HandleJumpButtonPressed;
			playerHud_.JumpButtonReleased += HandleJumpButtonReleased;
			playerHud_.AimButtonClicked += HandleAimButtonClicked;
			playerHud_.ReloadButtonClicked += HandleReloadButtonClicked;
			model_.stats.Reload += HandleReload;
			model_.stats.Shot += HandleShot;
			model_.UiActionChanged += HandleUiActionChanged;
			model_.stats.GrenadeAmmoChanged += HandleGrenadeAmmoChanged;
			cameraManager_.StatesController.CameraModeChanged += HandleCameraModeChanged;
			inputManager_.AddHotkey(KeyCode.F6, HandleSwitchCinematicCameraMode);
			inputController.VoxelRigidBody.MovedShiftDistance += model_.ReportMovedShiftDistance;
			playerHud_.SetGrenadeAmmo(model_.stats.GrenadeAmmo);
		}

		private void HandlePositionUpdated(Vector3 position, Vector3 rotation)
		{
			model_.stats.SetPosition(position, rotation);
		}

		private void HandleJumpButtonPressed()
		{
			inputManager_.PressMobileJump();
		}

		private void HandleJumpButtonReleased()
		{
			inputManager_.ReleaseMobileJump();
		}

		private void HandleAimButtonClicked()
		{
			model_.stats.Aiming = !model_.stats.Aiming;
		}

		private void HandleReloadButtonClicked()
		{
			model_.stats.Reloading = true;
		}

		private void HandleReload(bool obj)
		{
			if (obj)
			{
				playerHud_.PlayCooldown(model_.stats.artikulReloadTime);
			}
		}

		private void HandleShot(int ammo)
		{
			playerHud_.SetReloadButton(ammo);
		}

		private void HandleGrenadeAmmoChanged(int grenadeAmmo)
		{
			playerHud_.SetGrenadeAmmo(grenadeAmmo);
		}

		private void HandleSwitchCinematicCameraMode()
		{
			if (cameraManager_.StatesController.Mode == CameraMode.FirstPerson || cameraManager_.StatesController.Mode == CameraMode.ThirdPerson)
			{
				VoxelEngine voxelEngine = SingletonManager.Get<VoxelEngine>(1);
				if (voxelEngine != null)
				{
					VoxelRaycastHit voxelRaycastHit = voxelEngine.Manager.RayCast(cameraManager_.Transform.position, cameraManager_.Transform.forward, 100f, true);
					if (voxelRaycastHit.success)
					{
						cameraManager_.StatesController.SwitchCinematicState(voxelRaycastHit.Point);
					}
				}
			}
			else if (cameraManager_.StatesController.Mode == CameraMode.Cinematic)
			{
				cameraManager_.StatesController.SwitchToPersonMode();
			}
		}

		private void HandleUiActionChanged(int uiAction)
		{
			inputController.UpdateInteractiveAction(uiAction == 1 || uiAction == 2);
		}

		private void HandleCameraModeChanged(CameraMode cameraMode)
		{
			inputController.ToggleInputMode(cameraMode != CameraMode.ThirdPerson);
		}

		public void Dispose()
		{
			playerHud_.JumpButtonPressed -= HandleJumpButtonPressed;
			playerHud_.JumpButtonReleased -= HandleJumpButtonReleased;
			playerHud_.AimButtonClicked -= HandleAimButtonClicked;
			playerHud_.ReloadButtonClicked -= HandleReloadButtonClicked;
			inputController.VoxelRigidBody.MovedShiftDistance -= model_.ReportMovedShiftDistance;
			model_.stats.Reload -= HandleReload;
			model_.stats.Shot -= HandleShot;
			model_.UiActionChanged -= HandleUiActionChanged;
			model_.stats.GrenadeAmmoChanged -= HandleGrenadeAmmoChanged;
			cameraManager_.StatesController.CameraModeChanged -= HandleCameraModeChanged;
			if (inputController != null)
			{
				inputController.Dispose();
			}
		}

		internal void TryStart()
		{
			if (!inputController.Started)
			{
				inputController.Start();
				Reset();
			}
		}

		internal void Reset()
		{
			inputController.Reset(model_.stats.Position, model_.stats.Rotation);
		}

		public static void InitModule(int layer)
		{
			SingletonManager.Add<MyPlayerInputModel>(layer);
			AdjustableSettings.Register<InputSettings>();
		}

		public static void InitHud()
		{
			GuiModuleHolder.Add<PlayerControlsHud>();
			if (MyPlayerInputContentMap.PlayerSettings.allowCameraChange > 0 || DataStorage.isAdmin)
			{
				GuiModuleHolder.Add<PlayerCameraControlsHud>();
			}
		}
	}
}
