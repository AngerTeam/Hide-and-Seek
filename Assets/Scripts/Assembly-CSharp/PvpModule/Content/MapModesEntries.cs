using CraftyEngine.Content;

namespace PvpModule.Content
{
	public class MapModesEntries : ContentItem
	{
		public int id;

		public int map_id;

		public int mode_id;

		public override void Deserialize()
		{
			id = TryGetInt(PvpModuleContentKeys.id);
			intKey = id;
			map_id = TryGetInt(PvpModuleContentKeys.map_id);
			mode_id = TryGetInt(PvpModuleContentKeys.mode_id);
			base.Deserialize();
		}
	}
}
