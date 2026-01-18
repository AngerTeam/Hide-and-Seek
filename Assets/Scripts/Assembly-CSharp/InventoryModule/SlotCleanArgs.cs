using System;

namespace InventoryModule
{
	public class SlotCleanArgs : EventArgs
	{
		public string Slot { get; private set; }

		public SlotCleanArgs(string slot)
		{
			Slot = slot;
		}
	}
}
