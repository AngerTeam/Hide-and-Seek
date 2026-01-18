using CraftyEngine.Content;

namespace PlayerModule
{
	public class LevelStatsEntries : ContentItem
	{
		public int id;

		public int level;

		public string stat_id;

		public int value;

		public float value_pct;

		public override void Deserialize()
		{
			id = TryGetInt(PlayerContentKeys.id);
			intKey = id;
			level = TryGetInt(PlayerContentKeys.level);
			stat_id = TryGetString(PlayerContentKeys.stat_id, string.Empty);
			value = TryGetInt(PlayerContentKeys.value);
			value_pct = TryGetFloat(PlayerContentKeys.value_pct);
			base.Deserialize();
		}
	}
}
