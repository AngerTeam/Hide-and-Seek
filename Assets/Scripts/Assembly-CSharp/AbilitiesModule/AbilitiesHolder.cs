using System.Collections.Generic;
using AbilitiesModule.Content;
using CraftyEngine.Content;
using FxModule;

namespace AbilitiesModule
{
	public class AbilitiesHolder : Singleton
	{
		public Dictionary<int, AbilityModel> Abilities { get; private set; }

		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<AbilitiesContentMap>();
			GenerateAbilities();
		}

		private void GenerateAbilities()
		{
			Abilities = new Dictionary<int, AbilityModel>();
			if (AbilitiesContentMap.Abilities == null)
			{
				return;
			}
			foreach (AbilitiesEntries value in AbilitiesContentMap.Abilities.Values)
			{
				AbilityModel abilityModel = new AbilityModel(value);
				foreach (AbilityActionsEntries value2 in AbilitiesContentMap.AbilityActions.Values)
				{
					if (value2.ability_id != abilityModel.abilityId)
					{
						continue;
					}
					AbilityActionModel abilityActionModel = new AbilityActionModel(value2);
					foreach (AbilityStatsEntries value3 in AbilitiesContentMap.AbilityStats.Values)
					{
						if (value3.action_id == value2.id)
						{
							abilityActionModel.abilityStats.Add(value3);
						}
					}
					foreach (AbilityFxEntries value4 in AbilitiesContentMap.AbilityFx.Values)
					{
						if (value4.action_id == value2.id)
						{
							abilityActionModel.fxEntries.Add(FxContentMap.Fx[value4.fx_id]);
						}
					}
					abilityModel.actionModels.Add(abilityActionModel);
				}
				Abilities[abilityModel.abilityId] = abilityModel;
			}
		}
	}
}
