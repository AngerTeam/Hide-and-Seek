using UnityEngine;

namespace BattleStats.Hierarchy
{
	public class BattleStatsTableWindowHierarchy : MonoBehaviour
	{
		public int compactSizeContentHeight;

		public int hideNseekOffsetY;

		public int rowStartY;

		public int rowStepY;

		public int rowCompactStartY;

		public int rowCompactStepY;

		public int rowCompactX;

		public UICenterOnChild centerOnChild;

		public UIWidget buttonsWidget;

		public UIWidget mainWidget;

		public UIWidget windowWidget;

		public UIWidget resultWidget;

		public UIWidget rewardWidget;

		public UILabel resultLabel;

		public UISprite resultSprite;

		public UIWidget blackBackground;

		public UILabel tableTitleLabel;

		public UIWidget content;

		public UIWidget tableTitleContainer;

		public UIWidget tableTitleSecondContainer;

		public UIWidget tableDivider;

		public NguiButton homeButton;

		public NguiButton nextButton;

		public NguiButton continueButton;

		public UIScrollBar scrollBar;

		public UIPanel scrollPanel;

		public UIWidget timerWidget;

		public UILabel timerText;

		public TweenScale timerTween;

		public UIWidget teamScore;

		public UIWidget versusHeader;

		public UILabel myTeamScoreLabel;

		public UILabel enemyTeamScoreLabel;

		public UILabel myTeamTitleLabel;

		public UILabel enemyTeamTitleLabel;

		public UILabel myTeamLeaversLabel;

		public UILabel enemyTeamLeaversLabel;

		public UIGrid buttonsTable;

		public EnvelopContent buttonsEnvelop;
	}
}
