using UnityEngine;

namespace BattleStats.Hierarchy
{
	public class BattleStatsRawHierarchy : MonoBehaviour
	{
		public UIButton infoButton;

		public UISprite arrowUpSprite;

		public UISprite arrowDownSprite;

		public UISprite background;

		public UITable tableLeft;

		public UITable tableRight;

		public UIWidget container;

		public BattleStatsItemHierarchy place;

		public BattleStatsItemHierarchy nickname;

		public BattleStatsItemHierarchy score;

		public BattleStatsItemHierarchy kills;

		public BattleStatsItemHierarchy info;

		public UILabel lvlLabel;

		public UILabel rewardLabel;

		public UISprite rewardIcon;
	}
}
