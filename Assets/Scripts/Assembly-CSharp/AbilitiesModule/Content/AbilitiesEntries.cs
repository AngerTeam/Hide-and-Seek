using CraftyEngine.Content;

namespace AbilitiesModule.Content
{
	public class AbilitiesEntries : ContentItem
	{
		public int id;

		public string title;

		public string icon;

		public float cooldown;

		public override void Deserialize()
		{
			id = TryGetInt(AbilitiesContentKeys.id);
			intKey = id;
			title = TryGetString(AbilitiesContentKeys.title, string.Empty);
			icon = TryGetString(AbilitiesContentKeys.icon, string.Empty);
			cooldown = TryGetFloat(AbilitiesContentKeys.cooldown);
			base.Deserialize();
		}
	}
}
