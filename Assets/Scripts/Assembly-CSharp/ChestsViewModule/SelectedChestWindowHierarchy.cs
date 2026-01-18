using UnityEngine;

namespace ChestsViewModule
{
	public class SelectedChestWindowHierarchy : MonoBehaviour
	{
		public UI2DSprite icon;

		public UILabel titleLabel;

		public UILabel statusLabel;

		public UILabel timeToOpenLabel;

		public UILabel currentTimeLabel;

		public UIButton openButton;

		public UILabel openLabel;

		public UIWidget openWidget;

		public UIWidget priceWidget;

		public UILabel priceLabel;

		public UIWidget receivedItems;

		public UITable receivedItemsTable;

		public SelectedChestRewardItemHierarchy chestRewardItem;

		public UIWidget chestRewardHolder;

		public UIWidget rays;

		public UIWidget modelHolder;
	}
}
