using System;
using Combat;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using CraftyVoxelEngine;
using HudSystem;
using InventoryModule;
using MyPlayerInput;
using PlayerCameraModule;
using PlayerModule.MyPlayer;
using ProjectilesModule;
using UnityEngine;
using WeaponSightsModule;

namespace InputObserverModule
{
	public class InputObserver : Singleton
	{
		private bool action_;

		private AimScopeHud aimScopeHud_;

		private InputInstance attackTouch_;

		private AutoAimingController autoAimingController_;

		private float beginAutoShootMoment_;

		private PlayerCameraManager cameraManager_;

		private CombatInteraction combatInteraction_;

		private CrosshairHud crosshairHud_;

		private InputManager inputManager_;

		private KeyboardInputManager keyboardInputManager_;

		private bool instrument_;

		private InventoryModel inventoryModel_;

		private bool isCombatAction_;

		private MyPlayerModuleController playerController_;

		private PlayerControlsHud playerHud_;

		private MyPlayerStatsModel playerModel_;

		private bool ranged_;

		private UnityEvent unityEvent_;

		private PersistanceUserSettings userSettings_;

		private bool voxel_;

		private VoxelEngine voxelEngine_;

		private VoxelInteraction voxelInteraction_;

		private VoxelInteractionModel voxelInteractionModel_;

		private WearController wearController_;

		private ArtikulsEntries artikul_;

		private bool quickGrenadeAction_;

		private float quickGrenadeAllowMoment_;

		private ProjectileInventoryController projectileInventoryController_;

		private UnityTimerManager unityTimerManager_;

		private ProjectilesManager projectilesManager_;

		private WeaponScatterController weaponScatterController_;

		private bool IsEnemy
		{
			get
			{
				return combatInteraction_.CheckIfEnemy();
			}
		}

		private bool CombatActionAllowed
		{
			get
			{
				return artikul_.ProjectileEntry == null || (playerModel_.stats.GrenadeAmmo > 0 && Time.time > quickGrenadeAllowMoment_);
			}
		}

		public override void Dispose()
		{
			playerModel_.UiAction = 0;
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			voxelInteractionModel_.inputEnabled = true;
			playerModel_.stats.SelectedArtikulChanged -= HandleSelectedArtikulChanged;
			playerModel_.stats.AimingChanged -= HandleAimingChanged;
			if (playerHud_ != null)
			{
				playerHud_.GrenadeButtonClicked -= HandleGrenadeButtonClicked;
				playerHud_.actionButton.click.Pressed -= StartNormalAction;
				playerHud_.actionButton.click.ClickFailed -= StartVoxelAction;
				playerHud_.actionButton.click.Clicked -= TryBuildVoxel;
				playerHud_.actionButton.click.Released -= EndAction;
				playerHud_.actionAltButton.click.Pressed -= StartNormalAction;
				playerHud_.actionAltButton.click.ClickFailed -= StartVoxelAction;
				playerHud_.actionAltButton.click.Clicked -= TryBuildVoxel;
				playerHud_.actionAltButton.click.Released -= EndAction;
			}
			inputManager_.PointerDown -= HandlePointerDown;
			playerController_.ProjectileHitHappened -= HandlePlayerProjectileHitHappened;
			playerController_.ContactHappened -= HandleContactHappened;
			voxelInteraction_.controller.VoxelDestroyed -= HandleVoxelDestroyed;
			projectilesManager_.ProjectileShotHappened -= HandleProjectileShotHappened;
			projectilesManager_.ProjectileHitHappened -= HandleProjectileHitHappened;
			crosshairHud_.Interactive(LookingAt.Nothing, true);
			voxelInteraction_.model.silentLogic = false;
			keyboardInputManager_.ButtonReleased -= HandleButtonReleased;
			keyboardInputManager_.ButtonPressed -= HandleButtonPressed;
			autoAimingController_.Dispose();
			weaponScatterController_.Dispose();
		}

		public override void Init()
		{
			SingletonManager.Get<KeyboardInputManager>(out keyboardInputManager_);
			SingletonManager.Get<VoxelInteraction>(out voxelInteraction_);
			SingletonManager.Get<VoxelInteractionModel>(out voxelInteractionModel_);
			SingletonManager.Get<CombatInteraction>(out combatInteraction_);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			SingletonManager.Get<MyPlayerStatsModel>(out playerModel_);
			SingletonManager.Get<MyPlayerModuleController>(out playerController_);
			SingletonManager.Get<InputManager>(out inputManager_);
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			SingletonManager.Get<InventoryModel>(out inventoryModel_);
			SingletonManager.Get<WearController>(out wearController_);
			SingletonManager.Get<PlayerCameraManager>(out cameraManager_);
			SingletonManager.Get<ProjectileInventoryController>(out projectileInventoryController_);
			SingletonManager.Get<UnityTimerManager>(out unityTimerManager_);
			SingletonManager.Get<ProjectilesManager>(out projectilesManager_);
			PersistanceManager.Get<PersistanceUserSettings>(out userSettings_);
			action_ = false;
			isCombatAction_ = false;
			voxelInteractionModel_.inputEnabled = false;
			unityEvent_.Subscribe(UnityEventType.Update, Update);
			playerModel_.stats.AimingChanged += HandleAimingChanged;
			inputManager_.PointerDown += HandlePointerDown;
			voxelInteraction_.controller.VoxelDestroyed += HandleVoxelDestroyed;
			projectilesManager_.ProjectileShotHappened += HandleProjectileShotHappened;
			projectilesManager_.ProjectileHitHappened += HandleProjectileHitHappened;
			playerController_.ProjectileHitHappened += HandlePlayerProjectileHitHappened;
			autoAimingController_ = new AutoAimingController();
			weaponScatterController_ = new WeaponScatterController();
			keyboardInputManager_.ButtonReleased += HandleButtonReleased;
			keyboardInputManager_.ButtonPressed += HandleButtonPressed;
		}

		private void HandleButtonReleased(object sender, InputEventArgs e)
		{
			if (e.keyCode == KeyCode.V)
			{
				EndAction();
			}
		}

		private void HandleButtonPressed(object sender, InputEventArgs e)
		{
			if (e.keyCode == KeyCode.V)
			{
				StartAction();
			}
		}

		public override void OnDataLoaded()
		{
			playerHud_ = GuiModuleHolder.Get<PlayerControlsHud>();
			crosshairHud_ = GuiModuleHolder.Get<CrosshairHud>();
			aimScopeHud_ = GuiModuleHolder.Get<AimScopeHud>();
			playerHud_.GrenadeButtonClicked += HandleGrenadeButtonClicked;
			playerHud_.actionButton.click.Pressed += StartNormalAction;
			playerHud_.actionButton.click.ClickFailed += StartVoxelAction;
			playerHud_.actionButton.click.Clicked += TryBuildVoxel;
			playerHud_.actionButton.click.Released += EndAction;
			playerHud_.actionAltButton.click.Pressed += StartNormalAction;
			playerHud_.actionAltButton.click.ClickFailed += StartVoxelAction;
			playerHud_.actionAltButton.click.Clicked += TryBuildVoxel;
			playerHud_.actionAltButton.click.Released += EndAction;
			playerController_.ContactHappened += HandleContactHappened;
			playerModel_.stats.SelectedArtikulChanged += HandleSelectedArtikulChanged;
			HandleSelectedArtikulChanged(playerModel_.stats.SelectedArtikul);
		}

		public void Update()
		{
			autoAimingController_.Update();
			weaponScatterController_.Update();
			combatInteraction_.UpdateRaycasts();
			bool isEnemy = IsEnemy;
			crosshairHud_.Interactive((!isEnemy) ? LookingAt.Voxel : LookingAt.Enemy);
			if (action_)
			{
				if (isCombatAction_)
				{
					if (!isEnemy)
					{
						combatInteraction_.StopAttack();
						isCombatAction_ = false;
						voxelInteraction_.input.ActionButtonHoldStarted();
					}
				}
				else if (isEnemy)
				{
					voxelInteraction_.input.ActionButtonHoldEnded();
					isCombatAction_ = true;
					combatInteraction_.StartAttack();
				}
			}
			float crosshairScatter = CalcWeaponScatterPixelSize(playerModel_.stats.WeaponScatter);
			crosshairHud_.SetCrosshairScatter(crosshairScatter);
			UpdateAutoshoot(isEnemy);
		}

		private void EndAction(ActionButtonHierarchy instance)
		{
			EndAction();
		}

		private void EndAction()
		{
			attackTouch_ = null;
			action_ = false;
			playerModel_.UiAction = 0;
			combatInteraction_.StopAttack();
			voxelInteraction_.input.ActionButtonHoldEnded();
		}

		private void HandleAimingChanged(bool aiming)
		{
			UpdateCrosshairIcon(artikul_);
			UpdateAimScopeIcon(artikul_);
			playerHud_.VisibleActionAltButton = aiming;
			if (aiming)
			{
				cameraManager_.StatesController.SwitchAimingState((artikul_.WeaponSight == null) ? 1f : artikul_.WeaponSight.aim_fov);
				cameraManager_.InputModel.sensitivityMultiplier = ((artikul_.WeaponSight == null || !(artikul_.WeaponSight.aim_sensitivity_ratio > 0f)) ? MyPlayerInputContentMap.PlayerSettings.aimingSensitivityMultiplier : artikul_.WeaponSight.aim_sensitivity_ratio);
				return;
			}
			if (cameraManager_.StatesController.Mode == CameraMode.Aiming)
			{
				cameraManager_.StatesController.SwitchToPersonMode(true);
			}
			cameraManager_.InputModel.sensitivityMultiplier = 1f;
		}

		private void HandleClicked(InputInstance instance)
		{
			Unsibscribe(instance);
			if (!instance.IsUI && !instance.IsIgnoredUI)
			{
				if (voxel_)
				{
					voxelInteraction_.input.HandleClick();
				}
				else if (attackTouch_ == null)
				{
					attackTouch_ = instance;
					StartAction();
				}
			}
		}

		private void HandleContactHappened()
		{
			if (isCombatAction_ && !ranged_ && combatInteraction_.currentPlayerStatsModel != null)
			{
				combatInteraction_.Hit(combatInteraction_.currentPlayerStatsModel.persId);
			}
			else if (voxelInteraction_.logic.CanDig(false) && (action_ || instrument_))
			{
				voxelInteraction_.controller.HitVoxel();
			}
			if (attackTouch_ != null && !attackTouch_.Pressed)
			{
				EndAction();
			}
		}

		private void HandleHold(InputInstance instance)
		{
			Unsibscribe(instance);
			if (!instance.IsUI && !instance.IsIgnoredUI && attackTouch_ == null)
			{
				instance.ClickUtility.HoldEnded += HandleReleased;
				attackTouch_ = instance;
				StartAction();
			}
		}

		private void HandlePointerDown(object sender, InputEventArgs e)
		{
			InputInstance touch = e.touch;
			if (!touch.IsNguiClick && touch.type == MobileInputType.Rotate && (!ranged_ || voxel_))
			{
				touch.ClickUtility.Clicked += HandleClicked;
				touch.ClickUtility.HoldStartedByDuration += HandleHold;
				touch.ClickUtility.Released += Unsibscribe;
			}
		}

		private void HandleReleased(InputInstance instance)
		{
			Unsibscribe(instance);
			EndAction();
		}

		private void HandleSelectedArtikulChanged(int id)
		{
			artikul_ = InventoryModuleController.GetArticul(id);
			voxel_ = artikul_.type_id == 1;
			if (artikul_.type_id != 3 && artikul_.type_id != 4)
			{
				instrument_ = false;
				artikul_ = InventoryContentMap.CraftSettings.handArtikul;
			}
			else
			{
				instrument_ = true;
			}
			ranged_ = artikul_.ranged;
			voxelInteraction_.model.silentLogic = artikul_.ranged;
			voxelInteractionModel_.selectedItemDamageWrongType = artikul_.block_damage_common;
			voxelInteractionModel_.selectedItemDamageCorrectType = artikul_.block_damage;
			voxelInteractionModel_.selectedItemDigRate = artikul_.cooldown;
			playerHud_.SetActionButton((artikul_.weaponType != null && !string.IsNullOrEmpty(artikul_.weaponType.icon)) ? artikul_.weaponType.icon : InventoryContentMap.CraftSettings.handArtikul.weaponType.icon);
			UpdateCrosshairIcon(artikul_);
			UpdateAimScopeIcon(artikul_);
			playerHud_.VisibleAimButton = artikul_.WeaponSight != null && artikul_.WeaponSight.aim_enable;
			playerHud_.VisibleReloadButton = artikul_.reload_shots > 0;
			playerHud_.SetReloadButton(artikul_.reload_shots);
			playerModel_.stats.Aiming = false;
			if (quickGrenadeAction_)
			{
				quickGrenadeAction_ = false;
				playerModel_.UiAction = 0;
				action_ = false;
				isCombatAction_ = false;
			}
		}

		private void HandleVoxelDestroyed(VoxelEventArgs args)
		{
			VoxelData data;
			if (voxelEngine_.Settings.GetData(args.PreviousValue, out data))
			{
				wearController_.AddDigWear(inventoryModel_.SelectedSlot, data.Durability, data.DurabilityTypeID);
			}
			wearController_.UpdateSelectedSlotWear();
		}

		private void StartAction()
		{
			if (CombatActionAllowed)
			{
				action_ = true;
				if (IsEnemy)
				{
					isCombatAction_ = true;
					playerModel_.UiAction = 1;
					combatInteraction_.StartAttack();
				}
				else
				{
					playerModel_.UiAction = 2;
					isCombatAction_ = false;
				}
				if (artikul_.ProjectileEntry != null)
				{
					quickGrenadeAllowMoment_ = Time.time + artikul_.cooldown;
					playerHud_.PlayGrenadeCooldown(artikul_.cooldown);
				}
			}
		}

		private void StartNormalAction(ActionButtonHierarchy instance)
		{
			if (!voxel_)
			{
				StartAction();
			}
		}

		private void StartVoxelAction(ActionButtonHierarchy instance)
		{
			if (voxel_)
			{
				StartAction();
			}
		}

		private void TryBuildVoxel(ActionButtonHierarchy instance)
		{
			if (voxel_)
			{
				voxelInteraction_.input.HandleClick();
			}
		}

		private void Unsibscribe(InputInstance instance)
		{
			instance.ClickUtility.Clicked -= HandleClicked;
			instance.ClickUtility.HoldStartedByDuration -= HandleHold;
			instance.ClickUtility.HoldEnded -= HandleReleased;
			instance.ClickUtility.Released -= Unsibscribe;
		}

		private void UpdateAimScopeIcon(ArtikulsEntries artikul)
		{
			WeaponSightsEntries weaponSight = artikul.WeaponSight;
			if (weaponSight != null)
			{
				string value = ((!playerModel_.stats.Aiming) ? null : weaponSight.aim_background_icon);
				aimScopeHud_.SetScopeIcon(string.IsNullOrEmpty(value) ? null : weaponSight.GetFullAimBackgroundIconPath());
			}
		}

		private void UpdateAutoshoot(bool isEnemy)
		{
			if (userSettings_.autoShoot && CombatActionAllowed)
			{
				if (!isEnemy)
				{
					beginAutoShootMoment_ = Time.time;
				}
				if (isEnemy)
				{
					if (Time.time > beginAutoShootMoment_ + MyPlayerInputContentMap.PlayerSettings.autoShootDelay)
					{
						isCombatAction_ = true;
						playerModel_.UiAction = 1;
						beginAutoShootMoment_ = Time.time;
					}
				}
				else if (!action_)
				{
					playerModel_.UiAction = 0;
				}
			}
			else if (!action_ && !isCombatAction_)
			{
				playerModel_.UiAction = 0;
			}
		}

		private void UpdateCrosshairIcon(ArtikulsEntries artikul)
		{
			WeaponSightsEntries weaponSight = artikul.WeaponSight;
			if (weaponSight == null)
			{
				crosshairHud_.SetCrosshairLegacyIcon(artikul.ranged);
				return;
			}
			string value = ((!playerModel_.stats.Aiming) ? weaponSight.primary_crosshair_icon : weaponSight.aim_crosshair_icon);
			if (!string.IsNullOrEmpty(value))
			{
				crosshairHud_.SetCrosshairIcon((!playerModel_.stats.Aiming) ? weaponSight.GetFullPrimaryCrosshairIconPath() : weaponSight.GetFullAimCrosshairIconPath());
			}
			string value2 = ((!playerModel_.stats.Aiming) ? weaponSight.primary_crosshair_part_icon : weaponSight.aim_crosshair_part_icon);
			if (!string.IsNullOrEmpty(value2))
			{
				crosshairHud_.SetCrosshairPartIcon((!playerModel_.stats.Aiming) ? weaponSight.GetFullPrimaryCrosshairPartIconPath() : weaponSight.GetFullAimCrosshairPartIconPath());
			}
			else
			{
				crosshairHud_.SetCrosshairPartIcon(null);
			}
			crosshairHud_.SetRotationAngle(weaponSight.rotation);
		}

		private void HandleGrenadeButtonClicked()
		{
			if (playerModel_.stats.GrenadeAmmo <= 0)
			{
				return;
			}
			ArtikulsEntries artikulsEntries = projectileInventoryController_.FindProjectileArtikul();
			if (artikulsEntries != null)
			{
				ArtikulsEntries artikulsEntries2 = artikul_;
				playerModel_.stats.SelectedArtikul = artikulsEntries.id;
				if (artikulsEntries2.id != artikulsEntries.id)
				{
					UnityTimer unityTimer = unityTimerManager_.SetTimer(0.2f);
					unityTimer.Completeted += SelectQuickGrenade;
				}
				else
				{
					SelectQuickGrenade();
				}
			}
		}

		private void SelectQuickGrenade()
		{
			isCombatAction_ = true;
			playerModel_.UiAction = 1;
			quickGrenadeAction_ = true;
			quickGrenadeAllowMoment_ = Time.time + artikul_.cooldown;
			playerHud_.PlayGrenadeCooldown(artikul_.cooldown);
			UnityTimer unityTimer = unityTimerManager_.SetTimer();
			unityTimer.Completeted += SelectInventoryItem;
		}

		private void SelectInventoryItem()
		{
			if (quickGrenadeAction_)
			{
				playerModel_.UiAction = 0;
				action_ = false;
				isCombatAction_ = false;
				quickGrenadeAction_ = false;
				playerModel_.stats.SelectedArtikul = inventoryModel_.SelectedSlot.ArtikulId;
			}
		}

		private void HandleProjectileShotHappened(Vector3 direction, Vector3[] trajectory)
		{
			int? artikulId = ((inventoryModel_.SelectedSlot.ArtikulId == playerModel_.stats.SelectedArtikul) ? null : new int?(playerModel_.stats.SelectedArtikul));
			combatInteraction_.ProjectileShot(artikulId, direction, trajectory);
		}

		private void HandleProjectileHitHappened(int clientProjectileId, Vector3 point, float radius)
		{
			combatInteraction_.ProjectileHit(clientProjectileId, point, radius);
		}

		private void HandlePlayerProjectileHitHappened(string targetPersId)
		{
			string text = targetPersId;
			if (string.IsNullOrEmpty(targetPersId) && combatInteraction_.currentPlayerStatsModel != null)
			{
				text = combatInteraction_.currentPlayerStatsModel.persId;
			}
			if (!string.IsNullOrEmpty(text))
			{
				combatInteraction_.Hit(text);
			}
		}

		private float CalcWeaponScatterPixelSize(float scatterAngle)
		{
			if (cameraManager_.Transform == null)
			{
				return 0f;
			}
			Vector3 position = cameraManager_.Transform.position + cameraManager_.Transform.forward;
			position += cameraManager_.Transform.right * Mathf.Tan(scatterAngle / 180f * (float)System.Math.PI);
			return cameraManager_.Camera.UnityCamera.WorldToScreenPoint(position).x - (float)Screen.width / 2f;
		}
	}
}
