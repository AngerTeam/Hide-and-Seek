using CraftyEngine.Content;

namespace HideAndSeekGame
{
	public class LocationsEntries : ContentItem
	{
		public int id;

		public int group_id;

		public int sound_group_id;

		public int ab_test_id;

		public string title;

		public string description;

		public string task_description;

		public string map_file;

		public int timer;

		public int energy;

		public int start_bonus_id;

		public int reward_bonus_id;

		public string spawn_position;

		public string spawn_rotation;

		public int flags;

		public int stars2_time;

		public float sort_val;

		public int inbuilt;

		public string prerendered_mesh;

		public string GetFullMapPath()
		{
			return HideAndSeekGametKeys.GetFullMapPath26 + map_file;
		}

		public override void Deserialize()
		{
			id = TryGetInt(HideAndSeekGametKeys.id);
			intKey = id;
			group_id = TryGetInt(HideAndSeekGametKeys.group_id);
			sound_group_id = TryGetInt(HideAndSeekGametKeys.sound_group_id);
			ab_test_id = TryGetInt(HideAndSeekGametKeys.ab_test_id);
			title = TryGetString(HideAndSeekGametKeys.title, string.Empty);
			description = TryGetString(HideAndSeekGametKeys.description, string.Empty);
			task_description = TryGetString(HideAndSeekGametKeys.task_description, string.Empty);
			map_file = TryGetString(HideAndSeekGametKeys.map_file, string.Empty);
			timer = TryGetInt(HideAndSeekGametKeys.timer);
			energy = TryGetInt(HideAndSeekGametKeys.energy);
			start_bonus_id = TryGetInt(HideAndSeekGametKeys.start_bonus_id);
			reward_bonus_id = TryGetInt(HideAndSeekGametKeys.reward_bonus_id);
			spawn_position = TryGetString(HideAndSeekGametKeys.spawn_position, string.Empty);
			spawn_rotation = TryGetString(HideAndSeekGametKeys.spawn_rotation, string.Empty);
			flags = TryGetInt(HideAndSeekGametKeys.flags);
			stars2_time = TryGetInt(HideAndSeekGametKeys.stars2_time);
			sort_val = TryGetFloat(HideAndSeekGametKeys.sort_val);
			inbuilt = TryGetInt(HideAndSeekGametKeys.inbuilt);
			prerendered_mesh = TryGetString(HideAndSeekGametKeys.prerendered_mesh, string.Empty);
			base.Deserialize();
		}
	}
}
