using CraftyEngine.Content;

namespace CraftyVoxelEngine.Content
{
	public class VoxelsEntries : ContentItem
	{
		public int id;

		public int model_id;

		public string title;

		public int drop_artikul_id;

		public int drop_bonus_id;

		public int durability_type_id;

		public int durability;

		public int transparency;

		public int texture_transparency;

		public string light_color;

		public int logic_flags;

		public int options_flags;

		public int sound_group_id;

		public override void Deserialize()
		{
			id = TryGetInt(VoxelContentKeys.id);
			intKey = id;
			model_id = TryGetInt(VoxelContentKeys.model_id);
			title = TryGetString(VoxelContentKeys.title, string.Empty);
			drop_artikul_id = TryGetInt(VoxelContentKeys.drop_artikul_id);
			drop_bonus_id = TryGetInt(VoxelContentKeys.drop_bonus_id);
			durability_type_id = TryGetInt(VoxelContentKeys.durability_type_id);
			durability = TryGetInt(VoxelContentKeys.durability);
			transparency = TryGetInt(VoxelContentKeys.transparency);
			texture_transparency = TryGetInt(VoxelContentKeys.texture_transparency);
			light_color = TryGetString(VoxelContentKeys.light_color, string.Empty);
			logic_flags = TryGetInt(VoxelContentKeys.logic_flags);
			options_flags = TryGetInt(VoxelContentKeys.options_flags);
			sound_group_id = TryGetInt(VoxelContentKeys.sound_group_id);
			base.Deserialize();
		}
	}
}
