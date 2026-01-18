using System;

namespace InventoryModule
{
	public class SlotMoveArgs : EventArgs
	{
		public string SlotFrom { get; private set; }

		public string SlotTo { get; private set; }

		public int Artikul { get; private set; }

		public int Count { get; private set; }

		public SlotMoveArgs(string slotFrom, string slotTo, int artikul, int count)
		{
			SlotFrom = slotFrom;
			SlotTo = slotTo;
			Artikul = artikul;
			Count = count;
		}
	}
}
