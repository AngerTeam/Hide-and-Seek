using CraftyEngine.Content;

namespace MobsModule.Content
{
	public class MapMobBehaviorsEntries : ContentItem
	{
		public int id;

		public int map_mob_id;

		public int behavior_time;

		public int behavior_type;

		public string spawn_point;

		public string path_points;

		public float move_radius;

		public override void Deserialize()
		{
			id = TryGetInt(MobsContentKeys.id);
			intKey = id;
			map_mob_id = TryGetInt(MobsContentKeys.map_mob_id);
			behavior_time = TryGetInt(MobsContentKeys.behavior_time);
			behavior_type = TryGetInt(MobsContentKeys.behavior_type);
			spawn_point = TryGetString(MobsContentKeys.spawn_point, string.Empty);
			path_points = TryGetString(MobsContentKeys.path_points, string.Empty);
			move_radius = TryGetFloat(MobsContentKeys.move_radius);
			base.Deserialize();
		}
	}
}
