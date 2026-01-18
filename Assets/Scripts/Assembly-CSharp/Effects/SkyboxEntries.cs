using CraftyEngine.Content;

namespace Effects
{
	public class SkyboxEntries : ContentItem
	{
		public int id;

		public string title;

		public float ambient_occlusion_power;

		public float material_normal_power;

		public string material_sky_color;

		public string material_ambient_color;

		public string clouds_color;

		public string bundle;

		public string GetFullBundlePath()
		{
			return EffectsContentKeys.GetFullBundlePath11 + bundle;
		}

		public override void Deserialize()
		{
			id = TryGetInt(EffectsContentKeys.id);
			intKey = id;
			title = TryGetString(EffectsContentKeys.title, string.Empty);
			ambient_occlusion_power = TryGetFloat(EffectsContentKeys.ambient_occlusion_power);
			material_normal_power = TryGetFloat(EffectsContentKeys.material_normal_power);
			material_sky_color = TryGetString(EffectsContentKeys.material_sky_color, string.Empty);
			material_ambient_color = TryGetString(EffectsContentKeys.material_ambient_color, string.Empty);
			clouds_color = TryGetString(EffectsContentKeys.clouds_color, string.Empty);
			bundle = TryGetString(EffectsContentKeys.bundle, string.Empty);
			base.Deserialize();
		}
	}
}
