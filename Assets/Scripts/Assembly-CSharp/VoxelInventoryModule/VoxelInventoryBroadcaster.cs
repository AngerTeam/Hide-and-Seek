using CraftyVoxelEngine;
using CraftyVoxelEngine.Content;
using InventoryModule;
using PlayerModule.MyPlayer;

namespace VoxelInventoryModule
{
	public class VoxelInventoryBroadcaster : Singleton
	{
		private VoxelInteraction voxelInteraction_;

		private VoxelInteractionModel model_;

		private MyPlayerStatsModel myPlayerStatsModel_;

		private InventoryModel inventoryModel_;

		public override void Init()
		{
			SingletonManager.Get<InventoryModel>(out inventoryModel_);
			SingletonManager.Get<VoxelInteraction>(out voxelInteraction_);
			inventoryModel_.SelectedSlotChanged += ItemInHandChanged;
			voxelInteraction_.controller.VoxelBuilt += HandleVoxelBuilt;
			SingletonManager.Get<VoxelInteractionModel>(out model_);
			model_.selectedItemDistance = VoxelContentMap.VoxelSettings.interactionDistance;
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			myPlayerStatsModel_.stats.Died += HandlePlayerDied;
		}

		private void HandlePlayerDied()
		{
			model_.Digging = false;
		}

		private void HandleVoxelBuilt(VoxelEventArgs args)
		{
			SlotModel selectedSlot = inventoryModel_.SelectedSlot;
			if (!voxelInteraction_.model.isCreativeMode && !selectedSlot.IsEmpty)
			{
				selectedSlot.Item.Amount--;
				if (selectedSlot.Item.Amount == 0)
				{
					selectedSlot.Clear();
					voxelInteraction_.model.buildVoxelId = 0;
				}
			}
		}

		private void ItemInHandChanged()
		{
			voxelInteraction_.model.buildVoxelId = 0;
			model_.selectedItemDistance = GetInteractionDistance();
		}

		public float GetInteractionDistance()
		{
			if (!inventoryModel_.SelectedSlot.IsEmpty)
			{
				ArtikulsEntries entry = inventoryModel_.SelectedSlot.Entry;
				voxelInteraction_.model.buildVoxelId = (ushort)entry.voxel_id;
				return (!entry.ranged) ? VoxelContentMap.VoxelSettings.interactionDistance : ((!myPlayerStatsModel_.stats.Aiming) ? entry.weapon_range : entry.weapon_range_aim);
			}
			return VoxelContentMap.VoxelSettings.interactionDistance;
		}

		public override void Dispose()
		{
			inventoryModel_.SelectedSlotChanged -= ItemInHandChanged;
			voxelInteraction_.controller.VoxelBuilt -= HandleVoxelBuilt;
		}
	}
}
