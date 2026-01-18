using CraftyEngine.Content;

namespace AbilitiesModule.Content
{
	public class AbilityActionsEntries : ContentItem
	{
		public int id;

		public int ability_id;

		public string title;

		public int type_id;

		public int target_type;

		public float duration;

		public override void Deserialize()
		{
			id = TryGetInt(AbilitiesContentKeys.id);
			intKey = id;
			ability_id = TryGetInt(AbilitiesContentKeys.ability_id);
			title = TryGetString(AbilitiesContentKeys.title, string.Empty);
			type_id = TryGetInt(AbilitiesContentKeys.type_id);
			target_type = TryGetInt(AbilitiesContentKeys.target_type);
			duration = TryGetFloat(AbilitiesContentKeys.duration);
			base.Deserialize();
		}
	}
}
