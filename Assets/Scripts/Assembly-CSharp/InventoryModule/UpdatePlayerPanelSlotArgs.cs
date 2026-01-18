using System;

namespace InventoryModule
{
	public class UpdatePlayerPanelSlotArgs : EventArgs
	{
		public SlotModel Slot { get; private set; }

		public UpdatePlayerPanelSlotArgs(SlotModel slot)
		{
			Slot = slot;
		}
	}
}
