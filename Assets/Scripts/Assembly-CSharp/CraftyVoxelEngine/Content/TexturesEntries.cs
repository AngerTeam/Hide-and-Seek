using CraftyEngine.Content;

namespace CraftyVoxelEngine.Content
{
	public class TexturesEntries : ContentItem
	{
		public int id;

		public string title;

		public string filename;

		public int flags;

		public string GetFullnamePath()
		{
			return VoxelContentKeys.GetFullnamePath18 + filename;
		}

		public override void Deserialize()
		{
			id = TryGetInt(VoxelContentKeys.id);
			intKey = id;
			title = TryGetString(VoxelContentKeys.title, string.Empty);
			filename = TryGetString(VoxelContentKeys.filename, string.Empty);
			flags = TryGetInt(VoxelContentKeys.flags);
			base.Deserialize();
		}
	}
}
