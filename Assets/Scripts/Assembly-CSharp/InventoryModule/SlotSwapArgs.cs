using System;

namespace InventoryModule
{
	public class SlotSwapArgs : EventArgs
	{
		public string SlotFrom { get; private set; }

		public string SlotTo { get; private set; }

		public SlotSwapArgs(string slotFrom, string slotTo)
		{
			SlotFrom = slotFrom;
			SlotTo = slotTo;
		}
	}
}
