using CraftyEngine.Content;

namespace InventoryModule
{
	public class InstrumentsEntries : ContentItem
	{
		public int id;

		public string title;

		public int durability_type_id;

		public int durability;

		public int damage;

		public int damage_common;

		public override void Deserialize()
		{
			id = TryGetInt(InventoryContentKeys.id);
			intKey = id;
			title = TryGetString(InventoryContentKeys.title, string.Empty);
			durability_type_id = TryGetInt(InventoryContentKeys.durability_type_id);
			durability = TryGetInt(InventoryContentKeys.durability);
			damage = TryGetInt(InventoryContentKeys.damage);
			damage_common = TryGetInt(InventoryContentKeys.damage_common);
			base.Deserialize();
		}
	}
}
