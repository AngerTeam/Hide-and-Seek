using CraftyEngine.Content;

namespace InventoryModule
{
	public class BonusesEntries : ContentItem
	{
		public int id;

		public string title;

		public int drop_size;

		public int drop_size_max;

		public override void Deserialize()
		{
			id = TryGetInt(InventoryContentKeys.id);
			intKey = id;
			title = TryGetString(InventoryContentKeys.title, string.Empty);
			drop_size = TryGetInt(InventoryContentKeys.drop_size);
			drop_size_max = TryGetInt(InventoryContentKeys.drop_size_max);
			base.Deserialize();
		}
	}
}
