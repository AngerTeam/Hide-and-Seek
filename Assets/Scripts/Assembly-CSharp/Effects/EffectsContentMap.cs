using System.Collections.Generic;
using CraftyEngine.Content;

namespace Effects
{
	public class EffectsContentMap : ContentMapBase
	{
		public static Dictionary<int, SkyboxEntries> Skybox;

		public static Dictionary<int, MapAmbientSoundsEntries> MapAmbientSounds;

		public static Dictionary<int, MapSkyboxEntries> MapSkybox;

		public override void Deserialize()
		{
			EffectsContentKeys.Deserialize();
			Skybox = ReadInt<SkyboxEntries>(EffectsContentKeys.skybox);
			MapAmbientSounds = ReadInt<MapAmbientSoundsEntries>(EffectsContentKeys.map_ambient_sounds);
			MapSkybox = ReadInt<MapSkyboxEntries>(EffectsContentKeys.map_skybox);
			base.Deserialize();
		}
	}
}
