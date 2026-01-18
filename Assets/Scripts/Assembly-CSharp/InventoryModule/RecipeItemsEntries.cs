using CraftyEngine.Content;

namespace InventoryModule
{
	public class RecipeItemsEntries : ContentItem
	{
		public int id;

		public int recipe_id;

		public int x;

		public int y;

		public int artikul_id;

		public int artikul_cnt;

		public override void Deserialize()
		{
			id = TryGetInt(InventoryContentKeys.id);
			intKey = id;
			recipe_id = TryGetInt(InventoryContentKeys.recipe_id);
			x = TryGetInt(InventoryContentKeys.x);
			y = TryGetInt(InventoryContentKeys.y);
			artikul_id = TryGetInt(InventoryContentKeys.artikul_id);
			artikul_cnt = TryGetInt(InventoryContentKeys.artikul_cnt);
			base.Deserialize();
		}
	}
}
