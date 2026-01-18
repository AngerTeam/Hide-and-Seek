using CraftyEngine.Content;

namespace MobsModule.Content
{
	public class MapMobsEntries : ContentItem
	{
		public int id;

		public int map_id;

		public int mob_id;

		public override void Deserialize()
		{
			id = TryGetInt(MobsContentKeys.id);
			intKey = id;
			map_id = TryGetInt(MobsContentKeys.map_id);
			mob_id = TryGetInt(MobsContentKeys.mob_id);
			base.Deserialize();
		}
	}
}
