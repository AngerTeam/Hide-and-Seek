using CraftyEngine.Content;

namespace InventoryModule
{
	public class RecipeBuildingsEntries : ContentItem
	{
		public int id;

		public int recipe_id;

		public int building_id;

		public override void Deserialize()
		{
			id = TryGetInt(InventoryContentKeys.id);
			intKey = id;
			recipe_id = TryGetInt(InventoryContentKeys.recipe_id);
			building_id = TryGetInt(InventoryContentKeys.building_id);
			base.Deserialize();
		}
	}
}
