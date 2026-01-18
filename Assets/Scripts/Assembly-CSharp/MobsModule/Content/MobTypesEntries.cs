using CraftyEngine.Content;

namespace MobsModule.Content
{
	public class MobTypesEntries : ContentItem
	{
		public int id;

		public string title;

		public override void Deserialize()
		{
			id = TryGetInt(MobsContentKeys.id);
			intKey = id;
			title = TryGetString(MobsContentKeys.title, string.Empty);
			base.Deserialize();
		}
	}
}
