using CraftyEngine.Infrastructure;
using CraftyEngine.Sounds;

namespace SoundsModule
{
	public class SoundManagerBridge : PermanentSingleton
	{
		private bool ready_;

		private SoundManager soundManager_;

		public override void Init()
		{
			SingletonManager.Get<SoundManager>(out soundManager_);
		}

		public override void OnDataLoaded()
		{
			if (SoundsContentMap.SoundSettings == null)
			{
				Log.Error("Sound data not detected!");
				return;
			}
			ready_ = true;
			ButtonSet.Executed += SoundClick;
			SoundProvider.SoundRecieved += PlaySound;
			SoundProvider.StopAmbinetRecieved += StopAmbient;
			SoundProvider.AmbinetVolumeChanged += HandleAmbinetVolumeChanged;
		}

		private void HandleAmbinetVolumeChanged()
		{
			if (ready_)
			{
				soundManager_.UpdateVolume();
			}
		}

		private void StopAmbient()
		{
			if (ready_)
			{
				soundManager_.StopAmbient();
			}
		}

		private void PlaySound(SoundInfo sound)
		{
			if (ready_ && (sound.ambient || !DataStorage.splashScreenVisible))
			{
				soundManager_.Play(sound);
			}
		}

		public void SoundClick()
		{
			SoundInfo sound = new SoundInfo(1);
			sound.group = true;
			PlaySound(sound);
		}
	}
}
