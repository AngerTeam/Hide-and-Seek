using CraftyVoxelEngine;
using CraftyVoxelEngine.Content;
using UnityEngine;

namespace InventoryModule
{
	public class LootSoloController : Singleton
	{
		private LootManager lootManager_;

		private IInventoryLogic inventoryLogic_;

		private VoxelInteraction voxelEngine_;

		public override void Dispose()
		{
			lootManager_.LootStatusChanged -= HandleLootStatusChanged;
			voxelEngine_.controller.VoxelDestroyed -= HandleVoxelDestroyed;
		}

		public override void Init()
		{
			SingletonManager.Get<VoxelInteraction>(out voxelEngine_);
			SingletonManager.Get<LootManager>(out lootManager_);
			SingletonManager.Get<IInventoryLogic>(out inventoryLogic_);
			lootManager_.LootStatusChanged += HandleLootStatusChanged;
			voxelEngine_.controller.VoxelDestroyed += HandleVoxelDestroyed;
		}

		private void DropItemToLoot(object sender, DropItemToLootArgs e)
		{
			lootManager_.DropItemToLoot(e);
		}

		private void HandleLootStatusChanged(object sender, LootEventArgs e)
		{
			if (e.type == LootEventType.TakeLoot)
			{
				inventoryLogic_.TryAddToPanelOrBackpack(e.loot.item);
			}
		}

		private void HandleVoxelDestroyed(VoxelEventArgs args)
		{
			VoxelsEntries value;
			ArtikulsEntries value2;
			if (VoxelContentMap.Voxels.TryGetValue(args.PreviousValue, out value) && InventoryContentMap.Artikuls.TryGetValue(value.drop_artikul_id, out value2))
			{
				lootManager_.SpawnLoot((ushort)value2.id, args.GlobalKey.ToVector() + Vector3.one * 0.5f, string.Empty, args.GlobalKey);
			}
		}
	}
}
