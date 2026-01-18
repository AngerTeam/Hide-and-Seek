using System;

namespace InventoryModule
{
	public class CraftSlotAddRemoveArgs : EventArgs
	{
		public int x;

		public int y;

		public string SlotFrom { get; private set; }

		public string SlotTo { get; private set; }

		public int Artikul { get; private set; }

		public int Count { get; private set; }

		public string BuildingRef { get; private set; }

		public CraftSlotAddRemoveArgs(string slotFrom, string slotTo, int articul, int count, string buildingRef, int x = 0, int y = 0)
		{
			SlotFrom = slotFrom;
			SlotTo = slotTo;
			Artikul = articul;
			Count = count;
			BuildingRef = buildingRef;
			this.x = x;
			this.y = y;
		}
	}
}
