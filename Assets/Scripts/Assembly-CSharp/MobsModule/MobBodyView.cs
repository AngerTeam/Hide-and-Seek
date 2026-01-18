using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using CraftyEngine.Sounds;
using MobsModule.Content;
using PlayerModule.Playmate;
using UnityEngine;

namespace MobsModule
{
	public class MobBodyView : HumanBodyView
	{
		private MobsEntries mob_;

		private float nextSoundTime_;

		private int idleSoundGroupId_;

		private float soundIntervalMax_;

		private float soundIntervalMin_;

		public MobBodyView()
		{
			hierarchy.passCollider.gameObject.SetActive(true);
			InitAsc();
		}

		protected override FileHolder GetBodyBundle()
		{
			if (!MobsContentMap.Mobs.TryGetValue(model.MobId, out mob_))
			{
				Log.Error("Unable to find mob!");
				return null;
			}
			return skinController.LoadSkin(mob_.GetFullBundlePath());
		}

		public override void SetVisible(bool visible)
		{
			base.SetVisible(visible);
			if (visible)
			{
				StartIdleSound();
			}
			else
			{
				StopIdleSound();
			}
		}

		private void StartIdleSound()
		{
			if (mob_ != null)
			{
				idleSoundGroupId_ = mob_.idle_sound_group_id;
				soundIntervalMin_ = mob_.sound_interval_min;
				soundIntervalMax_ = mob_.sound_interval_max;
				UnityEvent singlton;
				SingletonManager.Get<UnityEvent>(out singlton);
				singlton.Unsubscribe(UnityEventType.Update, Update);
				singlton.Subscribe(UnityEventType.Update, Update);
			}
		}

		protected override void StopIdleSound()
		{
			UnityEvent singlton;
			SingletonManager.Get<UnityEvent>(out singlton);
			singlton.Unsubscribe(UnityEventType.Update, Update);
		}

		private void Update()
		{
			float fixedTime = Time.fixedTime;
			if (nextSoundTime_ < fixedTime)
			{
				nextSoundTime_ = fixedTime + Random.Range(soundIntervalMin_, soundIntervalMax_);
				if (gameObject != null)
				{
					SoundProvider.PlayGroupSound3D(gameObject.transform.position, idleSoundGroupId_, 1f);
				}
			}
		}
	}
}
