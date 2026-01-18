using System.Collections.Generic;
using CraftyEngine.Content;

namespace MobsModule.Content
{
	public class MobsContentMap : ContentMapBase
	{
		public static Dictionary<int, MobsEntries> Mobs;

		public static Dictionary<int, MobItemsEntries> MobItems;

		public static Dictionary<int, MobStatsEntries> MobStats;

		public static Dictionary<int, MobWeaponsEntries> MobWeapons;

		public static Dictionary<int, MobTypesEntries> MobTypes;

		public static Dictionary<int, MobModelsEntries> MobModels;

		public static Dictionary<int, MapMobsEntries> MapMobs;

		public static Dictionary<int, MapMobBehaviorsEntries> MapMobBehaviors;

		public override void Deserialize()
		{
			MobsContentKeys.Deserialize();
			Mobs = ReadInt<MobsEntries>(MobsContentKeys.mobs);
			MobItems = ReadInt<MobItemsEntries>(MobsContentKeys.mob_items);
			MobStats = ReadInt<MobStatsEntries>(MobsContentKeys.mob_stats);
			MobWeapons = ReadInt<MobWeaponsEntries>(MobsContentKeys.mob_weapons);
			MobTypes = ReadInt<MobTypesEntries>(MobsContentKeys.mob_types);
			MobModels = ReadInt<MobModelsEntries>(MobsContentKeys.mob_models);
			MapMobs = ReadInt<MapMobsEntries>(MobsContentKeys.map_mobs);
			MapMobBehaviors = ReadInt<MapMobBehaviorsEntries>(MobsContentKeys.map_mob_behaviors);
			base.Deserialize();
		}
	}
}
