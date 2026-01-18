using System;
using Animations;
using CraftyEngine.Infrastructure;
using UnityEngine;

namespace PlayerModule.Playmate
{
	public class AnimatorLayerBlendController : IDisposable
	{
		private const float DELAY_BEFORE_RELAX = 2f;

		private bool actionCommited_;

		private PlaymateJumpController jump_;

		private float relaxMoment_;

		private bool relaxPending_;

		private UnityEvent unityEvent_;

		private LayeredAsc Asc;

		private PlayerStatsModel model_;

		private AnimatedItemView body_;

		private bool visible_;

		public AnimatorLayerBlendController(LayeredAsc asc, PlayerStatsModel model, AnimatedItemView body)
		{
			Asc = asc;
			Asc.SetLayerWeight(1, 1f);
			if (AnimationsContentMap.AnimationSettings.allowBlendWeight || AnimationsContentMap.AnimationSettings.allowOverrideRun)
			{
				model_ = model;
				body_ = body;
				SingletonManager.Get<UnityEvent>(out unityEvent_);
				unityEvent_.Subscribe(UnityEventType.Update, Update);
				body_.AnimationsLoaded += HandleAnimationsLoaded;
				HandleAnimationsLoaded();
			}
		}

		public void Dispose()
		{
			if (jump_ != null)
			{
				jump_.Dispose();
			}
			if (unityEvent_ != null)
			{
				unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			}
		}

		public void ResetLayerWeight()
		{
			actionCommited_ = false;
		}

		public void SetVisible(bool visible)
		{
			visible_ = visible;
			ResetLayerWeight();
		}

		private void HandleAnimationsLoaded()
		{
			if (jump_ == null)
			{
				jump_ = new PlaymateJumpController(model_, Asc);
			}
			if (!AnimationsContentMap.AnimationSettings.allowBlendWeight)
			{
				Asc.SetLayerWeight(1, 1f);
			}
		}

		private void TryBlendHands()
		{
			if (Asc.Layers[1] != null)
			{
				if (actionCommited_ && model_.action == 0 && !model_.IsCocky)
				{
					actionCommited_ = false;
					relaxPending_ = true;
					relaxMoment_ = Time.time + 2f;
				}
				if (!actionCommited_ && (model_.action != 0 || model_.IsCocky))
				{
					Asc.BlendLayerWeight(1, 1f, 0.25f);
					actionCommited_ = true;
				}
				if (relaxPending_ && relaxMoment_ >= Time.time)
				{
					relaxPending_ = false;
					Asc.BlendLayerWeight(1, 0f, 1f);
				}
			}
		}

		private void Update()
		{
			if (visible_ && model_ != null && !model_.IsDummy && !(Asc.Animator == null) && AnimationsContentMap.AnimationSettings.allowBlendWeight)
			{
				TryBlendHands();
			}
		}
	}
}
