using CraftyEngine.Content;

namespace MobsModule.Content
{
	public class MobItemsEntries : ContentItem
	{
		public int id;

		public int mob_id;

		public string anchor_id;

		public int artikul_id;

		public override void Deserialize()
		{
			id = TryGetInt(MobsContentKeys.id);
			intKey = id;
			mob_id = TryGetInt(MobsContentKeys.mob_id);
			anchor_id = TryGetString(MobsContentKeys.anchor_id, string.Empty);
			artikul_id = TryGetInt(MobsContentKeys.artikul_id);
			base.Deserialize();
		}
	}
}
