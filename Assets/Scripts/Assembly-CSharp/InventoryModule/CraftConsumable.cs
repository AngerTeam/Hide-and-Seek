namespace InventoryModule
{
	public class CraftConsumable
	{
		public int ArtikulId { get; private set; }

		public int Count { get; private set; }

		public CraftConsumable(int artikulId, int count)
		{
			ArtikulId = artikulId;
			Count = count;
		}
	}
}
