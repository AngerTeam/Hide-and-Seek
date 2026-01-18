using CraftyEngine.Content;

namespace PlayerModule
{
	public class ArtikulStatsEntries : ContentItem
	{
		public int id;

		public int artikul_id;

		public string stat_id;

		public int value;

		public float value_pct;

		public override void Deserialize()
		{
			id = TryGetInt(PlayerContentKeys.id);
			intKey = id;
			artikul_id = TryGetInt(PlayerContentKeys.artikul_id);
			stat_id = TryGetString(PlayerContentKeys.stat_id, string.Empty);
			value = TryGetInt(PlayerContentKeys.value);
			value_pct = TryGetFloat(PlayerContentKeys.value_pct);
			base.Deserialize();
		}
	}
}
