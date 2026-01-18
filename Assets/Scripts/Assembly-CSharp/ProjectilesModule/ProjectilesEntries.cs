using CraftyEngine.Content;

namespace ProjectilesModule
{
	public class ProjectilesEntries : ContentItem
	{
		public int id;

		public string title;

		public float starting_speed;

		public float range_value;

		public int explosion_time;

		public float damage_radius;

		public float damage_attenuation_factor;

		public int voxel_damage;

		public int player_damage;

		public override void Deserialize()
		{
			id = TryGetInt(ProjectilesContentKeys.id);
			intKey = id;
			title = TryGetString(ProjectilesContentKeys.title, string.Empty);
			starting_speed = TryGetFloat(ProjectilesContentKeys.starting_speed);
			range_value = TryGetFloat(ProjectilesContentKeys.range_value);
			explosion_time = TryGetInt(ProjectilesContentKeys.explosion_time);
			damage_radius = TryGetFloat(ProjectilesContentKeys.damage_radius);
			damage_attenuation_factor = TryGetFloat(ProjectilesContentKeys.damage_attenuation_factor);
			voxel_damage = TryGetInt(ProjectilesContentKeys.voxel_damage);
			player_damage = TryGetInt(ProjectilesContentKeys.player_damage);
			base.Deserialize();
		}
	}
}
