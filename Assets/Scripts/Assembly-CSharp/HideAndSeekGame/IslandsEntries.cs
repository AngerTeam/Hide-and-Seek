using CraftyEngine.Content;

namespace HideAndSeekGame
{
	public class IslandsEntries : ContentItem
	{
		public int template_id;

		public string map_file;

		public string client_map_file;

		public int changeable_area_x1;

		public int changeable_area_x2;

		public int changeable_area_z1;

		public int changeable_area_z2;

		public int sound_group_id;

		public string prerendered_mesh;

		public string GetFullClientMapPath()
		{
			return HideAndSeekGametKeys.GetFullClientMapPath23 + client_map_file;
		}

		public override void Deserialize()
		{
			template_id = TryGetInt(HideAndSeekGametKeys.template_id);
			intKey = template_id;
			map_file = TryGetString(HideAndSeekGametKeys.map_file, string.Empty);
			client_map_file = TryGetString(HideAndSeekGametKeys.client_map_file, string.Empty);
			changeable_area_x1 = TryGetInt(HideAndSeekGametKeys.changeable_area_x1);
			changeable_area_x2 = TryGetInt(HideAndSeekGametKeys.changeable_area_x2);
			changeable_area_z1 = TryGetInt(HideAndSeekGametKeys.changeable_area_z1);
			changeable_area_z2 = TryGetInt(HideAndSeekGametKeys.changeable_area_z2);
			sound_group_id = TryGetInt(HideAndSeekGametKeys.sound_group_id);
			prerendered_mesh = TryGetString(HideAndSeekGametKeys.prerendered_mesh, string.Empty);
			base.Deserialize();
		}
	}
}
