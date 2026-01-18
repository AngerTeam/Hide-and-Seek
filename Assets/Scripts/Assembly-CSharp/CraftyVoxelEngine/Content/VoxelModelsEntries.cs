using CraftyEngine.Content;

namespace CraftyVoxelEngine.Content
{
	public class VoxelModelsEntries : ContentItem
	{
		public int id;

		public string title;

		public string filename;

		public float scale_in_hand;

		public int flags;

		public string GetFullnamePath()
		{
			return VoxelContentKeys.GetFullnamePath19 + filename;
		}

		public override void Deserialize()
		{
			id = TryGetInt(VoxelContentKeys.id);
			intKey = id;
			title = TryGetString(VoxelContentKeys.title, string.Empty);
			filename = TryGetString(VoxelContentKeys.filename, string.Empty);
			scale_in_hand = TryGetFloat(VoxelContentKeys.scale_in_hand);
			flags = TryGetInt(VoxelContentKeys.flags);
			base.Deserialize();
		}
	}
}
