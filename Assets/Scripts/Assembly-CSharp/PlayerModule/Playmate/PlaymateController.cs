using System;
using AbilitiesModule;
using Extensions;
using UnityEngine;

namespace PlayerModule.Playmate
{
	public class PlaymateController : PlayerController
	{
		public bool prebakeCorpse;

		private BodyController bodyController_;

		private PlayerCorpseView corpseView_;

		private PlayerHurtEffectView hurtEffectView_;

		private PlayerNicknameAndHealthView nicknameAndHealth_;

		private FlauntController flauntController_;

		private PlayerBodyInterpolateView interpolate_;

		private IPlaymatePositionController playmatePositionController_;

		private CurrentAbilityController currentAbilityController_;

		private GameObject prebakedCorpse_;

		public event Action BodyViewUpdated;

		public PlaymateController(PlayerStatsModel model, bool permanent, bool myPlayer)
		{
			bodyController_ = new BodyController(model);
			Init(model, permanent, myPlayer);
			base.AnimationsController = new PlayerAnimationsController(model, base.ActionsHandler, false);
			bodyController_.Updated += HandleBodyViewUpdated;
			corpseView_ = new PlayerCorpseView();
			PlaymatePositionManager playmatePositionManager = SingletonManager.Get<PlaymatePositionManager>();
			playmatePositionController_ = playmatePositionManager.GetCurrentController();
			interpolate_ = new PlayerBodyInterpolateView(model, playmatePositionController_);
			nicknameAndHealth_ = new PlayerNicknameAndHealthView(model);
			hurtEffectView_ = new PlayerHurtEffectView(model.visual);
			base.Model.HealthChanged += HandleHealthUpdated;
			base.Model.PushPlayer += HandlePushPlayer;
			base.Model.BlinkRed += HandleBlinkRed;
			base.Model.PositionUpdated += HandlePositionUpdated;
			base.Model.visibility.VisibleChanged += HandleVisibleChanged;
			base.Model.Died += HandleDied;
			base.Model.visual.byCamera3Rd.Updated += UpdateProjectile;
			currentAbilityController_ = new CurrentAbilityController();
			GetArtikul();
			flauntController_ = new FlauntController(model, base.AnimationsController);
		}

		protected override void UpdateArtikul()
		{
			currentAbilityController_.SetAbility(selectedArtikul);
		}

		public void StartAbility()
		{
			base.Model.action = 9;
		}

		private void HandleBlinkRed()
		{
			hurtEffectView_.BlinkRed();
		}

		private void HandlePushPlayer(Vector3 direction, float pushForce)
		{
			if (!base.Model.IsMyPlayer)
			{
				playmatePositionController_.PushOnHit(direction, pushForce);
			}
		}

		public void AllowInterpolate(bool value)
		{
			if (interpolate_.enabled != value)
			{
				if (interpolate_.enabled)
				{
					interpolate_.Stop();
				}
				interpolate_.enabled = value;
			}
		}

		public override void Dispose()
		{
			base.Dispose();
			bodyController_.Dispose();
			hurtEffectView_.Dispose();
			interpolate_.Dispose();
			nicknameAndHealth_.Dispose();
			playmatePositionController_.Dispose();
			base.AnimationsController.Dispose();
			base.Model.HealthChanged -= HandleHealthUpdated;
			base.Model.PushPlayer -= HandlePushPlayer;
			base.Model.BlinkRed -= HandleBlinkRed;
			base.Model.PositionUpdated -= HandlePositionUpdated;
			base.Model.Died -= HandleDied;
			base.Model.visibility.VisibleChanged -= HandleVisibleChanged;
			base.Model.visual.byCamera3Rd.Updated -= UpdateProjectile;
			flauntController_.Dispose();
		}

		private void UpdateProjectile()
		{
			SetProjectile(base.Model.visual.byCamera3Rd);
		}

		public void LoadBody()
		{
			bodyController_.Load();
		}

		public void SpawnCorpse()
		{
			if (base.Model.visibility.ByGameLogic && base.Model.visual.GameObject != null && bodyController_.CurrentType != 8)
			{
				if (prebakedCorpse_ == null && !string.IsNullOrEmpty(base.Model.AttackerId))
				{
					GameObject clone = corpseView_.Spawn(base.Model.visual.GameObject);
					Vector3? from = null;
					PlayerModelsHolder playerModelsHolder = SingletonManager.Get<PlayerModelsHolder>();
					PlayerStatsModel value;
					if (playerModelsHolder.Models.TryGetValue(base.Model.AttackerId, out value))
					{
						from = value.Position;
					}
					corpseView_.Play(clone, bodyController_.BodyView.corpseAnimationRequired, from);
				}
				else
				{
					corpseView_.Play(prebakedCorpse_);
					prebakedCorpse_ = null;
				}
			}
			interpolate_.Reset();
		}

		private void HandleBodyViewUpdated()
		{
			PlayerVisualModel visual = base.Model.visual;
			if (CompileConstants.EDITOR)
			{
				ModelView modelView = visual.GameObject.AddComponent<ModelView>();
				modelView.model = base.Model;
			}
			playmatePositionController_.SetTransform(visual.Transform);
			interpolate_.UpdateGameObject();
			nicknameAndHealth_.SetAnchor(visual.Transform, visual.NicknameAnchorHeight);
			this.BodyViewUpdated.SafeInvoke();
			base.ActionsHandler.Update(true);
			currentAbilityController_.LoadFx();
			if (prebakeCorpse)
			{
				prebakedCorpse_ = corpseView_.Spawn(visual.Transform.gameObject);
				prebakedCorpse_.gameObject.SetActive(false);
			}
		}

		private void HandleDied()
		{
			if (!base.Model.IsMyPlayer)
			{
				base.Model.visibility.ByServerPosition = false;
			}
		}

		private void HandleHealthUpdated(int previous, int current, string persId)
		{
			if (previous > current && base.Model.IsMyPlayer)
			{
				hurtEffectView_.PlayHurtSound(base.Model.Position, persId, base.Model.IsDead);
			}
		}

		private void HandlePositionUpdated(bool interpolate)
		{
			AllowInterpolate(base.Model.visibility.Visible && interpolate);
			interpolate_.UpdateStatus(base.Model.Position, base.Model.Rotation);
			base.Model.visual.attacking = base.Model.action == 1;
			base.Model.visual.itemRotation = base.Model.Rotation;
		}

		private void HandleVisibleChanged()
		{
			base.Model.visual.byCamera3Rd.enabled = base.Model.visibility.Visible;
			if (base.Model.visibility.Visible)
			{
				HandlePositionUpdated(false);
			}
		}

		protected override void AbilityUseStart(ProjectileModel projectileModel)
		{
			currentAbilityController_.AbilityStart(projectileModel);
		}

		protected override void AbilityUseContact()
		{
			currentAbilityController_.AbilityContactHappened();
		}
	}
}
