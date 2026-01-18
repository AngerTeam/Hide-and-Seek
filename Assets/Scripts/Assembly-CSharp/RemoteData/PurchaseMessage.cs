using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData
{
	public class PurchaseMessage : RemoteMessage
	{
		public SlotMessage[] slotUpdate;

		public SlotMessage[] slots;

		public MoneyMessage[] moneyUpdate;

		public MoneyMessage[] money;

		public HideVoxelsMessage[] hideVoxelUpdate;

		public HideVoxelsMessage[] hideVoxels;

		public BonusItemMessage[] bonusItems;

		public SkinsMessage[] skins;

		public override void Deserialize(AmfObject source, bool silent)
		{
			slotUpdate = GetArray<SlotMessage>(source, "slot_update", true);
			slots = GetArray<SlotMessage>(source, "slots", true);
			moneyUpdate = GetArray<MoneyMessage>(source, "money_update", true);
			money = GetArray<MoneyMessage>(source, "money", true);
			hideVoxelUpdate = GetArray<HideVoxelsMessage>(source, "hide_voxel_update", true);
			hideVoxels = GetArray<HideVoxelsMessage>(source, "hide_voxels", true);
			bonusItems = GetArray<BonusItemMessage>(source, "bonus_items", true);
			skins = GetArray<SkinsMessage>(source, "skins", true);
			if (!silent)
			{
				Log.Online(ToString());
			}
		}

		public override string ToString()
		{
			return string.Format("PurchaseMessage:\n slotUpdate: {0}\n slots: {1}\n moneyUpdate: {2}\n money: {3}\n hideVoxelUpdate: {4}\n hideVoxels: {5}\n bonusItems: {6}\n skins: {7}", ArrayUtils.ArrayToString(slotUpdate, "\n\t"), ArrayUtils.ArrayToString(slots, "\n\t"), ArrayUtils.ArrayToString(moneyUpdate, "\n\t"), ArrayUtils.ArrayToString(money, "\n\t"), ArrayUtils.ArrayToString(hideVoxelUpdate, "\n\t"), ArrayUtils.ArrayToString(hideVoxels, "\n\t"), ArrayUtils.ArrayToString(bonusItems, "\n\t"), ArrayUtils.ArrayToString(skins, "\n\t"));
		}
	}
}
