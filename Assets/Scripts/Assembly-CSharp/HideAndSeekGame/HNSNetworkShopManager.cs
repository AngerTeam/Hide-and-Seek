using ChestsViewModule;
using CraftyMultiplayerEngine;
using InventoryModule;
using RemoteData;

namespace HideAndSeekGame
{
	public class HNSNetworkShopManager : NetworkShopManager
	{
		private ArtikulsEntries chestArtikul_;

		protected override void CheckIfChest(int artikulId)
		{
			if (InventoryContentMap.Artikuls.TryGetValue(artikulId, out chestArtikul_) && chestArtikul_.type_id == 5)
			{
				broadPurchaseOnline_.BonusesUpdated += HandleChestOpened;
			}
		}

		private void HandleChestOpened(BonusItemMessage[] obj)
		{
			broadPurchaseOnline_.BonusesUpdated -= HandleChestOpened;
			ChestOpener singlton;
			SingletonManager.Get<ChestOpener>(out singlton);
			singlton.CreateAndOpenChest(chestArtikul_);
		}
	}
}
