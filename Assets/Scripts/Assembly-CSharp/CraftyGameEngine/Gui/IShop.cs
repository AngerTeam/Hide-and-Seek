using System;
using System.Collections.Generic;
using ShopModule;

namespace CraftyGameEngine.Gui
{
	public interface IShop
	{
		event Action<ShopItemsEntries> OnBuy;

		void ScrollToItem(int itemId, bool select);

		void GetShopItems(out List<ShopItemsEntries> entries, out Dictionary<string, ShopCategory> categories);

		void GetRecommendedItems(int currentLevel, int itemsCount, out List<ShopItemsEntries> recommendedItems, List<int> recommendedItemsIds = null);
	}
}
