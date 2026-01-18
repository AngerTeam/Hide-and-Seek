using CraftyEngine.Content;

namespace AbilitiesModule.Content
{
	public class AbilityStatsEntries : ContentItem
	{
		public int id;

		public int action_id;

		public string stat_id;

		public int value;

		public float value_pct;

		public override void Deserialize()
		{
			id = TryGetInt(AbilitiesContentKeys.id);
			intKey = id;
			action_id = TryGetInt(AbilitiesContentKeys.action_id);
			stat_id = TryGetString(AbilitiesContentKeys.stat_id, string.Empty);
			value = TryGetInt(AbilitiesContentKeys.value);
			value_pct = TryGetFloat(AbilitiesContentKeys.value_pct);
			base.Deserialize();
		}
	}
}
