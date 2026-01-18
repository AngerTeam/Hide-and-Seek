using System;
using CraftyBundles;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using Extensions;
using InventoryModule;
using UnityEngine;

namespace Animations
{
	public class AnimatedItemView : IDisposable
	{
		public ArtikulsEntries selectedArtikul;

		protected AnimationType type;

		public int forcedAnimationId;

		public bool split;

		public LayeredAsc LayeredAsc { get; protected set; }

		public AnimatorOverrideStatesController Asc { get; protected set; }

		public event Action AnimationsLoaded;

		protected void InitAsc()
		{
			LayeredAsc = new LayeredAsc((type != AnimationType.ThirdPersonBody) ? 1 : 2);
			Asc = LayeredAsc;
			TryLoadDefaultAnimations();
		}

		public void TryLoadDefaultAnimations()
		{
			AnimatonsCacheHolder singlton;
			SingletonManager.Get<AnimatonsCacheHolder>(out singlton);
			if (type == AnimationType.ThirdPersonBody && forcedAnimationId == 0)
			{
				Asc.SetHolder(singlton.animationRun, 0, AnimationsContentMap.AnimationSettings.allowOverrideRun);
			}
		}

		public void LoadAnimations(GameObject instance, bool appendMode = false)
		{
			Asc.SetGameObject(instance);
			int animationId = 0;
			if (forcedAnimationId > 0)
			{
				animationId = forcedAnimationId;
			}
			else
			{
				switch (type)
				{
				case AnimationType.ThirdPersonBody:
					animationId = selectedArtikul.animation_third_person;
					break;
				case AnimationType.FirstPersonItem:
					animationId = selectedArtikul.animation_first_person;
					break;
				case AnimationType.ThirdPersonItem:
					animationId = selectedArtikul.animation_item;
					break;
				}
			}
			if (animationId > 0)
			{
				AnimationsFileManager animationsFileManager = SingletonManager.Get<AnimationsFileManager>();
				int layer = ((forcedAnimationId == 0 && type == AnimationType.ThirdPersonBody) ? 1 : 0);
				FileHolder fileHolder;
				animationsFileManager.GetAnimation(out fileHolder, animationId, split, delegate(FileHolder file)
				{
					SetHolder(file, layer, animationId, appendMode);
				});
				return;
			}
			AnimatonsCacheHolder singlton;
			SingletonManager.Get<AnimatonsCacheHolder>(out singlton);
			AnimatorLayerHolder animatorLayerHolder = null;
			switch (type)
			{
			case AnimationType.ThirdPersonBody:
				animatorLayerHolder = singlton.animationMelee;
				break;
			case AnimationType.FirstPersonItem:
				animatorLayerHolder = singlton.animationItemMelee;
				break;
			}
			if (animatorLayerHolder != null)
			{
				SaveAnimationDurations(animatorLayerHolder);
				Asc.SetHolder(animatorLayerHolder, (type == AnimationType.ThirdPersonBody) ? 1 : 0);
			}
			UnityEvent.OnNextUpdate(ResetAnimator);
		}

		public float TryGetAnimationDuration(int layer, string tag, float defaultDuration)
		{
			AnimatorLayerHolder animatorLayerHolder = Asc.Layers[layer];
			return (animatorLayerHolder != null) ? GetAnimationDuration(animatorLayerHolder, tag, defaultDuration) : defaultDuration;
		}

		protected float GetAnimationDuration(AnimatorLayerHolder layerHolder, string tag, float defaultDuration)
		{
			AnimatorClipData clipByState = layerHolder.GetClipByState(tag);
			if (clipByState != null)
			{
				switch (type)
				{
				case AnimationType.ThirdPersonItem:
				case AnimationType.ThirdPersonBody:
					if (clipByState.duration != 0f && defaultDuration < clipByState.duration)
					{
						defaultDuration = clipByState.duration;
					}
					break;
				case AnimationType.FirstPersonItem:
					defaultDuration = clipByState.duration;
					break;
				}
			}
			return defaultDuration;
		}

		private void SaveAnimationDurations(AnimatorLayerHolder layerHolder)
		{
			if (selectedArtikul == null)
			{
				return;
			}
			ArtikulsAnimations artikulsAnimations = ((type != 0) ? selectedArtikul.playmateAnimations : selectedArtikul.myPlayerAnimations);
			artikulsAnimations.attackDuration = GetAnimationDuration(layerHolder, "attack", artikulsAnimations.attackDuration);
			artikulsAnimations.idleDuration = GetAnimationDuration(layerHolder, "idle", artikulsAnimations.idleDuration);
			artikulsAnimations.flauntDuration = GetAnimationDuration(layerHolder, "flaunt", artikulsAnimations.flauntDuration);
			artikulsAnimations.menuDuration = GetAnimationDuration(layerHolder, "menu", artikulsAnimations.menuDuration);
			if (artikulsAnimations.flauntStates == null)
			{
				artikulsAnimations.flauntStates = layerHolder.GetAllStates("flaunt");
			}
			if (artikulsAnimations.attackDuration > selectedArtikul.cooldown && selectedArtikul.cooldown > 0f)
			{
				artikulsAnimations.attackDuration = selectedArtikul.cooldown;
			}
			AnimatorClipData clipByState = layerHolder.GetClipByState("attack");
			if (clipByState != null && clipByState.events != null)
			{
				for (int i = 0; i < clipByState.events.Length; i++)
				{
					AnimatorEventData animatorEventData = clipByState.events[i];
					Log.Info("AnimatorEventData {0} {1}", animatorEventData.name, animatorEventData.moment);
					if (animatorEventData.name == "contact")
					{
						artikulsAnimations.contactMoment = animatorEventData.moment;
						break;
					}
				}
			}
			artikulsAnimations.Update();
		}

		private void SetHolder(FileHolder fileHolder, int layer, int id, bool append)
		{
			AnimatorLayerHolder animatorLayerHolder = new AnimatorLayerHolder();
			animatorLayerHolder.SetData(fileHolder, id);
			SaveAnimationDurations(animatorLayerHolder);
			if (append)
			{
				Asc.AppendHolder(animatorLayerHolder, 0, 1, Asc.Layers[0].Clips.Count, true);
			}
			else
			{
				bool allowOverrideRun = forcedAnimationId != 0;
				Asc.SetHolder(animatorLayerHolder, layer, allowOverrideRun);
			}
			UnityEvent.OnNextUpdate(ResetAnimator);
		}

		public void ResetAnimator()
		{
			if (LayeredAsc != null)
			{
				LayeredAsc.ResetLayerWeight();
			}
			this.AnimationsLoaded.SafeInvoke();
		}

		public virtual void Dispose()
		{
			Asc.Dispose();
		}
	}
}
