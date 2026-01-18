namespace ShopModule
{
	public class ShopContentKeys
	{
		public static string id;

		public static string type;

		public static string sort_val;

		public static string money_type;

		public static string money_cnt;

		public static string min_level;

		public static string hidden;

		public static string entity_table_name;

		public static string entity_id;

		public static string description;

		public static string entity_cnt;

		public static string level_max;

		public static string level_min;

		public static string shop_items;

		public static void Deserialize()
		{
			id = "id";
			type = "type";
			sort_val = "sort_val";
			money_type = "money_type";
			money_cnt = "money_cnt";
			min_level = "min_level";
			hidden = "hidden";
			entity_table_name = "entity_table_name";
			entity_id = "entity_id";
			description = "description";
			entity_cnt = "entity_cnt";
			level_max = "level_max";
			level_min = "level_min";
			shop_items = "shop_items";
		}
	}
}
