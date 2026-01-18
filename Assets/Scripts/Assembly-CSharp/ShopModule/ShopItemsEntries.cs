using CraftyEngine.Content;
using InventoryModule;

namespace ShopModule
{
	public class ShopItemsEntries : ContentItem
	{
		public int id;

		public int type;

		public float sort_val;

		public int money_type;

		public int money_cnt;

		public int min_level;

		public int hidden;

		public string entity_table_name;

		public string entity_id;

		public string description;

		public int entity_cnt;

		public int level_max;

		public int level_min;

		public int categoryId;

		public ArtikulsEntries artikul;

		public int maxLevelCap;

		public string title;

		public int artikulId;

		public override void Deserialize()
		{
			id = TryGetInt(ShopContentKeys.id);
			intKey = id;
			type = TryGetInt(ShopContentKeys.type);
			sort_val = TryGetFloat(ShopContentKeys.sort_val);
			money_type = TryGetInt(ShopContentKeys.money_type);
			money_cnt = TryGetInt(ShopContentKeys.money_cnt);
			min_level = TryGetInt(ShopContentKeys.min_level);
			hidden = TryGetInt(ShopContentKeys.hidden);
			entity_table_name = TryGetString(ShopContentKeys.entity_table_name, string.Empty);
			entity_id = TryGetString(ShopContentKeys.entity_id, string.Empty);
			description = TryGetString(ShopContentKeys.description, string.Empty);
			entity_cnt = TryGetInt(ShopContentKeys.entity_cnt);
			level_max = TryGetInt(ShopContentKeys.level_max);
			level_min = TryGetInt(ShopContentKeys.level_min);
			base.Deserialize();
		}
	}
}
