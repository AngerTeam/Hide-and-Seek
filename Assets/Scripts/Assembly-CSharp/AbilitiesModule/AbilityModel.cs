using System.Collections.Generic;
using AbilitiesModule.Content;

namespace AbilitiesModule
{
	public class AbilityModel
	{
		public int abilityId;

		public AbilitiesEntries ability;

		public List<AbilityActionModel> actionModels;

		public AbilityModel(AbilitiesEntries ability)
		{
			abilityId = ability.id;
			this.ability = ability;
			actionModels = new List<AbilityActionModel>();
		}
	}
}
