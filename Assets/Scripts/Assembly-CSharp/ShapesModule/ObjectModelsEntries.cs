using CraftyEngine.Content;

namespace ShapesModule
{
	public class ObjectModelsEntries : ContentItem
	{
		public int id;

		public string title;

		public string bundle;

		public string GetFullBundlePath()
		{
			return ShapesContentKeys.GetFullBundlePath7 + bundle;
		}

		public override void Deserialize()
		{
			id = TryGetInt(ShapesContentKeys.id);
			intKey = id;
			title = TryGetString(ShapesContentKeys.title, string.Empty);
			bundle = TryGetString(ShapesContentKeys.bundle, string.Empty);
			base.Deserialize();
		}
	}
}
