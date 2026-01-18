namespace InventoryOnlineModule
{
	public interface IInventoryOnline : ISingleton
	{
		void SendCraftGetResult(int recipeId, string buildingRef, int articulId, int count, int craftCount, string slotId);

		void SendMoveSlot(string fromSlotId, string toSlotId, int articulId, int count);

		void SendSwapSlot(string fromSlotId, string toSlotId);

		void SendCleanSlot(string slotId);

		void SendSelectSlot(string slotId);
	}
}
