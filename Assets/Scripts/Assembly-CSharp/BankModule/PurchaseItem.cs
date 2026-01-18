namespace BankModule
{
	public class PurchaseItem
	{
		public int id;

		public bool gift;

		public PurchaseItemType type;

		public PurchaseItem(int id, bool gift, PurchaseItemType type)
		{
			this.id = id;
			this.gift = gift;
			this.type = type;
		}
	}
}
