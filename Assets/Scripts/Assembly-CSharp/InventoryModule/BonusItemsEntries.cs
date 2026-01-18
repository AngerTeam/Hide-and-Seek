using CraftyEngine.Content;

namespace InventoryModule
{
	public class BonusItemsEntries : ContentItem
	{
		public int id;

		public int bonus_id;

		public string type_id;

		public string field;

		public int value;

		public int value2;

		public int flags;

		public int prob;

		public int weight;

		public int req_level_min;

		public int req_level_max;

		public int req_stat_id;

		public int req_stat_value;

		public override void Deserialize()
		{
			id = TryGetInt(InventoryContentKeys.id);
			intKey = id;
			bonus_id = TryGetInt(InventoryContentKeys.bonus_id);
			type_id = TryGetString(InventoryContentKeys.type_id, string.Empty);
			field = TryGetString(InventoryContentKeys.field, string.Empty);
			value = TryGetInt(InventoryContentKeys.value);
			value2 = TryGetInt(InventoryContentKeys.value2);
			flags = TryGetInt(InventoryContentKeys.flags);
			prob = TryGetInt(InventoryContentKeys.prob);
			weight = TryGetInt(InventoryContentKeys.weight);
			req_level_min = TryGetInt(InventoryContentKeys.req_level_min);
			req_level_max = TryGetInt(InventoryContentKeys.req_level_max);
			req_stat_id = TryGetInt(InventoryContentKeys.req_stat_id);
			req_stat_value = TryGetInt(InventoryContentKeys.req_stat_value);
			base.Deserialize();
		}
	}
}
