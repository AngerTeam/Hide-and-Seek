using Animations;
using CraftyEngine.Infrastructure;
using UnityEngine;

namespace PlayerModule
{
	public class PlayerAnimationsController : ArtikulHandler
	{
		private ActionHandler handler_;

		private PlayerVisualModelByCamera current_;

		private UnityEvent unityEvent_;

		private bool isMyPlayer_;

		public PlayerAnimationsController(PlayerStatsModel model, ActionHandler handler, bool isMyPlayer)
		{
			isMyPlayer_ = isMyPlayer;
			SetModel(model);
			handler_ = handler;
			handler.ActionChanged += HandleActionChanged;
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			unityEvent_.Subscribe(UnityEventType.Update, Update);
		}

		private void Update()
		{
			if (current_ != null && current_.views != null && !string.IsNullOrEmpty(current_.pendingAnimation))
			{
				Play(transitionDuration: (!(current_.pendingAnimation == "idle")) ? 0.1f : 0.5f, tag: current_.pendingAnimation);
				current_.pendingAnimation = null;
			}
		}

		private void HandleActionChanged(int action)
		{
			if (base.Model.resultVisibility.Visible && !base.Model.IsDummy)
			{
				ArtikulsAnimations artikulsAnimations = ((!isMyPlayer_) ? selectedArtikul.playmateAnimations : selectedArtikul.myPlayerAnimations);
				string text = null;
				float? num = null;
				float? transitionDuration = null;
				switch (action)
				{
				case 2:
					text = "dig";
					num = artikulsAnimations.attackDuration;
					handler_.cooldownMoment = Time.time + num.Value;
					handler_.contactMoment = Time.time + artikulsAnimations.contactMoment;
					transitionDuration = 0f;
					break;
				case 1:
					text = "attack";
					num = artikulsAnimations.attackDuration;
					handler_.cooldownMoment = Time.time + num.Value;
					handler_.contactMoment = Time.time + artikulsAnimations.contactMoment;
					transitionDuration = 0f;
					break;
				case 9:
					text = "attack";
					num = artikulsAnimations.attackDuration;
					handler_.cooldownMoment = Time.time + num.Value;
					handler_.contactMoment = Time.time + artikulsAnimations.contactMoment;
					transitionDuration = 0f;
					break;
				case 4:
					text = "reload";
					num = selectedArtikul.reload_time;
					break;
				case 5:
					text = "cooldown";
					num = selectedArtikul.cooldown - artikulsAnimations.attackDuration;
					handler_.attackMoment = Time.time + num.Value;
					break;
				case 0:
					num = artikulsAnimations.idleDuration;
					text = "idle";
					break;
				}
				if (text != null && num.HasValue && num.HasValue && num.Value > 0f)
				{
					Play(text, num.Value, transitionDuration);
				}
			}
		}

		public override void Dispose()
		{
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			handler_.ActionChanged -= HandleActionChanged;
		}

		public void Play(string tag, float? duration = null, float? transitionDuration = null)
		{
			current_ = ((!isMyPlayer_) ? base.Model.visual.byCamera3Rd : base.Model.visual.byCamera1St);
			if (current_ == null || current_.views == null || !current_.enabled)
			{
				return;
			}
			for (int i = 0; i < current_.views.Length; i++)
			{
				AnimatorOverrideStatesController asc = current_.views[i].Asc;
				if (asc.allowPlay)
				{
					asc.Play(tag, duration, null, transitionDuration);
				}
				else
				{
					asc.Animator.speed = 1f;
				}
			}
		}
	}
}
