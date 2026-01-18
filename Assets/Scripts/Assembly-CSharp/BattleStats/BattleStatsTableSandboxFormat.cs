namespace BattleStats
{
	public class BattleStatsTableSandboxFormat : BattleStatsTableDefaultFormat
	{
		public override string NextButtonTitle
		{
			get
			{
				return "UI_Battle_Table_Sanbox_NextBtn";
			}
		}

		public override void Organize()
		{
			base.Organize();
			hierarchy.windowWidget.gameObject.SetActive(false);
			hierarchy.rewardWidget.gameObject.SetActive(false);
		}

		public override void SetResult(int myScore, int enemyScore)
		{
			base.SetResult(myScore, enemyScore);
			hierarchy.resultLabel.text = Localisations.Get("UI_SandboxFinished");
		}
	}
}
