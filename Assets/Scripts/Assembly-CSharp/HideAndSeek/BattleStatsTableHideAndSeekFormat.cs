using BattleStats;
using BattleStats.Hierarchy;
using PlayerModule;
using UnityEngine;

namespace HideAndSeek
{
	public class BattleStatsTableHideAndSeekFormat : BattleStatsTableDefaultFormat
	{
		public override string KillTitle
		{
			get
			{
				return "UI_Battle_Table_Role";
			}
		}

		public override string NextButtonTitle
		{
			get
			{
				return "UI_HideNSeek_Table_NextBtn";
			}
		}

		public override void SetScore(BattleStatsRawHierarchy view, PlayerStatsModel model, bool isResult)
		{
			view.score.label.text = model.points.ToString();
			if (isResult && model.hideAndSeek.isLastHider)
			{
				view.kills.label.text = Localisations.Get("UI_Role_LastHider");
				view.kills.label.color = Color.green;
			}
			else if (model.Side == 3)
			{
				view.kills.label.text = Localisations.Get("UI_Role_Hide");
				view.kills.label.color = Color.green;
			}
			else if (model.Side == 4)
			{
				view.kills.label.text = Localisations.Get("UI_Role_Seek");
				view.kills.label.color = Color.red;
			}
			else
			{
				view.kills.label.text = Localisations.Get("UI_Role_Waiting");
				view.kills.label.color = Color.white;
			}
		}

		public override void SetTitle()
		{
			int hideNseekOffsetY = hierarchy.hideNseekOffsetY;
			hierarchy.content.height += hideNseekOffsetY;
			hierarchy.buttonsWidget.bottomAnchor.absolute += hideNseekOffsetY;
			hierarchy.buttonsWidget.topAnchor.absolute += hideNseekOffsetY;
			hierarchy.tableTitleLabel.text = Localisations.Get("GameType_HideAndSeek");
		}
	}
}
