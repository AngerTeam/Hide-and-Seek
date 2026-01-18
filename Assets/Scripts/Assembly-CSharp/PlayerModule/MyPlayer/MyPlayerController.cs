using System;
using AbilitiesModule;
using Animations;
using CraftyEngine.Infrastructure;
using CraftyEngine.Sounds;
using CraftyEngine.Utils;
using CraftyVoxelEngine.FX;
using Extensions;
using HudSystem;
using InventoryModule;
using MyPlayerInput;
using PlayerModule.Playmate;
using UnityEngine;

namespace PlayerModule.MyPlayer
{
	public class MyPlayerController : PlayerController
	{
		private const int PUSH_PLAYER_FORCE_COEF = 5;

		public MyPlayerInputMobule inputMobule;

		private MyPlayerStatsModel model_;

		private MyPlayerInputController inputController_;

		private MyPlayerHandController itemController_;

		private MyPlayerInputModel inputModel_;

		private VoxelInteractionEffects voxelInteractionEffects_;

		private MyPlayerVisibleStatesController visibleStatesController_;

		private PlayerAbilityManager playerAbilityManager_;

		private bool debugButtonsAdded_;

		protected override bool ModelVisible
		{
			get
			{
				return model_.myVisibility.Visible;
			}
		}

		public event Action Fallen;

		public event Action ItemChanged;

		public MyPlayerController()
		{
			SingletonManager.Get<MyPlayerStatsModel>(out model_);
			SingletonManager.Get<MyPlayerInputModel>(out inputModel_);
			Init(model_.stats, true, true);
			base.AnimationsController = new PlayerAnimationsController(model_.stats, base.ActionsHandler, true);
			GetArtikul();
		}

		public virtual void Init()
		{
			inputMobule = new MyPlayerInputMobule();
			inputController_ = inputMobule.inputController;
			inputController_.SoundLogic.FellOnGround += HandleSoundLogicFellOnGround;
			inputController_.SoundLogic.Step += HandleSoundLogicStep;
			inputController_.PositionUpdated += HandlePositionUpdated;
			itemController_ = new MyPlayerHandController();
			itemController_.Switcher.ItemChanged += HandleItemChanged;
			PlayerVisualModelByCamera byCamera1St = model_.stats.visual.byCamera1St;
			byCamera1St.Updated += UpdateProjectile;
			byCamera1St.views = new AnimatedItemView[1] { itemController_.Switcher };
			UnityEvent singlton;
			SingletonManager.Get<UnityEvent>(out singlton, 1);
			singlton.Subscribe(UnityEventType.FixedUpdate, UnityFixedUpdate);
			model_.stats.SelectedArtikulChanged += delegate
			{
				GetArtikul();
			};
			model_.stats.SideChanged += base.GetArtikul;
			model_.stats.PushPlayer += PushPlayer;
			GetArtikul();
			inputController_.JumpController.FallFromCriticalHeight += HandleFall;
			inputController_.FallToRespawnZone += HandleFall;
			visibleStatesController_ = new MyPlayerVisibleStatesController(inputController_);
			SingletonManager.Get<VoxelInteractionEffects>(out voxelInteractionEffects_);
			SingletonManager.TryGet<PlayerAbilityManager>(out playerAbilityManager_);
		}

		private void PushPlayer(Vector3 direction, float force)
		{
			Vector3 pulse = PlaymatePositionManager.GetPushVector(direction, force);
			pulse /= 5f;
			inputController_.AddForcePulse(pulse);
		}

		private void UpdateProjectile()
		{
			SetProjectile(model_.stats.visual.byCamera1St);
		}

		private void HandlePositionUpdated(Vector3 position, Vector3 rotation)
		{
			model_.stats.SetPosition(position, rotation);
		}

		private void HandleSoundLogicStep(int soundId)
		{
			model_.stats.visual.stepSoundId = soundId;
			if (model_.stats.visual.byCamera1St.enabled || MyPlayerInputContentMap.PlayerSettings.useAnimationEvent == 0)
			{
				if (soundId == 0)
				{
					soundId = MyPlayerInputContentMap.PlayerSettings.defaultStepSoundId;
				}
				SoundProvider.PlayGroupSound2D(soundId, 0.6f);
			}
		}

		private void HandleSoundLogicFellOnGround(float volume)
		{
			SoundProvider.PlayGroupSound2D(13, volume);
		}

		private void HandleItemChanged()
		{
			PlayerVisualModelByCamera byCamera1St = model_.stats.visual.byCamera1St;
			byCamera1St.views = new AnimatedItemView[1] { itemController_.Switcher };
			byCamera1St.ProjectileAsc = itemController_.Switcher;
			byCamera1St.ProjectileArticulView = itemController_.Switcher.ArticulView;
			byCamera1St.ReportUpdated();
			this.ItemChanged.SafeInvoke();
		}

		public void AddUi()
		{
			if (DataStorage.isAdmin && !debugButtonsAdded_)
			{
				debugButtonsAdded_ = true;
				DebugButtonsManager singlton;
				SingletonManager.Get<DebugButtonsManager>(out singlton);
				singlton.Add(Localisations.Get("UI_LeftSideMenu_Flight"), KeyCode.F, delegate
				{
					inputModel_.flight = !inputModel_.flight;
				});
				singlton.Add(Localisations.Get("UI_LeftSideMenu_NoClip"), KeyCode.N, delegate
				{
					inputModel_.clipping = !inputModel_.clipping;
				});
			}
		}

		public override void Dispose()
		{
			base.Dispose();
			if (inputMobule != null)
			{
				inputMobule.Dispose();
				itemController_.Dispose();
				visibleStatesController_.Dispose();
				base.AnimationsController.Dispose();
			}
			this.Fallen = null;
		}

		public void ResetPosition(Vector3 position, Vector3 rotation, bool teleport = false)
		{
			if (teleport)
			{
				GuiModuleHolder.Get<MyPlayerWhiteBlinkController>().BlinkWhite();
			}
			model_.stats.SetPosition(position, rotation, false);
			if (inputMobule != null)
			{
				inputMobule.Reset();
			}
		}

		public void SetVisible(bool value)
		{
			itemController_.Switcher.ItemContainer.SetActive(value);
			if (value)
			{
				itemController_.UpdateHandItem(selectedArtikul.id);
			}
		}

		private void HandleFall(Vector3 position, Vector3 rotation)
		{
			model_.stats.SetPosition(position, rotation);
			this.Fallen.SafeInvoke();
		}

		protected virtual ArtikulsEntries GetSelectedArtikul()
		{
			if (InventoryContentMap.Artikuls.TryGetValue(base.Model.SelectedArtikul, out selectedArtikul))
			{
				return selectedArtikul;
			}
			return InventoryContentMap.CraftSettings.handArtikul;
		}

		protected override void UpdateArtikul()
		{
			selectedArtikul = GetSelectedArtikul();
			if (voxelInteractionEffects_ != null)
			{
				voxelInteractionEffects_.IsVoxelInHand = selectedArtikul.voxel_id != 0;
			}
			if (itemController_ != null)
			{
				itemController_.Switcher.selectedArtikul = selectedArtikul;
				itemController_.UpdateHandItem(selectedArtikul.id);
			}
		}

		private void UnityFixedUpdate()
		{
			itemController_.Shaker.Update(inputModel_.moveEnabled, inputController_.distance);
			if (model_.stats.allowArtikulChange && selectedArtikul != null)
			{
				float num = ((!model_.stats.Aiming && model_.stats.action != 1 && model_.stats.action != 2) ? 0f : selectedArtikul.slowdown_factor_impact);
				float num2 = ((!model_.stats.Aiming) ? selectedArtikul.slowdown_factor : selectedArtikul.slowdown_aim_factor);
				inputModel_.speedRatio = 0f - (num2 + num);
			}
			else
			{
				inputModel_.speedRatio = 0f;
			}
			inputModel_.speedBoost = model_.speedBoost;
		}

		public virtual void EnableInput(bool value)
		{
			inputModel_.EnabledByPlayerState = value;
			if (value)
			{
				inputMobule.TryStart();
			}
		}

		protected override void AbilityUseStart(ProjectileModel projectileModel)
		{
			if (playerAbilityManager_ != null)
			{
				playerAbilityManager_.AbilityStart(projectileModel);
			}
		}

		protected override void AbilityUseContact()
		{
			if (playerAbilityManager_ != null)
			{
				playerAbilityManager_.AbilityContactHappened();
			}
		}
	}
}
