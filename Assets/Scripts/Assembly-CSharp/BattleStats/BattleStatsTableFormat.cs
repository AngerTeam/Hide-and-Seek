using BattleStats.Hierarchy;
using PlayerModule;
using UnityEngine;

namespace BattleStats
{
	public abstract class BattleStatsTableFormat
	{
		protected Color lightBlue = new Color(0.278f, 0.584f, 1f);

		protected Color darkYellow = new Color(47f / 85f, 19f / 85f, 1f / 51f);

		protected Color red = Color.red;

		protected BattleStatsTableWindowHierarchy hierarchy;

		public abstract string RowPrefabName { get; }

		public abstract string NextButtonTitle { get; }

		public abstract bool TwoTeams { get; }

		public abstract string KillTitle { get; }

		public void SetHierarchy(BattleStatsTableWindowHierarchy hierarchy)
		{
			this.hierarchy = hierarchy;
		}

		public abstract void Organize();

		public abstract void SetTitle();

		public abstract void SetResult(int myScore, int enemyScore);

		public abstract void SetScore(BattleStatsRawHierarchy view, PlayerStatsModel model, bool isResult);

		public abstract void SetLabelColor(BattleStatsRawHierarchy view, PlayerStatsModel model);

		public abstract void SetupTitleRow(BattleStatsRawHierarchy titleRow);
	}
}
