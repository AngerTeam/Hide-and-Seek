using CraftyEngine.Infrastructure;
using InventoryModule;
using InventoryViewModule;

namespace CraftyVoxelEngine.Editor
{
	public class EditorBeltHud : BeltHud<EditorInventoryWindow>
	{
		private InventoryInteractionController inventoryInteraction_;

		private VoxelInventoryModel voxelInventoryModel_;

		private KeyboardInputManager keyboardInputManager_;

		private SlotModel switchSlotModel_;

		private SlotController switchSlotController_;

		public EditorBeltHud()
		{
			VoxelEditorModel singlton;
			SingletonManager.Get<VoxelEditorModel>(out singlton);
			SingletonManager.Get<KeyboardInputManager>(out keyboardInputManager_);
			SingletonManager.Get<VoxelInventoryModel>(out voxelInventoryModel_);
			SingletonManager.Get<InventoryInteractionController>(out inventoryInteraction_);
			SetSlots(voxelInventoryModel_.BeltSlots, SelectionHandlerMode.Report, 67108864);
			inventoryInteraction_.SlotClicked += HandleSlotClicked;
			inventoryInteraction_.SlotDragStarting += HandleSlotDragStarting;
			voxelInventoryModel_.SetTarget(slotsController.Slots[0]);
			if (voxelInventoryModel_.enableReplaceSlot)
			{
				switchSlotModel_ = new SlotModel();
				switchSlotModel_.Interactable = false;
				switchSlotController_ = new SlotController(SlotViewType.Normal, switchSlotModel_);
				switchSlotController_.SetParent(base.Hierarchy.Table.transform);
				singlton.SwitchSlotSelected += SetSwitchSlot;
			}
			int num = 1;
			foreach (SlotController slot in slotsController.Slots)
			{
				slot.View.SetBindKey(num.ToString());
				num++;
			}
			keyboardInputManager_.ButtonAlphaReleased += HandleButtonAlphaReleased;
		}

		public void SetSwitchSlot()
		{
			switchSlotModel_.Insert(voxelInventoryModel_.target.Model.Item);
			switchSlotController_.Redraw();
		}

		private void HandleButtonAlphaReleased(object sender, InputEventArgs e)
		{
			if (e.alpha.HasValue)
			{
				int value = e.alpha.Value;
				if (value >= 0 && value < slotsController.Slots.Count)
				{
					voxelInventoryModel_.SetTarget(slotsController.Slots[value]);
				}
			}
		}

		public override void Dispose()
		{
			inventoryInteraction_.SlotClicked -= HandleSlotClicked;
			inventoryInteraction_.SlotDragStarting -= HandleSlotDragStarting;
			keyboardInputManager_.ButtonAlphaReleased -= HandleButtonAlphaReleased;
			base.Dispose();
		}

		private void HandleSlotDragStarting(SlotModel slot)
		{
			if (slot.slotType == '&')
			{
				slot.Clear();
				inventoryInteraction_.CancelDrag();
			}
		}

		private void HandleSlotClicked(SlotController slot)
		{
			if (slot.Model.slotType == '&')
			{
				voxelInventoryModel_.SetTarget(slot);
			}
		}
	}
}
