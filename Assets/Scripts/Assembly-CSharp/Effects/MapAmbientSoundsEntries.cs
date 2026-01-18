using CraftyEngine.Content;

namespace Effects
{
	public class MapAmbientSoundsEntries : ContentItem
	{
		public int id;

		public string title;

		public string filename_standalone;

		public string filename_mobile;

		public float sort_val;

		public override void Deserialize()
		{
			id = TryGetInt(EffectsContentKeys.id);
			intKey = id;
			title = TryGetString(EffectsContentKeys.title, string.Empty);
			filename_standalone = TryGetString(EffectsContentKeys.filename_standalone, string.Empty);
			filename_mobile = TryGetString(EffectsContentKeys.filename_mobile, string.Empty);
			sort_val = TryGetFloat(EffectsContentKeys.sort_val);
			base.Deserialize();
		}
	}
}
