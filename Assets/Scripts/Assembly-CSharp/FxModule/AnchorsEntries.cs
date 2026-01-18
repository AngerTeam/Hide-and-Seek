using CraftyEngine.Content;

namespace FxModule
{
	public class AnchorsEntries : ContentItem
	{
		public int id;

		public string name;

		public string title;

		public override void Deserialize()
		{
			id = TryGetInt(FxContentKeys.id);
			intKey = id;
			name = TryGetString(FxContentKeys.name, string.Empty);
			title = TryGetString(FxContentKeys.title, string.Empty);
			base.Deserialize();
		}
	}
}
