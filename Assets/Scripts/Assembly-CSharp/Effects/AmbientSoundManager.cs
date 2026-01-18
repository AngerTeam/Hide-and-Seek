using System;
using CraftyEngine.Sounds;

namespace Effects
{
	public class AmbientSoundManager : IDisposable
	{
		private MapFxModel mapFxModel_;

		public AmbientSoundManager()
		{
			SingletonManager.Get<MapFxModel>(out mapFxModel_);
			mapFxModel_.MusicChanged += LoadAmbient;
		}

		public void LoadAmbient()
		{
			MapAmbientSoundsEntries value;
			if (EffectsContentMap.MapAmbientSounds != null && EffectsContentMap.MapAmbientSounds.TryGetValue(mapFxModel_.ambientSoundId, out value))
			{
				string text = ((!CompileConstants.MOBILE) ? value.filename_standalone : value.filename_mobile);
				SoundProvider.SoundAmbientGroup("content/maps/ambient_sounds/" + text);
			}
		}

		public void Dispose()
		{
			mapFxModel_.MusicChanged -= LoadAmbient;
		}
	}
}
