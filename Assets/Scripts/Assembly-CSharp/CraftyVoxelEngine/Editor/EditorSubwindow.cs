using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using InventoryModule;
using InventoryViewModule;

namespace CraftyVoxelEngine.Editor
{
	public class EditorSubwindow : BackpackSubwindow
	{
		private InventoryInteractionController controller_;

		private VoxelInventoryModel voxelInventoryModel_;

		private char type_;

		private LogicVoxelManager logicVoxelManager;

		public EditorSubwindow(List<SlotModel> slots)
		{
			type_ = '(';
			Init(slots);
			SingletonManager.Get<InventoryInteractionController>(out controller_);
			SingletonManager.Get<VoxelInventoryModel>(out voxelInventoryModel_);
			SingletonManager.Get<LogicVoxelManager>(out logicVoxelManager);
			controller_.SlotClicked += HandleSlotClicked;
			slotsViewManager.SetScrollView(windowHierarchy.ScrollView, false);
			base.ViewChanged += EditorSubwindow_ViewChanged;
		}

		private void EditorSubwindow_ViewChanged(object sender, BoolEventArguments e)
		{
			for (int i = 0; i < slotsViewManager.Slots.Count; i++)
			{
				SlotController slotController = slotsViewManager.Slots[i];
				SlotModel model = slotController.Model;
				ushort num = (ushort)model.Entry.voxel_id;
				if (logicVoxelManager.IsLogicVoxel(num) && !logicVoxelManager.IsValidForGameMode(num))
				{
					slotController.View.Container.gameObject.SetActive(false);
				}
				else
				{
					slotController.View.Container.gameObject.SetActive(true);
				}
			}
		}

		public override void Clear()
		{
			controller_.SlotClicked -= HandleSlotClicked;
			base.Clear();
		}

		private void HandleSlotClicked(SlotController slot)
		{
			if (slot.Model.slotType == type_)
			{
				voxelInventoryModel_.SetSource(slot);
			}
		}
	}
}
