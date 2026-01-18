using System;
using System.Collections.Generic;
using Extensions;

namespace InventoryModule
{
	public class InventoryModel : Singleton
	{
		public SlotModel SelectedSlot { get; private set; }

		public Dictionary<char, List<SlotModel>> Slots { get; private set; }

		public SlotModel SplittingSlot { get; set; }

		public event Action<SlotModel> SlotDeleted;

		public event Action SelectedSlotChanged;

		public event Action SlotsUpdated;

		public void ClearAllSlots()
		{
			foreach (KeyValuePair<char, List<SlotModel>> slot in Slots)
			{
				for (int i = 0; i < slot.Value.Count; i++)
				{
					SlotModel slotModel = slot.Value[i];
					slotModel.Clear();
				}
			}
		}

		public void ClearTempSlots()
		{
			foreach (List<SlotModel> value in Slots.Values)
			{
				foreach (SlotModel item in value)
				{
					if (!item.IsEmpty && item.Item.IsTemp)
					{
						item.Clear();
					}
				}
			}
		}

		public bool GetSlotByName(string slotName, out SlotModel slot)
		{
			slot = null;
			char key = slotName[0];
			string s = slotName.Remove(0, 1);
			int index = int.Parse(s);
			if (!Slots.ContainsKey(key))
			{
				return false;
			}
			try
			{
				slot = Slots[key][index];
			}
			catch (Exception exc)
			{
				Log.Error("Unable to get slot {0}", slotName);
				Log.Exception(exc);
				return false;
			}
			return true;
		}

		public override void Init()
		{
			Slots = new Dictionary<char, List<SlotModel>>();
			ReportSelectSlotChanged();
		}

		public void ReportSelectSlotChanged()
		{
			this.SelectedSlotChanged.SafeInvoke();
		}

		public void SelectSlot(SlotModel slot)
		{
			if (SelectedSlot == null || SelectedSlot.name != slot.name || SelectedSlot.Item != slot.Item)
			{
				if (SelectedSlot != null)
				{
					SelectedSlot.ItemChanged -= HandleItemChanged;
					SelectedSlot.Selected = false;
				}
				SelectedSlot = slot;
				SelectedSlot.Selected = true;
				slot.ItemChanged += HandleItemChanged;
				this.SelectedSlotChanged.SafeInvoke();
			}
		}

		private void HandleItemChanged()
		{
			ReportSelectSlotChanged();
		}

		public void SetSlot(SlotModel slot, int artikul, int count, int wear = 0, bool isTemp = false)
		{
			slot.Insert(artikul, count, wear, isTemp);
		}

		public void SetSlot(string slotName, int artikul, int count, int wear = 0, bool isTemp = false)
		{
			SlotModel slot;
			if (GetSlotByName(slotName, out slot))
			{
				SetSlot(slot, artikul, count, wear, isTemp);
			}
		}

		public void ReportDeleteSlot(SlotModel slotModel)
		{
			this.SlotDeleted.SafeInvoke(slotModel);
		}

		public void ReportSlotsUpdated()
		{
			this.SlotsUpdated.SafeInvoke();
		}
	}
}
