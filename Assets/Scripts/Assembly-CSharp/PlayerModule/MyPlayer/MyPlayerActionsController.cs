using System;
using Animations;
using CraftyEngine.Infrastructure;
using CraftyEngine.States;
using Extensions;

namespace PlayerModule.MyPlayer
{
	public class MyPlayerActionsController : ArtikulHandler
	{
		private TempState attackState_;

		private TempState cooldownState_;

		private TempState digState_;

		private TempState reloadState_;

		private State idleState_;

		private State deadState_;

		private State desidionState_;

		private AmmoController ammoController_;

		private MyPlayerStatsModel myModel_;

		private UnityEvent unityEvent_;

		public StateMachine StateMachine { get; private set; }

		public event Action ActionChanged;

		public MyPlayerActionsController(MyPlayerStatsModel model)
		{
			ammoController_ = new AmmoController(model.stats, false);
			myModel_ = model;
			Setup();
			SetModel(model.stats);
		}

		public override void Dispose()
		{
			base.Dispose();
			StateMachine.Dispose();
			unityEvent_.Unsubscribe(UnityEventType.Update, StateMachine.Update);
		}

		public void RefreshArticul()
		{
			GetArtikul();
		}

		protected override void UpdateArtikul()
		{
			ArtikulsAnimations artikulsAnimations = ((!myModel_.myVisibility.Visible) ? selectedArtikul.playmateAnimations : selectedArtikul.myPlayerAnimations);
			artikulsAnimations.Updated -= UpdateArtikul;
			if (artikulsAnimations.attackDuration == 0f)
			{
				artikulsAnimations.Updated += UpdateArtikul;
				digState_.duration = 10f;
				attackState_.duration = 10f;
				cooldownState_.duration = 10f;
				reloadState_.duration = 10f;
			}
			else
			{
				digState_.duration = artikulsAnimations.attackDuration;
				attackState_.duration = artikulsAnimations.attackDuration;
				cooldownState_.duration = selectedArtikul.cooldown - attackState_.duration;
				reloadState_.duration = selectedArtikul.reload_time;
			}
			StateMachine.GoTo(desidionState_);
		}

		private TempState AddTempState(string name, int id)
		{
			TempState tempState = new TempState(name, id);
			tempState.Entered += delegate
			{
				ReportActionChanged(id);
			};
			return tempState;
		}

		private void ReportActionChanged(int id)
		{
			base.Model.action = id;
			if (id != 5)
			{
				base.Model.networkAction = id;
			}
			this.ActionChanged.SafeInvoke();
		}

		private void Setup()
		{
			idleState_ = new State("Idle");
			deadState_ = new State("Dead");
			desidionState_ = new State("Desidion");
			digState_ = AddTempState("Digging", 2);
			attackState_ = AddTempState("Attack", 1);
			reloadState_ = AddTempState("Reloading", 4);
			cooldownState_ = AddTempState("Cooldown", 5);
			attackState_.AddTransaction(cooldownState_);
			digState_.AddTransaction(cooldownState_);
			cooldownState_.AddTransaction(desidionState_);
			reloadState_.AddTransaction(desidionState_);
			desidionState_.AddTransaction(deadState_, () => base.Model.IsDead);
			desidionState_.AddTransaction(reloadState_, () => ammoController_.OutOfAmmo);
			desidionState_.AddTransaction(reloadState_, () => myModel_.stats.Reloading);
			desidionState_.AddTransaction(attackState_, () => myModel_.UiAction == 1);
			desidionState_.AddTransaction(digState_, () => myModel_.UiAction == 2);
			desidionState_.AddTransaction(idleState_, () => myModel_.UiAction != 1);
			idleState_.AddTransaction(reloadState_, () => ammoController_.OutOfAmmo);
			idleState_.AddTransaction(reloadState_, () => myModel_.stats.Reloading);
			idleState_.AddTransaction(attackState_, () => myModel_.UiAction == 1);
			idleState_.AddTransaction(digState_, () => myModel_.UiAction == 2);
			idleState_.Entered += delegate
			{
				ReportActionChanged(0);
			};
			deadState_.Entered += delegate
			{
				ReportActionChanged(0);
			};
			deadState_.AddTransaction(desidionState_, () => !base.Model.IsDead);
			StateMachine = new StateMachine(desidionState_, "MyPlayerActions");
			SingletonManager.Get<UnityEvent>(out unityEvent_, 1);
			unityEvent_.Subscribe(UnityEventType.Update, StateMachine.Update);
			attackState_.Entered += HandleAttackEntered;
			digState_.Entered += HandleAttackEntered;
			reloadState_.Entered += delegate
			{
				myModel_.stats.Aiming = false;
				myModel_.stats.Reloading = true;
			};
			reloadState_.Exited += delegate
			{
				myModel_.stats.Reloading = false;
				ammoController_.Reload();
				myModel_.stats.Ammo = ammoController_.ShotsLeft;
			};
		}

		private void HandleAttackEntered()
		{
			ammoController_.TakeShot();
			myModel_.stats.Ammo = ammoController_.ShotsLeft;
		}
	}
}
