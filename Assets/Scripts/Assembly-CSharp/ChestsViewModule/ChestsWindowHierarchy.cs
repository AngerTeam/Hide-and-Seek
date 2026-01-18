using UnityEngine;

namespace ChestsViewModule
{
	public class ChestsWindowHierarchy : MonoBehaviour
	{
		public UILabel title;

		public UILabel combatRewardsTitle;

		public UIGrid chestsGrid;

		[Header("Ads Chest")]
		public UIButton adsButton;

		public UI2DSprite adsIcon;

		public UILabel adsLabel;

		public UILabel adsNotAvailableLabel;

		public UILabel adsOpenLabel;

		public UIWidget adsTakeWidget;

		public UIWidget adsTimeWidget;

		public UILabel adsAvailableInLabel;

		public UILabel adsTimeCountLabel;

		public UIWidget adsModelHolder;

		[Header("Assassins Chest")]
		public UIButton assassinsButton;

		public UI2DSprite assassinsIcon;

		public UILabel assassinsLabel;

		public UILabel assassinsOpenLabel;

		public UIWidget assassinsTakeWidget;

		public UIWidget assassinsKillsWidget;

		public UILabel assassinsKillsLabel;

		public UISlider assassinsKillsSlider;

		public UILabel assassinsKillsCountLabel;

		public UIWidget assassinsModelHolder;

		[Header("Daily Chest")]
		public UIButton dailyButton;

		public UI2DSprite dailyIcon;

		public UILabel dailyLabel;

		public UILabel dailyOpenLabel;

		public UIWidget dailyTakeWidget;

		public UILabel dailyNotAvailableInLabel;

		public UIWidget dailyModelHolder;

		public UILabel dailyTimeCountLabel;
	}
}
