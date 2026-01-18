using CraftyEngine.Content;

namespace SoundsModule
{
	public class SoundGroupsEntries : ContentItem
	{
		public int id;

		public string title;

		public override void Deserialize()
		{
			id = TryGetInt(SoundsContentKeys.id);
			intKey = id;
			title = TryGetString(SoundsContentKeys.title, string.Empty);
			base.Deserialize();
		}
	}
}
