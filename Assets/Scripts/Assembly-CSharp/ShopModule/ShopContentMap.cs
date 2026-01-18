using System.Collections.Generic;
using CraftyEngine.Content;

namespace ShopModule
{
	public class ShopContentMap : ContentMapBase
	{
		public static Dictionary<int, ShopItemsEntries> ShopItems;

		public override void Deserialize()
		{
			ShopContentKeys.Deserialize();
			ShopItems = ReadInt<ShopItemsEntries>(ShopContentKeys.shop_items);
			base.Deserialize();
		}
	}
}
