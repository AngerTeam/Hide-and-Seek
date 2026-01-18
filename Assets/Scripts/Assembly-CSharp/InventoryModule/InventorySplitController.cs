using System;
using InventoryViewModule;

namespace InventoryModule
{
	public class InventorySplitController : IDisposable
	{
		private InventoryInteractionController interaction_;

		private IInventoryLogic invetnory_;

		private SlotModel selectedSlot_;

		public InventorySplitController()
		{
			SingletonManager.Get<IInventoryLogic>(out invetnory_);
			SingletonManager.Get<InventoryInteractionController>(out interaction_);
			interaction_.SlotClicked += SelectForSplit;
		}

		public void Dispose()
		{
			interaction_.SlotClicked -= SelectForSplit;
		}

		private void Select(SlotModel slot)
		{
			if (selectedSlot_ != null)
			{
				invetnory_.Model.SplittingSlot = null;
				selectedSlot_.Splitting = false;
			}
			if (slot == null || slot.IsEmpty || slot.Amount <= 1 || !slot.Splittable)
			{
				selectedSlot_ = null;
				return;
			}
			selectedSlot_ = slot;
			selectedSlot_.Splitting = true;
			invetnory_.Model.SplittingSlot = selectedSlot_;
		}

		private void SelectForSplit(SlotController slotController)
		{
			SlotModel model = slotController.Model;
			if (selectedSlot_ == null)
			{
				Select(model);
			}
			else if (selectedSlot_ == model)
			{
				Select(null);
			}
			else if (invetnory_.TryMoveSlot(selectedSlot_, model, 1))
			{
				if (selectedSlot_.IsEmpty)
				{
					Select(null);
				}
			}
			else
			{
				Select(model);
			}
		}
	}
}
