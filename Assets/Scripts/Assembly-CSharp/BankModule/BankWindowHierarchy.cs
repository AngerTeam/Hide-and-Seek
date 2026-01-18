using UnityEngine;

namespace BankModule
{
	public class BankWindowHierarchy : MonoBehaviour
	{
		public GameObject online;

		public GameObject offline;

		public UILabel offlineLabel;

		public UIButton retryButton;

		public UILabel retryButtonLabel;

		public UILabel title;

		public UILabel bestPriceLabel;

		public UILabel specialOfferLabel;

		public UILabel playersChoiceLabel;

		public StoreItemHierarchy[] storeItems;
	}
}
