using CraftyEngine.Content;

namespace Animations
{
	public class AnimationsEntries : ContentItem
	{
		public int id;

		public string title;

		public int type_id;

		public string bundle;

		public string bundle_split;

		public string GetFullBundlePath()
		{
			return AnimationsContentKeys.GetFullBundlePath0 + bundle;
		}

		public string GetFullBundleSplitPath()
		{
			return AnimationsContentKeys.GetFullBundleSplitPath1 + bundle_split;
		}

		public override void Deserialize()
		{
			id = TryGetInt(AnimationsContentKeys.id);
			intKey = id;
			title = TryGetString(AnimationsContentKeys.title, string.Empty);
			type_id = TryGetInt(AnimationsContentKeys.type_id);
			bundle = TryGetString(AnimationsContentKeys.bundle, string.Empty);
			bundle_split = TryGetString(AnimationsContentKeys.bundle_split, string.Empty);
			base.Deserialize();
		}
	}
}
