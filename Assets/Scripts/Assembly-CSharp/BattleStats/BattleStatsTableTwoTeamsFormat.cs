using BattleStats.Hierarchy;
using CraftyEngine.Sounds;
using PlayerModule;
using UnityEngine;

namespace BattleStats
{
	public class BattleStatsTableTwoTeamsFormat : BattleStatsTableDefaultFormat
	{
		public override string RowPrefabName
		{
			get
			{
				return "UIBattleStatsRowCompact";
			}
		}

		public override bool TwoTeams
		{
			get
			{
				return true;
			}
		}

		public override void Organize()
		{
			hierarchy.teamScore.gameObject.SetActive(true);
			hierarchy.versusHeader.gameObject.SetActive(false);
			hierarchy.tableDivider.gameObject.SetActive(true);
		}

		public override void SetLabelColor(BattleStatsRawHierarchy view, PlayerStatsModel model)
		{
			view.nickname.label.color = ((!model.InMyPlayerTeam) ? Color.red : lightBlue);
		}

		public override void SetResult(int myScore, int enemyScore)
		{
			if (myScore > enemyScore)
			{
				hierarchy.resultLabel.text = Localisations.Get("UI_Result_Victory");
				hierarchy.resultLabel.effectColor = darkYellow;
				hierarchy.resultSprite.spriteName = "ribbon_yellow";
				SoundProvider.PlaySingleSound2D(66);
			}
			else if (myScore == enemyScore)
			{
				hierarchy.resultLabel.text = Localisations.Get("UI_Result_Draw");
				hierarchy.resultLabel.effectColor = lightBlue;
				hierarchy.resultSprite.spriteName = "ribbon_blue";
				SoundProvider.PlaySingleSound2D(68);
			}
			else
			{
				hierarchy.resultLabel.text = Localisations.Get("UI_Result_Defeat");
				hierarchy.resultLabel.effectColor = red;
				hierarchy.resultSprite.spriteName = "ribbon_red";
				SoundProvider.PlaySingleSound2D(67);
			}
		}

		public override void SetTitle()
		{
			hierarchy.tableTitleLabel.text = string.Empty;
			hierarchy.myTeamTitleLabel.text = Localisations.Get("UI_Your_Team");
			hierarchy.enemyTeamTitleLabel.text = Localisations.Get("UI_Enemy_Team");
		}
	}
}
