using System.Collections.Generic;
using CraftyEngine.Content;

namespace AbilitiesModule.Content
{
	public class AbilitiesContentMap : ContentMapBase
	{
		public static Dictionary<int, AbilitiesEntries> Abilities;

		public static Dictionary<int, AbilityActionsEntries> AbilityActions;

		public static Dictionary<int, AbilityStatsEntries> AbilityStats;

		public static Dictionary<int, AbilityFxEntries> AbilityFx;

		public override void Deserialize()
		{
			AbilitiesContentKeys.Deserialize();
			Abilities = ReadInt<AbilitiesEntries>(AbilitiesContentKeys.abilities);
			AbilityActions = ReadInt<AbilityActionsEntries>(AbilitiesContentKeys.ability_actions);
			AbilityStats = ReadInt<AbilityStatsEntries>(AbilitiesContentKeys.ability_stats);
			AbilityFx = ReadInt<AbilityFxEntries>(AbilitiesContentKeys.ability_fx);
			base.Deserialize();
		}
	}
}
