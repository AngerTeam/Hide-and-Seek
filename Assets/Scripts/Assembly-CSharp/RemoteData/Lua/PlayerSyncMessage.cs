using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData.Lua
{
	public class PlayerSyncMessage : PurchaseMessage
	{
		public PlayerSyncMainMessage[] main;

		public CommonMessage common;

		public VectorMessage[] position;

		public VectorMessage[] rotation;

		public SlotMessage[] storage;

		public CraftMessage[] craft;

		public OfferMessage[] offers;

		public CounterMessage[] counters;

		public RecipesMessage[] recipes;

		public BuildingsMessage[] buildings;

		public PvpLastIslandsMessage[] pvpLastIslands;

		public PlayerSyncMessage(PlayerSyncMainMessage[] main, CommonMessage common)
		{
			this.main = main;
			this.common = common;
		}

		public PlayerSyncMessage()
		{
		}

		public override void Deserialize(AmfObject source, bool silent)
		{
			main = GetArray<PlayerSyncMainMessage>(source, "main");
			common = GetMessage<CommonMessage>(source, "common");
			position = GetArray<VectorMessage>(source, "position", true);
			rotation = GetArray<VectorMessage>(source, "rotation", true);
			storage = GetArray<SlotMessage>(source, "storage", true);
			craft = GetArray<CraftMessage>(source, "craft", true);
			offers = GetArray<OfferMessage>(source, "offers", true);
			counters = GetArray<CounterMessage>(source, "counters", true);
			recipes = GetArray<RecipesMessage>(source, "recipes", true);
			buildings = GetArray<BuildingsMessage>(source, "buildings", true);
			pvpLastIslands = GetArray<PvpLastIslandsMessage>(source, "pvp_last_islands", true);
			base.Deserialize(source, true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PlayerSyncMessage: common: {0};\n main: {1}\n position: {2}\n rotation: {3}\n storage: {4}\n craft: {5}\n offers: {6}\n counters: {7}\n recipes: {8}\n buildings: {9}\n pvpLastIslands: {10}", common, ArrayUtils.ArrayToString(main, "\n\t"), ArrayUtils.ArrayToString(position, "\n\t"), ArrayUtils.ArrayToString(rotation, "\n\t"), ArrayUtils.ArrayToString(storage, "\n\t"), ArrayUtils.ArrayToString(craft, "\n\t"), ArrayUtils.ArrayToString(offers, "\n\t"), ArrayUtils.ArrayToString(counters, "\n\t"), ArrayUtils.ArrayToString(recipes, "\n\t"), ArrayUtils.ArrayToString(buildings, "\n\t"), ArrayUtils.ArrayToString(pvpLastIslands, "\n\t")) + base.ToString();
		}
	}
}
