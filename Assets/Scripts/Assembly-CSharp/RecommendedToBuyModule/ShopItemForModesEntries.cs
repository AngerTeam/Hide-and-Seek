using CraftyEngine.Content;

namespace RecommendedToBuyModule
{
	public class ShopItemForModesEntries : ContentItem
	{
		public int id;

		public int shop_item_id;

		public int pvp_mode_id;

		public override void Deserialize()
		{
			id = TryGetInt(RecommendedToBuyModuleContentKeys.id);
			intKey = id;
			shop_item_id = TryGetInt(RecommendedToBuyModuleContentKeys.shop_item_id);
			pvp_mode_id = TryGetInt(RecommendedToBuyModuleContentKeys.pvp_mode_id);
			base.Deserialize();
		}
	}
}
