using System;
using CraftyEngine.Content;
using InventoryModule;

namespace ShopModule
{
	public class ShopModuleContentDeserializer : Singleton
	{
		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<ShopContentMap>();
			foreach (ShopItemsEntries value2 in ShopContentMap.ShopItems.Values)
			{
				int result;
				ArtikulsEntries value;
				if (int.TryParse(value2.entity_id, out result) && InventoryContentMap.Artikuls.TryGetValue(result, out value))
				{
					value2.artikul = value;
					value2.maxLevelCap = Math.Max(value2.min_level, value.min_level);
					value2.title = value.title;
					value2.artikulId = value.id;
				}
			}
		}
	}
}
