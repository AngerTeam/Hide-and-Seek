using System.Collections.Generic;
using AbilitiesModule.Content;
using FxModule;

namespace AbilitiesModule
{
	public class AbilityActionModel
	{
		public int actionId;

		public AbilityActionsEntries abilityAction;

		public List<AbilityStatsEntries> abilityStats;

		public List<FxEntries> fxEntries;

		public AbilityActionModel(AbilityActionsEntries abilityAction)
		{
			actionId = abilityAction.id;
			this.abilityAction = abilityAction;
			abilityStats = new List<AbilityStatsEntries>();
			fxEntries = new List<FxEntries>();
		}
	}
}
