using CraftyEngine.Content;

namespace Effects
{
	public class MapSkyboxEntries : ContentItem
	{
		public int id;

		public int map_id;

		public int skybox_id;

		public override void Deserialize()
		{
			id = TryGetInt(EffectsContentKeys.id);
			intKey = id;
			map_id = TryGetInt(EffectsContentKeys.map_id);
			skybox_id = TryGetInt(EffectsContentKeys.skybox_id);
			base.Deserialize();
		}
	}
}
