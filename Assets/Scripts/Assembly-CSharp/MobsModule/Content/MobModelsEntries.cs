using CraftyEngine.Content;

namespace MobsModule.Content
{
	public class MobModelsEntries : ContentItem
	{
		public int id;

		public string title;

		public string bundle;

		public override void Deserialize()
		{
			id = TryGetInt(MobsContentKeys.id);
			intKey = id;
			title = TryGetString(MobsContentKeys.title, string.Empty);
			bundle = TryGetString(MobsContentKeys.bundle, string.Empty);
			base.Deserialize();
		}
	}
}
