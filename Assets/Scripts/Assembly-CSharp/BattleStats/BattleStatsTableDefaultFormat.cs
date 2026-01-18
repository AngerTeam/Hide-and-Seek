using BattleStats.Hierarchy;
using CraftyEngine.Sounds;
using PlayerModule;
using UnityEngine;

namespace BattleStats
{
	public class BattleStatsTableDefaultFormat : BattleStatsTableFormat
	{
		public override string KillTitle
		{
			get
			{
				return "UI_Battle_Table_Frags";
			}
		}

		public override string NextButtonTitle
		{
			get
			{
				return "UI_Battle_Table_NextBtn";
			}
		}

		public override string RowPrefabName
		{
			get
			{
				return "UIBattleStatsRow";
			}
		}

		public override bool TwoTeams
		{
			get
			{
				return false;
			}
		}

		public override void Organize()
		{
			hierarchy.teamScore.gameObject.SetActive(false);
			hierarchy.versusHeader.gameObject.SetActive(true);
			hierarchy.tableDivider.gameObject.SetActive(false);
		}

		public override void SetLabelColor(BattleStatsRawHierarchy view, PlayerStatsModel model)
		{
			view.nickname.label.color = Color.white;
		}

		public override void SetupTitleRow(BattleStatsRawHierarchy newRow)
		{
			newRow.kills.title.text = Localisations.Get(KillTitle);
			newRow.nickname.title.text = Localisations.Get("UI_Battle_Table_Name");
			newRow.place.title.text = Localisations.Get("UI_Battle_Table_Place");
			newRow.score.title.text = Localisations.Get("UI_Battle_Table_Score");
			newRow.info.title.text = Localisations.Get("UI_Battle_Table_Info");
			newRow.infoButton.gameObject.SetActive(false);
			newRow.background.gameObject.SetActive(false);
			newRow.rewardIcon.gameObject.SetActive(false);
			newRow.rewardIcon.alpha = 0f;
		}

		public override void SetResult(int myScore, int enemyScore)
		{
			hierarchy.resultLabel.text = Localisations.Get("UI_Combat_Finished");
			hierarchy.resultLabel.effectColor = darkYellow;
			hierarchy.resultSprite.spriteName = "ribbon_yellow";
			SoundProvider.PlaySingleSound2D(68);
		}

		public override void SetScore(BattleStatsRawHierarchy view, PlayerStatsModel model, bool isResult)
		{
			view.score.label.text = model.BattleExperiance.ToString();
			view.kills.label.color = Color.white;
			view.kills.label.text = model.combat.KillFragsCount.ToString();
		}

		public override void SetTitle()
		{
			hierarchy.tableTitleLabel.text = Localisations.Get("UI_Battle_Table_Against_All");
		}
	}
}
