using UnityEngine;

namespace ChestsViewModule
{
	public class ChestRewardSlotHierarchy : MonoBehaviour
	{
		public UIWidget priceWidget;

		public UILabel priceLabel;

		public UILabel openNowLabel;

		public UIWidget openWidget;

		public UILabel openLabel;

		public UILabel statusLabel;

		public UI2DSprite icon;

		public UISprite iconEmpty;

		public UILabel timeToTakeLabel;

		public UILabel timer;

		public UIWidget timerWidget;

		public UIButton button;

		public UIWidget modelHolder;

		[Space(10f)]
		public RewardChest observedItem;
	}
}
