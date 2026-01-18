using CraftyEngine.Content;

namespace PvpModule.Content
{
	public class PvpModesEntries : ContentItem
	{
		public int id;

		public string title;

		public string description;

		public string icon;

		public float sort_val;

		public int comming_soon;

		public int is_active;

		public int rnd_weight;

		public int flags;

		public int forbidden_time_left;

		public int ttl_min;

		public int ttl_max;

		public int ttl_def;

		public int players_limit_min;

		public int players_limit_max;

		public int players_limit_def;

		public int idle_timeout_min;

		public int idle_timeout_max;

		public int idle_timeout_def;

		public int hide_timeout_min;

		public int hide_timeout_max;

		public int hide_timeout_def;

		public int seek_timeout_min;

		public int seek_timeout_max;

		public int seek_timeout_def;

		public int hide_fight_timeout_min;

		public int hide_fight_timeout_max;

		public int hide_fight_timeout_def;

		public int hide_players_limit_min;

		public int hide_players_limit_max;

		public int hide_players_limit_def;

		public int hide_points;

		public int seek_points;

		public int kill_points;

		public int exp_for_point;

		public int critical_height_min;

		public int critical_height_max;

		public int critical_height_def;

		public string GetFullIconPath()
		{
			return PvpModuleContentKeys.GetFullIconPath11 + icon;
		}

		public override void Deserialize()
		{
			id = TryGetInt(PvpModuleContentKeys.id);
			intKey = id;
			title = TryGetString(PvpModuleContentKeys.title, string.Empty);
			description = TryGetString(PvpModuleContentKeys.description, string.Empty);
			icon = TryGetString(PvpModuleContentKeys.icon, string.Empty);
			sort_val = TryGetFloat(PvpModuleContentKeys.sort_val);
			comming_soon = TryGetInt(PvpModuleContentKeys.comming_soon);
			is_active = TryGetInt(PvpModuleContentKeys.is_active);
			rnd_weight = TryGetInt(PvpModuleContentKeys.rnd_weight);
			flags = TryGetInt(PvpModuleContentKeys.flags);
			forbidden_time_left = TryGetInt(PvpModuleContentKeys.forbidden_time_left);
			ttl_min = TryGetInt(PvpModuleContentKeys.ttl_min);
			ttl_max = TryGetInt(PvpModuleContentKeys.ttl_max);
			ttl_def = TryGetInt(PvpModuleContentKeys.ttl_def);
			players_limit_min = TryGetInt(PvpModuleContentKeys.players_limit_min);
			players_limit_max = TryGetInt(PvpModuleContentKeys.players_limit_max);
			players_limit_def = TryGetInt(PvpModuleContentKeys.players_limit_def);
			idle_timeout_min = TryGetInt(PvpModuleContentKeys.idle_timeout_min);
			idle_timeout_max = TryGetInt(PvpModuleContentKeys.idle_timeout_max);
			idle_timeout_def = TryGetInt(PvpModuleContentKeys.idle_timeout_def);
			hide_timeout_min = TryGetInt(PvpModuleContentKeys.hide_timeout_min);
			hide_timeout_max = TryGetInt(PvpModuleContentKeys.hide_timeout_max);
			hide_timeout_def = TryGetInt(PvpModuleContentKeys.hide_timeout_def);
			seek_timeout_min = TryGetInt(PvpModuleContentKeys.seek_timeout_min);
			seek_timeout_max = TryGetInt(PvpModuleContentKeys.seek_timeout_max);
			seek_timeout_def = TryGetInt(PvpModuleContentKeys.seek_timeout_def);
			hide_fight_timeout_min = TryGetInt(PvpModuleContentKeys.hide_fight_timeout_min);
			hide_fight_timeout_max = TryGetInt(PvpModuleContentKeys.hide_fight_timeout_max);
			hide_fight_timeout_def = TryGetInt(PvpModuleContentKeys.hide_fight_timeout_def);
			hide_players_limit_min = TryGetInt(PvpModuleContentKeys.hide_players_limit_min);
			hide_players_limit_max = TryGetInt(PvpModuleContentKeys.hide_players_limit_max);
			hide_players_limit_def = TryGetInt(PvpModuleContentKeys.hide_players_limit_def);
			hide_points = TryGetInt(PvpModuleContentKeys.hide_points);
			seek_points = TryGetInt(PvpModuleContentKeys.seek_points);
			kill_points = TryGetInt(PvpModuleContentKeys.kill_points);
			exp_for_point = TryGetInt(PvpModuleContentKeys.exp_for_point);
			critical_height_min = TryGetInt(PvpModuleContentKeys.critical_height_min);
			critical_height_max = TryGetInt(PvpModuleContentKeys.critical_height_max);
			critical_height_def = TryGetInt(PvpModuleContentKeys.critical_height_def);
			base.Deserialize();
		}
	}
}
