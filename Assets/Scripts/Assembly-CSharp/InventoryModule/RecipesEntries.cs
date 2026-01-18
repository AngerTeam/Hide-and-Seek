using CraftyEngine.Content;

namespace InventoryModule
{
	public class RecipesEntries : ContentItem
	{
		public int id;

		public int group_id;

		public float sort_val;

		public string title;

		public int level_min;

		public int duration;

		public int artikul_id;

		public int artikul_cnt;

		public int handmade;

		public int visible_at_once;

		public string hash;

		public int calc_durability_in_location;

		public override void Deserialize()
		{
			id = TryGetInt(InventoryContentKeys.id);
			intKey = id;
			group_id = TryGetInt(InventoryContentKeys.group_id);
			sort_val = TryGetFloat(InventoryContentKeys.sort_val);
			title = TryGetString(InventoryContentKeys.title, string.Empty);
			level_min = TryGetInt(InventoryContentKeys.level_min);
			duration = TryGetInt(InventoryContentKeys.duration);
			artikul_id = TryGetInt(InventoryContentKeys.artikul_id);
			artikul_cnt = TryGetInt(InventoryContentKeys.artikul_cnt);
			handmade = TryGetInt(InventoryContentKeys.handmade);
			visible_at_once = TryGetInt(InventoryContentKeys.visible_at_once);
			hash = TryGetString(InventoryContentKeys.hash, string.Empty);
			calc_durability_in_location = TryGetInt(InventoryContentKeys.calc_durability_in_location);
			base.Deserialize();
		}
	}
}
