using System;
using CraftyBundles;
using CraftyEngine.Infrastructure;
using Extensions;
using UnityEngine;

namespace Animations
{
	public class AnimatorOverrideStatesController : IDisposable
	{
		public bool allowPlay;

		private AnimatorEventsReciever eventsReciever_;

		private QueueManager queueManager_;

		public bool cacheStates;

		public string persId;

		private int maxStates_;

		public Animator Animator { get; protected set; }

		public int[] CurrentStateIndex { get; private set; }

		public AnimatorOverrideController OverrideController { get; private set; }

		public AnimatorLayerHolder[] Layers { get; private set; }

		public AnimatorClipStateData LastPlayiedClip { get; private set; }

		public event Action Step;

		public event Action<string> StateChanged;

		public AnimatorOverrideStatesController(int layersCount, string controllerName = "DynamicController", int maxStates = 9)
		{
			maxStates_ = maxStates;
			allowPlay = true;
			cacheStates = true;
			CurrentStateIndex = new int[2];
			SingletonManager.Get<QueueManager>(out queueManager_);
			Layers = new AnimatorLayerHolder[layersCount];
			RuntimeAnimatorController runtimeAnimatorController = Resources.Load<RuntimeAnimatorController>(controllerName);
			OverrideController = new AnimatorOverrideController();
			OverrideController.runtimeAnimatorController = runtimeAnimatorController;
		}

		public virtual void SetGameObject(GameObject instaince)
		{
			if (instaince == null)
			{
				Log.Animation("Warning: Failed to init AnimatorStateController with null GameObject");
				return;
			}
			Animator animator = instaince.GetComponent<Animator>();
			if (animator == null)
			{
				animator = instaince.AddComponent<Animator>();
			}
			animator.applyRootMotion = true;
			SetAnimator(animator);
		}

		public PlayAnimationTask Play(AnimatorClipStateData state, float? duration = null, TaskQueue queue = null, float? transitionDuration = null)
		{
			float speed = ((!duration.HasValue) ? 1f : (state.clipData.duration / duration.Value));
			PlayAnimationTask playAnimationTask = new PlayAnimationTask(Animator, state.clipData, speed, persId);
			playAnimationTask.debugClipName = state.clipData.name;
			if (transitionDuration.HasValue)
			{
				playAnimationTask.transitionDuration = transitionDuration.Value;
			}
			if (queue == null)
			{
				if (this.StateChanged != null)
				{
					this.StateChanged(state.stateName);
				}
				playAnimationTask.Start();
			}
			else
			{
				playAnimationTask.useTimer = true;
				if (this.StateChanged != null)
				{
					queueManager_.AddTask(delegate
					{
						this.StateChanged.SafeInvoke(state.stateName);
					}, queue);
				}
				queueManager_.AddTask(playAnimationTask, queue);
			}
			return playAnimationTask;
		}

		public PlayAnimationTask Play(string state, float? duration = null, TaskQueue queue = null, float? transitionDuration = null)
		{
			AnimatorClipStateData clipStateData;
			if (!TryGetClip(state, out clipStateData))
			{
				if (CompileConstants.EDITOR)
				{
					string text = string.Empty;
					for (int i = 0; i < Layers.Length; i++)
					{
						if (Layers[i] != null && Layers[i].Data != null)
						{
							text = string.Concat(text, Layers[i].Data, "\n");
						}
					}
				}
				return null;
			}
			LastPlayiedClip = clipStateData;
			return Play(clipStateData, duration, queue, transitionDuration);
		}

		public void SetAnimator(Animator animator)
		{
			Animator = animator;
			animator.runtimeAnimatorController = OverrideController;
			eventsReciever_ = animator.gameObject.GetComponent<AnimatorEventsReciever>();
			if (eventsReciever_ == null)
			{
				eventsReciever_ = animator.gameObject.AddComponent<AnimatorEventsReciever>();
				eventsReciever_.Step += ReportStep;
			}
			eventsReciever_.data = new AnimatorData[2];
			eventsReciever_.id = new string[2];
		}

		private void ReportStep()
		{
			this.Step.SafeInvoke();
		}

		public void AppendHolder(AnimatorLayerHolder layerHolder, int realLayer, int dataLayer, int from, bool allowOverrideRun = false)
		{
			if (layerHolder == null)
			{
				Log.Error("Unable to set null holder!");
				layerHolder = new AnimatorLayerHolder();
			}
			if (eventsReciever_ != null)
			{
				eventsReciever_.data[dataLayer] = layerHolder.Data;
				eventsReciever_.id[dataLayer] = "id: " + layerHolder.contentId;
			}
			Layers[dataLayer] = layerHolder;
			for (int i = 0; i < layerHolder.Clips.Count; i++)
			{
				AnimatorClipData animatorClipData = layerHolder.Clips[i];
				int num = i + from;
				if (num >= maxStates_)
				{
					Log.Warning("Only {1} clips are supported for now. Clip {0} will not be added", animatorClipData.name, maxStates_);
					break;
				}
				string text = realLayer.ToString() + num;
				OverrideController["empty" + text] = animatorClipData.clip;
				animatorClipData.dynamicStateA = "State" + text;
				animatorClipData.dynamicStateB = animatorClipData.dynamicStateA + "a";
			}
			if (realLayer != 0)
			{
				return;
			}
			AnimatorClipData clipByState = layerHolder.GetClipByState("idle");
			if (clipByState != null)
			{
				OverrideController["emptyDefault"] = clipByState.clip;
				if (allowOverrideRun)
				{
					OverrideController["Player_idle"] = clipByState.clip;
				}
			}
			if (allowOverrideRun)
			{
				clipByState = layerHolder.GetClipByState("run");
				if (clipByState != null)
				{
					OverrideController["Player_run"] = clipByState.clip;
				}
				clipByState = layerHolder.GetClipByState("walk");
				if (clipByState != null)
				{
					OverrideController["Player_walk"] = clipByState.clip;
				}
			}
		}

		public void SetHolder(AnimatorLayerHolder layerHolder, int layer, bool allowOverrideRun = false)
		{
			AppendHolder(layerHolder, layer, layer, 0, allowOverrideRun);
		}

		public bool TryGetClip(string stateName, out AnimatorClipStateData clipStateData)
		{
			clipStateData = new AnimatorClipStateData();
			for (int num = Layers.Length - 1; num >= 0; num--)
			{
				if (Layers[num] != null)
				{
					AnimatorClipData clipByState = Layers[num].GetClipByState(stateName);
					if (clipByState != null)
					{
						clipStateData.clipData = clipByState;
						clipStateData.layer = num;
						clipStateData.stateName = stateName;
						return true;
					}
				}
			}
			return false;
		}

		public void Dispose()
		{
			this.StateChanged = null;
		}
	}
}
