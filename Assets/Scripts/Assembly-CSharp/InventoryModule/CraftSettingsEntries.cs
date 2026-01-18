using CraftyEngine.Content;

namespace InventoryModule
{
	public class CraftSettingsEntries : ContentItem
	{
		public int durabilityMinimumMargin = 10;

		public int durabilityTypeAxe = 1;

		public int durabilityTypePicksxe = 3;

		public int durabilityTypeShovel = 2;

		public float lootItemGravity = 9.8f;

		public float lootItemSize = 0.35f;

		public int messageUseThatDeltaHit = 8;

		public int slotSize = 50;

		public int slotSizeBackpack = 16;

		public int slotSizeBackpackCraft = 4;

		public int slotSizeBelt = 5;

		public int slotSizeStorage = 16;

		public int slotSizeWorkbenchCraft = 9;

		public int CRYSTAL_ARTIKUL_ID = 386;

		public int handArtikulId = 357;

		public float lootItemGravityMax = 20f;

		public int default_rarity_id = 12;

		public int MORE_ITEMS_ARTIKUL_ID = 486;

		public ArtikulsEntries handArtikul;

		public override void Deserialize()
		{
			durabilityMinimumMargin = TryGetInt(InventoryContentKeys.durabilityMinimumMargin, 10);
			durabilityTypeAxe = TryGetInt(InventoryContentKeys.durabilityTypeAxe, 1);
			durabilityTypePicksxe = TryGetInt(InventoryContentKeys.durabilityTypePicksxe, 3);
			durabilityTypeShovel = TryGetInt(InventoryContentKeys.durabilityTypeShovel, 2);
			lootItemGravity = TryGetFloat(InventoryContentKeys.lootItemGravity, 9.8f);
			lootItemSize = TryGetFloat(InventoryContentKeys.lootItemSize, 0.35f);
			messageUseThatDeltaHit = TryGetInt(InventoryContentKeys.messageUseThatDeltaHit, 8);
			slotSize = TryGetInt(InventoryContentKeys.slotSize, 50);
			slotSizeBackpack = TryGetInt(InventoryContentKeys.slotSizeBackpack, 16);
			slotSizeBackpackCraft = TryGetInt(InventoryContentKeys.slotSizeBackpackCraft, 4);
			slotSizeBelt = TryGetInt(InventoryContentKeys.slotSizeBelt, 5);
			slotSizeStorage = TryGetInt(InventoryContentKeys.slotSizeStorage, 16);
			slotSizeWorkbenchCraft = TryGetInt(InventoryContentKeys.slotSizeWorkbenchCraft, 9);
			CRYSTAL_ARTIKUL_ID = TryGetInt(InventoryContentKeys.CRYSTAL_ARTIKUL_ID, 386);
			handArtikulId = TryGetInt(InventoryContentKeys.handArtikulId, 357);
			lootItemGravityMax = TryGetFloat(InventoryContentKeys.lootItemGravityMax, 20f);
			default_rarity_id = TryGetInt(InventoryContentKeys.default_rarity_id, 12);
			MORE_ITEMS_ARTIKUL_ID = TryGetInt(InventoryContentKeys.MORE_ITEMS_ARTIKUL_ID, 486);
			base.Deserialize();
		}
	}
}
