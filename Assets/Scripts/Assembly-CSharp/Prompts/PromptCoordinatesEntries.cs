using CraftyEngine.Content;

namespace Prompts
{
	public class PromptCoordinatesEntries : ContentItem
	{
		public int id;

		public int prompt_id;

		public string position;

		public string text;

		public override void Deserialize()
		{
			id = TryGetInt(PromptsKeys.id);
			intKey = id;
			prompt_id = TryGetInt(PromptsKeys.prompt_id);
			position = TryGetString(PromptsKeys.position, string.Empty);
			text = TryGetString(PromptsKeys.text, string.Empty);
			base.Deserialize();
		}
	}
}
