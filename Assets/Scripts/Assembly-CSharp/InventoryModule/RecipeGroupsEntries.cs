using CraftyEngine.Content;

namespace InventoryModule
{
	public class RecipeGroupsEntries : ContentItem
	{
		public int id;

		public string title;

		public float sort_val;

		public override void Deserialize()
		{
			id = TryGetInt(InventoryContentKeys.id);
			intKey = id;
			title = TryGetString(InventoryContentKeys.title, string.Empty);
			sort_val = TryGetFloat(InventoryContentKeys.sort_val);
			base.Deserialize();
		}
	}
}
