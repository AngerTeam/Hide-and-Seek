using System;
using CraftyBundles;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using UnityEngine;

namespace Animations
{
	public class PlayAnimationTask : AsynchronousTask
	{
		public int layer;

		public Animator animator;

		public float clipDuration;

		public float speed;

		public string state;

		public string debugClipName;

		public float transitionDuration;

		public bool useTimer;

		private string persId_;

		protected int stateIndex;

		public AnimatorClipData ClipData { get; private set; }

		public PlayAnimationTask(Animator animator, AnimatorClipData clipData, float speed, string persId)
		{
			ClipData = clipData;
			string text = ((!clipData.a) ? clipData.dynamicStateB : clipData.dynamicStateA);
			clipData.a = !clipData.a;
			Init(animator, text, clipData.duration, speed, persId);
		}

		private void Init(Animator animator, string state, float clipDuration, float speed, string persId)
		{
			if (animator == null)
			{
				Log.Animation("Warning: pers:{4} Animator is destroyed {0}:{3} duration:{1} speed:{2}", state, clipDuration, speed, debugClipName, persId);
			}
			else
			{
				stateIndex = -1;
				persId_ = persId;
				this.animator = animator;
				this.state = state;
				this.speed = speed;
				this.clipDuration = clipDuration;
				transitionDuration = 0.2f;
			}
		}

		public override void Start()
		{
			if (animator == null)
			{
				Log.Animation("Warning: Animator was destroyed");
				Complete();
				return;
			}
			if (useTimer)
			{
				UnityTimerManager unityTimerManager = SingletonManager.Get<UnityTimerManager>();
				UnityTimer unityTimer = unityTimerManager.SetTimer(clipDuration / speed);
				unityTimer.Completeted += HandleComplete;
			}
			UnityEvent.OnNextUpdate(Play);
		}

		private void HandleComplete()
		{
			if (animator != null && animator.isInitialized)
			{
				animator.speed = 1f;
			}
			Complete();
		}

		private void Play()
		{
			if (animator == null)
			{
				Log.Animation("Warning: pers:{4} Animator is destroyed {0}:{3} duration:{1} speed:{2}", state, clipDuration, speed, debugClipName, persId_);
			}
			else if (animator.runtimeAnimatorController == null)
			{
				Log.Animation("Warning: pers:{4} Animator doesn't have controller {0}:{3} duration:{1} speed:{2}", state, clipDuration, speed, debugClipName, persId_);
			}
			else
			{
				if (!animator.isInitialized || !animator.gameObject.activeInHierarchy)
				{
					return;
				}
				if (animator.speed != speed)
				{
					animator.speed = speed;
				}
				transitionDuration = System.Math.Min(transitionDuration, clipDuration * 0.33f);
				if (ActionDebugLocker.animations)
				{
					if (transitionDuration > 0f)
					{
						animator.CrossFade(state, transitionDuration);
					}
					else
					{
						animator.Play(state);
					}
				}
			}
		}
	}
}
