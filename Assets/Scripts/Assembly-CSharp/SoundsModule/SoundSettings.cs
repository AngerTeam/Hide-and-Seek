using System.Collections.Generic;
using CraftyEngine;
using CraftyEngine.Sounds;

namespace SoundsModule
{
	public class SoundSettings : AdjustableSettings
	{
		protected PersistanceUserSettings userSettings;

		public SoundSettings()
			: base(1)
		{
		}

		public override void Build()
		{
			PersistanceManager.Get<PersistanceUserSettings>(out userSettings);
			UpdateVolume();
			settings = new List<AdjustableSetting>();
			if (!userSettings.defaultSoundValuesVetsion1Set)
			{
				userSettings.defaultSoundValuesVetsion1Set = true;
				SetSound(SoundsContentMap.SoundSettings.effectsVolume * 100f);
				SetMusic(SoundsContentMap.SoundSettings.musicVolume * 100f);
				PersistanceManager.Save(userSettings);
			}
			Add("UI_InGameMenu_Audio");
			Add("UI_InGameMenu_EffectsVolume", userSettings.soundVolume, 0f, 100f, SetSound);
			Add("UI_InGameMenu_MusicVolume", userSettings.musicVolume, 0f, 100f, SetMusic);
		}

		private void SetSound(float value)
		{
			userSettings.soundVolume = value;
			UpdateVolume();
		}

		private void SetMusic(float value)
		{
			userSettings.musicVolume = value;
			UpdateVolume();
		}

		private void UpdateVolume()
		{
			PersistanceManager.Save(userSettings);
			SoundProvider.effectsVolume = userSettings.soundVolume / 100f;
			SoundProvider.MusicVolume = userSettings.musicVolume / 100f;
		}
	}
}
