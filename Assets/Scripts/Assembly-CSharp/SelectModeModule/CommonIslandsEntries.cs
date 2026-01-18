using CraftyEngine.Content;

namespace SelectModeModule
{
	public class CommonIslandsEntries : ContentItem
	{
		public int id;

		public string title;

		public string description;

		public float sort_val;

		public int level;

		public string loading_description;

		public string large_icon;

		public string large_icon_preview;

		public string map_file;

		public int map_size;

		public int mode_id;

		public int pvp_mode_id;

		public int players_limit;

		public int ttl;

		public int forbidden_time_left;

		public int idle_timeout;

		public int hide_timeout;

		public int seek_timeout;

		public int hide_fight_timeout;

		public int hide_players_limit;

		public int hide_points;

		public int seek_points;

		public int kill_points;

		public int exp_for_point;

		public int team_reward_money;

		public int flags;

		public int critical_height;

		public int sound_group_id;

		public string killcam_position;

		public string killcam_rotation;

		public int death_coordinate;

		public string prerendered_mesh;

		public string GetFullLargeIconPath()
		{
			return SelectGameModeKeys.GetFullLargeIconPath24 + large_icon;
		}

		public string GetFullMapPath()
		{
			return SelectGameModeKeys.GetFullMapPath25 + map_file;
		}

		public override void Deserialize()
		{
			id = TryGetInt(SelectGameModeKeys.id);
			intKey = id;
			title = TryGetString(SelectGameModeKeys.title, string.Empty);
			description = TryGetString(SelectGameModeKeys.description, string.Empty);
			sort_val = TryGetFloat(SelectGameModeKeys.sort_val);
			level = TryGetInt(SelectGameModeKeys.level);
			loading_description = TryGetString(SelectGameModeKeys.loading_description, string.Empty);
			large_icon = TryGetString(SelectGameModeKeys.large_icon, string.Empty);
			large_icon_preview = TryGetString(SelectGameModeKeys.large_icon_preview, string.Empty);
			map_file = TryGetString(SelectGameModeKeys.map_file, string.Empty);
			map_size = TryGetInt(SelectGameModeKeys.map_size);
			mode_id = TryGetInt(SelectGameModeKeys.mode_id);
			pvp_mode_id = TryGetInt(SelectGameModeKeys.pvp_mode_id);
			players_limit = TryGetInt(SelectGameModeKeys.players_limit);
			ttl = TryGetInt(SelectGameModeKeys.ttl);
			forbidden_time_left = TryGetInt(SelectGameModeKeys.forbidden_time_left);
			idle_timeout = TryGetInt(SelectGameModeKeys.idle_timeout);
			hide_timeout = TryGetInt(SelectGameModeKeys.hide_timeout);
			seek_timeout = TryGetInt(SelectGameModeKeys.seek_timeout);
			hide_fight_timeout = TryGetInt(SelectGameModeKeys.hide_fight_timeout);
			hide_players_limit = TryGetInt(SelectGameModeKeys.hide_players_limit);
			hide_points = TryGetInt(SelectGameModeKeys.hide_points);
			seek_points = TryGetInt(SelectGameModeKeys.seek_points);
			kill_points = TryGetInt(SelectGameModeKeys.kill_points);
			exp_for_point = TryGetInt(SelectGameModeKeys.exp_for_point);
			team_reward_money = TryGetInt(SelectGameModeKeys.team_reward_money);
			flags = TryGetInt(SelectGameModeKeys.flags);
			critical_height = TryGetInt(SelectGameModeKeys.critical_height);
			sound_group_id = TryGetInt(SelectGameModeKeys.sound_group_id);
			killcam_position = TryGetString(SelectGameModeKeys.killcam_position, string.Empty);
			killcam_rotation = TryGetString(SelectGameModeKeys.killcam_rotation, string.Empty);
			death_coordinate = TryGetInt(SelectGameModeKeys.death_coordinate);
			prerendered_mesh = TryGetString(SelectGameModeKeys.prerendered_mesh, string.Empty);
			base.Deserialize();
		}
	}
}
