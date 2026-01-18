namespace InventoryModule
{
	public interface IInventoryLogic : ISingleton
	{
		InvetnoryController Controller { get; }

		InventoryModel Model { get; }

		bool GetFirstAvailableSlot(char[] slotCodes, ArtikulItem item, out SlotModel slot);

		bool GetFirstAvailableSlot(char slotCode, ArtikulItem item, out SlotModel slot);

		bool GetFirstAvailableSlot(int articulId, int amount, bool isTemp, out SlotModel slot);

		bool GetFirstAvailableSlot(ArtikulItem item, out SlotModel slot);

		bool TryMoveSlot(SlotModel slotA, SlotModel slotB, int count);

		SlotMergeStatus CheckStatus(SlotModel sourceSlot, SlotModel targetSlot, int amount);

		SlotMergeStatus CheckStatus(SlotModel sourceSlot, SlotModel targetSlot, int amount, out int resultAmount);

		void InitSlotGroups();

		bool TryAddToPanelOrBackpack(SlotModel source, out SlotModel result);

		bool TryAddToPanelOrBackpack(int articulId, int count, out SlotModel slot, bool isTemp = true);

		bool TryAddToPanelOrBackpack(ArtikulItem item);

		bool TryAddToPanelOrBackpack(ArtikulItem item, out SlotModel slot);
	}
}
