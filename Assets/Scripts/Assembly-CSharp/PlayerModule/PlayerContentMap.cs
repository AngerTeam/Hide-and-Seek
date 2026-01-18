using System.Collections.Generic;
using CraftyEngine.Content;

namespace PlayerModule
{
	public class PlayerContentMap : ContentMapBase
	{
		public static PlayerEntityEntries PlayerEntity;

		public static Dictionary<int, ArtikulStatsEntries> ArtikulStats;

		public static Dictionary<int, LevelStatsEntries> LevelStats;

		public static Dictionary<string, GameStatsEntries> GameStats;

		public static Dictionary<int, GameStatElementsEntries> GameStatElements;

		public override void Deserialize()
		{
			PlayerContentKeys.Deserialize();
			PlayerEntity = FillSettings<PlayerEntityEntries>("settings");
			ArtikulStats = ReadInt<ArtikulStatsEntries>(PlayerContentKeys.artikul_stats);
			LevelStats = ReadInt<LevelStatsEntries>(PlayerContentKeys.level_stats);
			GameStats = ReadString<GameStatsEntries>(PlayerContentKeys.game_stats);
			GameStatElements = ReadInt<GameStatElementsEntries>(PlayerContentKeys.game_stat_elements);
			base.Deserialize();
		}
	}
}
