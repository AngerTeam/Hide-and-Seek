using CraftyEngine.Content;

namespace Prompts
{
	public class PromptsEntries : ContentItem
	{
		public int id;

		public string description;

		public int zone_number;

		public float progress;

		public override void Deserialize()
		{
			id = TryGetInt(PromptsKeys.id);
			intKey = id;
			description = TryGetString(PromptsKeys.description, string.Empty);
			zone_number = TryGetInt(PromptsKeys.zone_number);
			progress = TryGetFloat(PromptsKeys.progress);
			base.Deserialize();
		}
	}
}
