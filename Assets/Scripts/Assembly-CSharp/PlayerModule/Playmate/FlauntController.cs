using CraftyEngine.Infrastructure;
using CraftyEngine.States;
using UnityEngine;

namespace PlayerModule.Playmate
{
	public class FlauntController : ArtikulHandler
	{
		private float flauntDuration_;

		private float desidionMoment_;

		private float idleMoment_;

		private StateMachine stateMachine_;

		private UnityEvent unityEvent_;

		private PlayerAnimationsController animationsController_;

		private bool disposed_;

		private int flauntIndex_;

		private string[] flauntStates_;

		public FlauntController(PlayerStatsModel model, PlayerAnimationsController animationsController)
		{
			animationsController_ = animationsController;
			SetModel(model);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			unityEvent_.Subscribe(UnityEventType.Update, Update);
			State state = new State("desidion");
			State state2 = new State("idle");
			State state3 = new State("flaunt");
			stateMachine_ = new StateMachine(state, string.Format("{0} ({1}) {2}", model.nickname, model.persId, "Flaunt"), false);
			state.AddTransaction(state3, () => flauntStates_ != null && base.Model.IsCocky && base.Model.action == 0);
			state3.AddTransaction(state2, () => Time.time >= idleMoment_);
			state3.Entered += HandleFlauntStateEntered;
			state2.AddTransaction(state, () => Time.time >= desidionMoment_);
			state2.Entered += HandleIdleStateEntered;
		}

		private void HandleIdleStateEntered()
		{
			desidionMoment_ = Time.time + 2f;
			animationsController_.Play("menu");
		}

		private void HandleFlauntStateEntered()
		{
			idleMoment_ = Time.time + flauntDuration_;
			flauntIndex_++;
			if (flauntIndex_ >= flauntStates_.Length)
			{
				flauntIndex_ = 0;
			}
			string tag = flauntStates_[flauntIndex_];
			animationsController_.Play(tag);
		}

		public override void Dispose()
		{
			if (!disposed_)
			{
				base.Dispose();
				stateMachine_.Dispose();
				unityEvent_.Unsubscribe(UnityEventType.Update, Update);
				disposed_ = true;
			}
		}

		protected override void UpdateArtikul()
		{
			HandleDurationUpdated();
			selectedArtikul.playmateAnimations.Updated += HandleDurationUpdated;
		}

		private void HandleDurationUpdated()
		{
			selectedArtikul.playmateAnimations.Updated -= HandleDurationUpdated;
			flauntDuration_ = selectedArtikul.playmateAnimations.flauntDuration;
			flauntStates_ = selectedArtikul.playmateAnimations.flauntStates;
		}

		private void Update()
		{
			stateMachine_.Update();
		}
	}
}
