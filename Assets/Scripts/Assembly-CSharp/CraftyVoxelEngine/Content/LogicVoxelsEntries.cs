using CraftyEngine.Content;

namespace CraftyVoxelEngine.Content
{
	public class LogicVoxelsEntries : ContentItem
	{
		public int id;

		public int voxel_id;

		public string description;

		public int type_id;

		public int pvp_side;

		public int max_count;

		public int object_model_id;

		public override void Deserialize()
		{
			id = TryGetInt(VoxelContentKeys.id);
			intKey = id;
			voxel_id = TryGetInt(VoxelContentKeys.voxel_id);
			description = TryGetString(VoxelContentKeys.description, string.Empty);
			type_id = TryGetInt(VoxelContentKeys.type_id);
			pvp_side = TryGetInt(VoxelContentKeys.pvp_side);
			max_count = TryGetInt(VoxelContentKeys.max_count);
			object_model_id = TryGetInt(VoxelContentKeys.object_model_id);
			base.Deserialize();
		}
	}
}
