using System;
using CraftyEngine.Content;
using Extensions;

namespace Effects
{
	public class MapFxModel : Singleton
	{
		public int unityLayer;

		public int skyboxId;

		public int ambientSoundId;

		public ProFlareBatch CurrentFlareBatch { get; set; }

		public ProFlare CurrentFlare { get; set; }

		public event Action SkyboxChanged;

		public event Action MusicChanged;

		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<EffectsContentMap>();
		}

		public void FireSkyboxChanged(int id)
		{
			skyboxId = id;
			this.SkyboxChanged.SafeInvoke();
		}

		public void FireMusicChanged(int id)
		{
			ambientSoundId = id;
			this.MusicChanged.SafeInvoke();
		}
	}
}
