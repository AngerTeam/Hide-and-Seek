using CraftyEngine.Content;

namespace CraftyVoxelEngine.Content
{
	public class VoxelOptionsEntries : ContentItem
	{
		public int id;

		public string name;

		public string value;

		public override void Deserialize()
		{
			id = TryGetInt(VoxelContentKeys.id);
			intKey = id;
			name = TryGetString(VoxelContentKeys.name, string.Empty);
			value = TryGetString(VoxelContentKeys.value, string.Empty);
			base.Deserialize();
		}
	}
}
