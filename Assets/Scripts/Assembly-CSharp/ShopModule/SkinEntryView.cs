using ArticulView;

namespace ShopModule
{
	public class SkinEntryView
	{
		public bool isBought;

		public SkinsEntries skinData;

		public SkinEntryView(bool isOnSale, SkinsEntries entry)
		{
			isBought = isOnSale;
			skinData = entry;
		}
	}
}
