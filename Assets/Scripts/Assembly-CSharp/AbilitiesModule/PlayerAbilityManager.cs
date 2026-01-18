using System;
using Combat;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using Extensions;
using HudSystem;
using MyPlayerInput;
using PlayerModule;
using PlayerModule.MyPlayer;
using UnityEngine;

namespace AbilitiesModule
{
	public class PlayerAbilityManager : Singleton
	{
		private MyPlayerStatsModel myPlayerModel_;

		private CameraManager cameraManager_;

		private CombatInteraction CombatInteraction_;

		private UnityTimerManager unityTimerManager_;

		private PlayerControlsHud playerHud_;

		private UnityTimer cooldownTimer_;

		private bool onCooldown_;

		private CurrentAbilityController controller_;

		public event Action<string[], Vector3> AbilityUsed;

		public override void Init()
		{
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerModel_);
			SingletonManager.Get<CameraManager>(out cameraManager_);
			SingletonManager.Get<CombatInteraction>(out CombatInteraction_);
			SingletonManager.Get<UnityTimerManager>(out unityTimerManager_);
		}

		public override void OnDataLoaded()
		{
			controller_ = new CurrentAbilityController();
			playerHud_ = GuiModuleHolder.Get<PlayerControlsHud>();
			playerHud_.AbilityButtonClicked += AbilityButtonClicked;
			myPlayerModel_.stats.SelectedArtikulChanged += HandleArtikulChanged;
			HandleArtikulChanged(myPlayerModel_.stats.SelectedArtikul);
		}

		private void AbilityButtonClicked()
		{
			if (!onCooldown_)
			{
				myPlayerModel_.stats.action = 9;
				onCooldown_ = true;
				cooldownTimer_ = unityTimerManager_.SetTimer(controller_.CurrentAbility.ability.cooldown);
				cooldownTimer_.Completeted += OnCooldownTimerCompleted;
				playerHud_.PlayAbilityCooldown(controller_.CurrentAbility.ability.cooldown);
				Vector3 forward = cameraManager_.Transform.forward;
				forward.Normalize();
				string[] param = new string[0];
				if (CombatInteraction_.CheckIfEnemy())
				{
					string persId = CombatInteraction_.currentPlayerStatsModel.persId;
					param = new string[1] { persId };
				}
				this.AbilityUsed.SafeInvoke(param, forward);
			}
		}

		private void UpdateAbilityButton()
		{
			playerHud_.VisibleAbilityButton = controller_.CurrentAbility != null;
		}

		private void HandleArtikulChanged(int artikulId)
		{
			controller_.SetAbility(artikulId);
			UpdateAbilityButton();
		}

		private void OnCooldownTimerCompleted()
		{
			onCooldown_ = false;
			cooldownTimer_.Completeted -= OnCooldownTimerCompleted;
		}

		public void AbilityStart(ProjectileModel projectileModel)
		{
			controller_.AbilityStart(projectileModel);
		}

		public void AbilityContactHappened()
		{
			controller_.AbilityContactHappened();
		}

		public void LoadFx(GameObject instance)
		{
			controller_.LoadFx(instance);
		}

		public override void Dispose()
		{
			playerHud_.AbilityButtonClicked -= AbilityButtonClicked;
			myPlayerModel_.stats.SelectedArtikulChanged -= HandleArtikulChanged;
			controller_.Dispose();
		}
	}
}
