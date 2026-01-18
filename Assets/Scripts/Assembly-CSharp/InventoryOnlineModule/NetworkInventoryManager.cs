using BankModule;
using InventoryModule;
using RemoteData;
using SyncOnlineModule;

namespace InventoryOnlineModule
{
	public class NetworkInventoryManager : Singleton
	{
		private CraftManager craftManager_;

		private IInventoryOnline inventoryOnline_;

		private IInventoryLogic inventroy_;

		private BroadPurchaseOnline purchaseOnline_;

		private bool enabled;

		public override void Dispose()
		{
			purchaseOnline_.SlotsUpdated -= HandleSlotsUpdated;
			craftManager_.OnCraftGetResult -= GetCraftResult;
			inventroy_.Controller.SlotContentsMoved -= MoveSlots;
			inventroy_.Controller.SlotsSwaped -= SwapSlots;
			inventroy_.Model.SelectedSlotChanged -= SlotChanged;
			inventroy_.Model.SlotDeleted -= HandleSlotDeleted;
		}

		public override void OnSyncRecieved()
		{
			PurchaseMessage message;
			if (SyncManager.TryRead<PurchaseMessage>(out message) && message.slots != null)
			{
				HandleSlotsRecieved(message.slots);
			}
			SlotChanged();
		}

		public override void Init()
		{
			SingletonManager.TryGet<IInventoryOnline>(out inventoryOnline_);
			SingletonManager.Get<IInventoryLogic>(out inventroy_);
			SingletonManager.Get<CraftManager>(out craftManager_);
			SingletonManager.Get<BroadPurchaseOnline>(out purchaseOnline_);
			purchaseOnline_.SlotsUpdated += HandleSlotsUpdated;
			craftManager_.OnCraftGetResult += GetCraftResult;
			inventroy_.Controller.SlotContentsMoved += MoveSlots;
			inventroy_.Controller.SlotsSwaped += SwapSlots;
			inventroy_.Model.SelectedSlotChanged += SlotChanged;
			inventroy_.Model.SlotDeleted += HandleSlotDeleted;
			enabled = true;
		}

		private void GetCraftResult(object sender, CraftGetResultArgs e)
		{
			if (enabled)
			{
				inventoryOnline_.SendCraftGetResult(e.RecipeId, e.BuildingRef, e.ArticulId, e.Count, e.CraftCount, e.SlotId);
			}
		}

		private void HandleSlotDeleted(SlotModel slotModel)
		{
			if (enabled)
			{
				inventoryOnline_.SendCleanSlot(slotModel.name);
			}
		}

		private void HandleSlotsRecieved(SlotMessage[] slots)
		{
			if (enabled)
			{
				inventroy_.Model.ClearAllSlots();
				HandleSlotsUpdated(slots);
			}
		}

		private void HandleSlotsUpdated(SlotMessage[] slots)
		{
			if (enabled)
			{
				foreach (SlotMessage slotMessage in slots)
				{
					inventroy_.Model.SetSlot(slotMessage.slotId, (ushort)slotMessage.artikulId, slotMessage.count, slotMessage.wear, slotMessage.tmp > 0);
				}
				inventroy_.Model.ReportSlotsUpdated();
			}
		}

		private void MoveSlots(SlotMoveArgs e)
		{
			if (enabled)
			{
				inventoryOnline_.SendMoveSlot(e.SlotFrom, e.SlotTo, e.Artikul, e.Count);
			}
		}

		private void SlotChanged()
		{
			if (enabled)
			{
				inventoryOnline_.SendSelectSlot(inventroy_.Model.SelectedSlot.name);
			}
		}

		private void SwapSlots(SlotModel slotA, SlotModel slotB)
		{
			if (enabled)
			{
				inventoryOnline_.SendSwapSlot(slotA.name, slotB.name);
			}
		}
	}
}
