using CraftyEngine.Content;

namespace PvpModule.Content
{
	public class MapTerrainsEntries : ContentItem
	{
		public int id;

		public int map_id;

		public int terrain_id;

		public override void Deserialize()
		{
			id = TryGetInt(PvpModuleContentKeys.id);
			intKey = id;
			map_id = TryGetInt(PvpModuleContentKeys.map_id);
			terrain_id = TryGetInt(PvpModuleContentKeys.terrain_id);
			base.Deserialize();
		}
	}
}
