using CraftyEngine.Content;

namespace Prompts
{
	public class LocationPromptsEntries : ContentItem
	{
		public int id;

		public int location_id;

		public int prompt_id;

		public override void Deserialize()
		{
			id = TryGetInt(PromptsKeys.id);
			intKey = id;
			location_id = TryGetInt(PromptsKeys.location_id);
			prompt_id = TryGetInt(PromptsKeys.prompt_id);
			base.Deserialize();
		}
	}
}
