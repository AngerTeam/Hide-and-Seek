using CraftyEngine.Content;

namespace CraftyVoxelEngine.Content
{
	public class VoxelTexturesEntries : ContentItem
	{
		public int id;

		public int voxel_id;

		public int texture_num;

		public int texture_id;

		public int side;

		public override void Deserialize()
		{
			id = TryGetInt(VoxelContentKeys.id);
			intKey = id;
			voxel_id = TryGetInt(VoxelContentKeys.voxel_id);
			texture_num = TryGetInt(VoxelContentKeys.texture_num);
			texture_id = TryGetInt(VoxelContentKeys.texture_id);
			side = TryGetInt(VoxelContentKeys.side);
			base.Deserialize();
		}
	}
}
