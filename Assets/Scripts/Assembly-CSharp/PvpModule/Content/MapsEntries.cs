using CraftyEngine.Content;

namespace PvpModule.Content
{
	public class MapsEntries : ContentItem
	{
		public int id;

		public string title;

		public string icon;

		public string map_file;

		public int map_size;

		public int ambient_sound_id;

		public string GetFullMapPath()
		{
			return PvpModuleContentKeys.GetFullMapPath24 + map_file;
		}

		public override void Deserialize()
		{
			id = TryGetInt(PvpModuleContentKeys.id);
			intKey = id;
			title = TryGetString(PvpModuleContentKeys.title, string.Empty);
			icon = TryGetString(PvpModuleContentKeys.icon, string.Empty);
			map_file = TryGetString(PvpModuleContentKeys.map_file, string.Empty);
			map_size = TryGetInt(PvpModuleContentKeys.map_size);
			ambient_sound_id = TryGetInt(PvpModuleContentKeys.ambient_sound_id);
			base.Deserialize();
		}
	}
}
