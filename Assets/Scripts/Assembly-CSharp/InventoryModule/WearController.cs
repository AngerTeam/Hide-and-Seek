namespace InventoryModule
{
	public class WearController : Singleton
	{
		private InventoryModel inventoryModel_;

		public override void Init()
		{
			SingletonManager.Get<InventoryModel>(out inventoryModel_);
		}

		public void UpdateSlotWear(string slotName, int wear = 0)
		{
			SlotModel slot;
			if (inventoryModel_.GetSlotByName(slotName, out slot))
			{
				if (slot.IsEmpty)
				{
					Log.Error("Attmept to set wear to empty slot!");
				}
				else
				{
					slot.Item.Wear = wear;
				}
			}
		}

		public void UpdateSelectedSlotWear()
		{
			if (CheckIfCritical(inventoryModel_.SelectedSlot))
			{
				inventoryModel_.SelectedSlot.Clear();
				inventoryModel_.ReportSelectSlotChanged();
			}
		}

		public bool CheckIfCritical(SlotModel slot)
		{
			if (slot.IsEmpty)
			{
				return false;
			}
			if (!slot.Item.Wearable)
			{
				return false;
			}
			return slot.Item.Wear >= slot.Item.WearMax;
		}

		public static int CalculateWearout(ushort artikulId, int wearout)
		{
			int result = 0;
			ArtikulsEntries value;
			if (!InventoryContentMap.Artikuls.TryGetValue(artikulId, out value))
			{
				return result;
			}
			if (value.durability > wearout)
			{
				result = value.durability - wearout;
			}
			return result;
		}

		public void AddDigWear(SlotModel slot, int durability, int durabilityType)
		{
			if (InventoryModuleSettings.useWear && !slot.IsEmpty && slot.Item.Wearable && durability >= InventoryContentMap.CraftSettings.durabilityMinimumMargin && (slot.Entry.type_id == 3 || slot.Entry.type_id == 4))
			{
				int num = ((durabilityType == slot.Entry.durability_type_id) ? 1 : 2);
				int num2 = num;
				slot.Item.Wear += num2;
			}
		}

		public void Clear(string slotId)
		{
			SlotModel slot;
			if (inventoryModel_.GetSlotByName(slotId, out slot))
			{
				slot.Clear();
			}
		}
	}
}
