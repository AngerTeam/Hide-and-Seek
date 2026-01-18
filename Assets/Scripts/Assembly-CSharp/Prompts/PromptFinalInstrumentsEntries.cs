using CraftyEngine.Content;

namespace Prompts
{
	public class PromptFinalInstrumentsEntries : ContentItem
	{
		public int id;

		public int prompt_id;

		public int durability_type_id;

		public int durability_min;

		public override void Deserialize()
		{
			id = TryGetInt(PromptsKeys.id);
			intKey = id;
			prompt_id = TryGetInt(PromptsKeys.prompt_id);
			durability_type_id = TryGetInt(PromptsKeys.durability_type_id);
			durability_min = TryGetInt(PromptsKeys.durability_min);
			base.Deserialize();
		}
	}
}
