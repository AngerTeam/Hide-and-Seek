using CraftyEngine.Content;

namespace InventoryModule
{
	public class RarityEntries : ContentItem
	{
		public int id;

		public string title;

		public string color;

		public string background_sprite_name;

		public override void Deserialize()
		{
			id = TryGetInt(InventoryContentKeys.id);
			intKey = id;
			title = TryGetString(InventoryContentKeys.title, string.Empty);
			color = TryGetString(InventoryContentKeys.color, string.Empty);
			background_sprite_name = TryGetString(InventoryContentKeys.background_sprite_name, string.Empty);
			base.Deserialize();
		}
	}
}
