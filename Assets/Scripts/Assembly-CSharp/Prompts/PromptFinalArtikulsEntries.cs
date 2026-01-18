using CraftyEngine.Content;

namespace Prompts
{
	public class PromptFinalArtikulsEntries : ContentItem
	{
		public int id;

		public int prompt_id;

		public int artikul_id;

		public int cnt;

		public override void Deserialize()
		{
			id = TryGetInt(PromptsKeys.id);
			intKey = id;
			prompt_id = TryGetInt(PromptsKeys.prompt_id);
			artikul_id = TryGetInt(PromptsKeys.artikul_id);
			cnt = TryGetInt(PromptsKeys.cnt);
			base.Deserialize();
		}
	}
}
