using CraftyEngine.Content;

namespace ArticulView
{
	public class ArtikulModelsEntries : ContentItem
	{
		public int id;

		public string title;

		public string animation;

		public string offset_first_person;

		public string offset_third_person;

		public string bundle;

		public string GetFullBundlePath()
		{
			return ArticulViewContentKeys.GetFullBundlePath4 + bundle;
		}

		public override void Deserialize()
		{
			id = TryGetInt(ArticulViewContentKeys.id);
			intKey = id;
			title = TryGetString(ArticulViewContentKeys.title, string.Empty);
			animation = TryGetString(ArticulViewContentKeys.animation, string.Empty);
			offset_first_person = TryGetString(ArticulViewContentKeys.offset_first_person, string.Empty);
			offset_third_person = TryGetString(ArticulViewContentKeys.offset_third_person, string.Empty);
			bundle = TryGetString(ArticulViewContentKeys.bundle, string.Empty);
			base.Deserialize();
		}
	}
}
