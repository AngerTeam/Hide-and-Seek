using CraftyEngine.Content;

namespace PvpModule.Content
{
	public class TerrainsEntries : ContentItem
	{
		public int id;

		public string title;

		public string icon;

		public string GetFullIconPath()
		{
			return PvpModuleContentKeys.GetFullIconPath18 + icon;
		}

		public override void Deserialize()
		{
			id = TryGetInt(PvpModuleContentKeys.id);
			intKey = id;
			title = TryGetString(PvpModuleContentKeys.title, string.Empty);
			icon = TryGetString(PvpModuleContentKeys.icon, string.Empty);
			base.Deserialize();
		}
	}
}
