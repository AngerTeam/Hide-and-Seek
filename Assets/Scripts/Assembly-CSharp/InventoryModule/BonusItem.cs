using System;

namespace InventoryModule
{
	public class BonusItem
	{
		public BonusItemType bonusItemType;

		public ushort artikulId;

		public ushort hideVoxelId;

		public int count;

		public int wear;

		public bool temp;

		public BonusItem(string typeId, string id, int count, int wearout, int flags)
		{
			switch (typeId)
			{
			case "ARTIKUL":
				bonusItemType = BonusItemType.Artikul;
				artikulId = (ushort)Convert.ToInt32(id);
				temp = BitMath.GetBit((byte)flags, 0);
				wear = ((wearout != 0) ? WearController.CalculateWearout(artikulId, wearout) : 0);
				break;
			case "MONEY":
				bonusItemType = BonusItemType.Money;
				break;
			case "HIDE_VOXEL":
				bonusItemType = BonusItemType.HideVoxel;
				hideVoxelId = (ushort)Convert.ToInt32(id);
				break;
			}
			this.count = count;
		}
	}
}
