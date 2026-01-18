namespace RecommendedToBuyModule
{
	public class RecommendedToBuyModuleContentKeys
	{
		public static string id;

		public static string shop_item_id;

		public static string pvp_mode_id;

		public static string shop_item_for_modes;

		public static void Deserialize()
		{
			id = "id";
			shop_item_id = "shop_item_id";
			pvp_mode_id = "pvp_mode_id";
			shop_item_for_modes = "shop_item_for_modes";
		}
	}
}
