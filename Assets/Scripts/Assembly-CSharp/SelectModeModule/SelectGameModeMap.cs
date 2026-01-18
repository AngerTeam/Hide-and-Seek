using System.Collections.Generic;
using CraftyEngine.Content;

namespace SelectModeModule
{
	public class SelectGameModeMap : ContentMapBase
	{
		public static Dictionary<int, CommonIslandsEntries> CommonIslands;

		public static Dictionary<int, CommonIslandSkinsEntries> CommonIslandSkins;

		public override void Deserialize()
		{
			SelectGameModeKeys.Deserialize();
			CommonIslands = ReadInt<CommonIslandsEntries>(SelectGameModeKeys.common_islands);
			CommonIslandSkins = ReadInt<CommonIslandSkinsEntries>(SelectGameModeKeys.common_island_skins);
			base.Deserialize();
		}
	}
}
