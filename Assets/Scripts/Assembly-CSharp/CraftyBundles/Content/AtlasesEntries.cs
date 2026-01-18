using CraftyEngine.Content;

namespace CraftyBundles.Content
{
	public class AtlasesEntries : ContentItem
	{
		public int id;

		public string title;

		public string bundle;

		public string GetFullBundlePath()
		{
			return BundlesContentKeys.GetFullBundlePath4 + bundle;
		}

		public override void Deserialize()
		{
			id = TryGetInt(BundlesContentKeys.id);
			intKey = id;
			title = TryGetString(BundlesContentKeys.title, string.Empty);
			bundle = TryGetString(BundlesContentKeys.bundle, string.Empty);
			base.Deserialize();
		}
	}
}
