using CraftyEngine.Content;

namespace MobsModule.Content
{
	public class MobsEntries : ContentItem
	{
		public int id;

		public int type_id;

		public string title;

		public string description;

		public int model_id;

		public int skin_id;

		public int animation_id;

		public int sound_group_id;

		public float size;

		public int level;

		public int exp;

		public int bonus_id;

		public int respawn_time_min;

		public int respawn_time_max;

		public int aggression;

		public float aggro_radius;

		public int aggro_back;

		public int social;

		public float social_aggro_radius;

		public float speed;

		public float jump_height;

		public int flying;

		public float flight_height;

		public int gender;

		public string picture;

		public string preview_picture;

		public float sort_val;

		public int hp;

		public int idle_sound_group_id;

		public int dead_sound_id;

		public float sound_interval_min;

		public float sound_interval_max;

		public string bundle;

		public string GetFullBundlePath()
		{
			return MobsContentKeys.GetFullBundlePath7 + bundle;
		}

		public override void Deserialize()
		{
			id = TryGetInt(MobsContentKeys.id);
			intKey = id;
			type_id = TryGetInt(MobsContentKeys.type_id);
			title = TryGetString(MobsContentKeys.title, string.Empty);
			description = TryGetString(MobsContentKeys.description, string.Empty);
			model_id = TryGetInt(MobsContentKeys.model_id);
			skin_id = TryGetInt(MobsContentKeys.skin_id);
			animation_id = TryGetInt(MobsContentKeys.animation_id);
			sound_group_id = TryGetInt(MobsContentKeys.sound_group_id);
			size = TryGetFloat(MobsContentKeys.size);
			level = TryGetInt(MobsContentKeys.level);
			exp = TryGetInt(MobsContentKeys.exp);
			bonus_id = TryGetInt(MobsContentKeys.bonus_id);
			respawn_time_min = TryGetInt(MobsContentKeys.respawn_time_min);
			respawn_time_max = TryGetInt(MobsContentKeys.respawn_time_max);
			aggression = TryGetInt(MobsContentKeys.aggression);
			aggro_radius = TryGetFloat(MobsContentKeys.aggro_radius);
			aggro_back = TryGetInt(MobsContentKeys.aggro_back);
			social = TryGetInt(MobsContentKeys.social);
			social_aggro_radius = TryGetFloat(MobsContentKeys.social_aggro_radius);
			speed = TryGetFloat(MobsContentKeys.speed);
			jump_height = TryGetFloat(MobsContentKeys.jump_height);
			flying = TryGetInt(MobsContentKeys.flying);
			flight_height = TryGetFloat(MobsContentKeys.flight_height);
			gender = TryGetInt(MobsContentKeys.gender);
			picture = TryGetString(MobsContentKeys.picture, string.Empty);
			preview_picture = TryGetString(MobsContentKeys.preview_picture, string.Empty);
			sort_val = TryGetFloat(MobsContentKeys.sort_val);
			hp = TryGetInt(MobsContentKeys.hp);
			idle_sound_group_id = TryGetInt(MobsContentKeys.idle_sound_group_id);
			dead_sound_id = TryGetInt(MobsContentKeys.dead_sound_id);
			sound_interval_min = TryGetFloat(MobsContentKeys.sound_interval_min);
			sound_interval_max = TryGetFloat(MobsContentKeys.sound_interval_max);
			bundle = TryGetString(MobsContentKeys.bundle, string.Empty);
			base.Deserialize();
		}
	}
}
