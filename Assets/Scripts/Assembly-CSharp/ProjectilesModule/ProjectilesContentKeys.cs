namespace ProjectilesModule
{
	public class ProjectilesContentKeys
	{
		public static string id;

		public static string title;

		public static string starting_speed;

		public static string range_value;

		public static string explosion_time;

		public static string damage_radius;

		public static string damage_attenuation_factor;

		public static string voxel_damage;

		public static string player_damage;

		public static string projectiles;

		public static void Deserialize()
		{
			id = "id";
			title = "title";
			starting_speed = "starting_speed";
			range_value = "range_value";
			explosion_time = "explosion_time";
			damage_radius = "damage_radius";
			damage_attenuation_factor = "damage_attenuation_factor";
			voxel_damage = "voxel_damage";
			player_damage = "player_damage";
			projectiles = "projectiles";
		}
	}
}
