using System.Collections.Generic;
using CraftyEngine.Content;

namespace RecommendedToBuyModule
{
	public class RecommendedToBuyModuleContentMap : ContentMapBase
	{
		public static Dictionary<int, ShopItemForModesEntries> ShopItemForModes;

		public override void Deserialize()
		{
			RecommendedToBuyModuleContentKeys.Deserialize();
			ShopItemForModes = ReadInt<ShopItemForModesEntries>(RecommendedToBuyModuleContentKeys.shop_item_for_modes);
			base.Deserialize();
		}
	}
}
