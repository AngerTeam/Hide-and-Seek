using CraftyEngine.Content;

namespace AbilitiesModule.Content
{
	public class AbilityFxEntries : ContentItem
	{
		public int id;

		public int action_id;

		public int fx_id;

		public override void Deserialize()
		{
			id = TryGetInt(AbilitiesContentKeys.id);
			intKey = id;
			action_id = TryGetInt(AbilitiesContentKeys.action_id);
			fx_id = TryGetInt(AbilitiesContentKeys.fx_id);
			base.Deserialize();
		}
	}
}
