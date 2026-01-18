using CraftyEngine.Content;

namespace InventoryModule
{
	public class ArtikulGroupsEntries : ContentItem
	{
		public int id;

		public string title;

		public float sort_val;

		public int use_in_editor;

		public override void Deserialize()
		{
			id = TryGetInt(InventoryContentKeys.id);
			intKey = id;
			title = TryGetString(InventoryContentKeys.title, string.Empty);
			sort_val = TryGetFloat(InventoryContentKeys.sort_val);
			use_in_editor = TryGetInt(InventoryContentKeys.use_in_editor);
			base.Deserialize();
		}
	}
}
