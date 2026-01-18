using System;

namespace InventoryModule
{
	public class CraftGetResultArgs : EventArgs
	{
		public int RecipeId { get; private set; }

		public int ArticulId { get; private set; }

		public int Count { get; private set; }

		public int CraftCount { get; private set; }

		public string SlotId { get; private set; }

		public string BuildingRef { get; private set; }

		public CraftGetResultArgs(int recipeId, int articulId, int count, int craftCount, string slotId, string buildingRef)
		{
			RecipeId = recipeId;
			ArticulId = articulId;
			Count = count;
			CraftCount = craftCount;
			SlotId = slotId;
			BuildingRef = buildingRef;
		}
	}
}
