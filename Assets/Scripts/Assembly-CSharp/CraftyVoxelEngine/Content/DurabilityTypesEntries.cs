using CraftyEngine.Content;

namespace CraftyVoxelEngine.Content
{
	public class DurabilityTypesEntries : ContentItem
	{
		public int id;

		public string title;

		public int dig_sound_group_id;

		public int move_sound_group_id;

		public override void Deserialize()
		{
			id = TryGetInt(VoxelContentKeys.id);
			intKey = id;
			title = TryGetString(VoxelContentKeys.title, string.Empty);
			dig_sound_group_id = TryGetInt(VoxelContentKeys.dig_sound_group_id);
			move_sound_group_id = TryGetInt(VoxelContentKeys.move_sound_group_id);
			base.Deserialize();
		}
	}
}
