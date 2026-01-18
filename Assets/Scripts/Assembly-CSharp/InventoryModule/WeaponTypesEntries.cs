using CraftyEngine.Content;

namespace InventoryModule
{
	public class WeaponTypesEntries : ContentItem
	{
		public int id;

		public int weapon_sight_id;

		public string title;

		public string icon;

		public int melee;

		public override void Deserialize()
		{
			id = TryGetInt(InventoryContentKeys.id);
			intKey = id;
			weapon_sight_id = TryGetInt(InventoryContentKeys.weapon_sight_id);
			title = TryGetString(InventoryContentKeys.title, string.Empty);
			icon = TryGetString(InventoryContentKeys.icon, string.Empty);
			melee = TryGetInt(InventoryContentKeys.melee);
			base.Deserialize();
		}
	}
}
