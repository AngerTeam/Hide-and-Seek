using CraftyEngine.Content;

namespace PlayerModule
{
	public class GameStatElementsEntries : ContentItem
	{
		public int id;

		public string stat_id;

		public string element_stat_id;

		public int value;

		public float value_pct;

		public override void Deserialize()
		{
			id = TryGetInt(PlayerContentKeys.id);
			intKey = id;
			stat_id = TryGetString(PlayerContentKeys.stat_id, string.Empty);
			element_stat_id = TryGetString(PlayerContentKeys.element_stat_id, string.Empty);
			value = TryGetInt(PlayerContentKeys.value);
			value_pct = TryGetFloat(PlayerContentKeys.value_pct);
			base.Deserialize();
		}
	}
}
