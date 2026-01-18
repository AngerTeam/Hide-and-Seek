using System;
using System.Collections.Generic;

namespace InventoryModule
{
	public class BonusUtils
	{
		public static bool GetDailyBonusById(List<BonusItem> bonuses, int id, out BonusItem item)
		{
			item = null;
			if (bonuses == null)
			{
				return false;
			}
			for (int i = 0; i < bonuses.Count; i++)
			{
				if (bonuses[i].artikulId == id)
				{
					item = bonuses[i];
					return true;
				}
			}
			return false;
		}

		public static List<BonusItem> ExtractBonuses(int bonusId, int playerLevel = -1, bool duplicatesEnable = false)
		{
			List<BonusItem> list = new List<BonusItem>();
			BonusesEntries value;
			if (InventoryContentMap.Bonuses.TryGetValue(bonusId, out value))
			{
				foreach (BonusItemsEntries value2 in InventoryContentMap.BonusItems.Values)
				{
					if (value2.bonus_id != value.id)
					{
						continue;
					}
					if (playerLevel >= 0)
					{
						bool flag = value2.req_level_min == 0 || playerLevel >= value2.req_level_min;
						bool flag2 = value2.req_level_max == 0 || playerLevel <= value2.req_level_max;
						if (!flag || !flag2)
						{
							continue;
						}
					}
					switch (value2.type_id)
					{
					case "MONEY":
					case "ARTIKUL":
					case "HIDE_VOXEL":
					{
						BonusItem bonusItem = new BonusItem(value2.type_id, value2.field, value2.value, value2.value2, 0);
						BonusItem item;
						if (duplicatesEnable || !GetDailyBonusById(list, bonusItem.artikulId, out item) || bonusItem.count != item.count)
						{
							list.Add(bonusItem);
						}
						break;
					}
					case "BONUS":
					{
						int bonusId2 = (ushort)Convert.ToInt32(value2.field);
						list.AddRange(ExtractBonuses(bonusId2, playerLevel, duplicatesEnable));
						break;
					}
					default:
						Log.Error("ERROR: Wrong type of bonus item.");
						break;
					}
				}
			}
			return list;
		}
	}
}
