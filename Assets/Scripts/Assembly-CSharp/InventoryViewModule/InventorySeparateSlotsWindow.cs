using InventoryModule;

namespace InventoryViewModule
{
	public class InventorySeparateSlotsWindow : InventoryWindow
	{
		private SeparateSlotTypeBasedInventory slotManager_;

		public InventorySeparateSlotsWindow()
		{
			SingletonManager.Get<SeparateSlotTypeBasedInventory>(out slotManager_);
			slotManager_.AttemptToMoveItemToWrongSlotType += base.BlinkTabBySlotType;
		}

		public override void Dispose()
		{
			slotManager_.AttemptToMoveItemToWrongSlotType -= base.BlinkTabBySlotType;
			base.Dispose();
		}
	}
}
