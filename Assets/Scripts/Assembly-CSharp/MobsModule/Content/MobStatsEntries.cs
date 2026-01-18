using CraftyEngine.Content;

namespace MobsModule.Content
{
	public class MobStatsEntries : ContentItem
	{
		public int id;

		public int mob_id;

		public string stat_id;

		public int value;

		public float value_pct;

		public override void Deserialize()
		{
			id = TryGetInt(MobsContentKeys.id);
			intKey = id;
			mob_id = TryGetInt(MobsContentKeys.mob_id);
			stat_id = TryGetString(MobsContentKeys.stat_id, string.Empty);
			value = TryGetInt(MobsContentKeys.value);
			value_pct = TryGetFloat(MobsContentKeys.value_pct);
			base.Deserialize();
		}
	}
}
