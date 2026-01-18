using System;
using InventoryModule;

namespace InventoryViewModule
{
	public class CraftController : SlotsViewManager
	{
		public SlotController resultCraftSlot;

		public CraftController(CraftSubwindowHierarchy subwindowHierarchy)
			: base('c', subwindowHierarchy.CraftContentsTable.transform)
		{
			int slotSizeWorkbenchCraft = InventoryContentMap.CraftSettings.slotSizeWorkbenchCraft;
			int num = (int)Math.Sqrt(slotSizeWorkbenchCraft);
			subwindowHierarchy.CraftContentsTable.columns = num;
			int num2 = 0;
			int num3 = 0;
			for (int i = 0; i < base.Slots.Count; i++)
			{
				SlotController slotController = base.Slots[i];
				slotController.Model.x = num2;
				slotController.Model.y = num3;
				num2++;
				if (num2 == num)
				{
					num2 = 0;
					num3++;
				}
			}
			subwindowHierarchy.CraftContentsTable.Reposition();
			resultCraftSlot = new SlotController(SlotViewType.Normal, new SlotModel());
			resultCraftSlot.Model.CanDrop = false;
			resultCraftSlot.SetParent(subwindowHierarchy.CraftResultSlotContainer.transform);
			resultCraftSlot.Redraw();
		}

		public override void Dispose()
		{
			base.Dispose();
			resultCraftSlot.Dispose();
			resultCraftSlot = null;
		}
	}
}
