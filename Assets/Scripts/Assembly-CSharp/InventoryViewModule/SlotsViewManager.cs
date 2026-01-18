using System;
using System.Collections.Generic;
using Extensions;
using InventoryModule;
using UnityEngine;

namespace InventoryViewModule
{
	public class SlotsViewManager : IDisposable
	{
		private InventoryInteractionController interaction_;

		private IInventoryLogic invetnory_;

		private char slotType_;

		public SelectionHandlerMode SelectionMode { get; private set; }

		public List<SlotController> Slots { get; private set; }

		public event Action<SlotController> SlotClicked;

		public SlotsViewManager(char slotType, Transform parent, SelectionHandlerMode selectionMode = SelectionHandlerMode.None)
		{
			SingletonManager.Get<IInventoryLogic>(out invetnory_);
			List<SlotModel> models = invetnory_.Model.Slots[slotType];
			slotType_ = slotType;
			Build(models, parent, selectionMode);
		}

		public SlotsViewManager(List<SlotModel> models, Transform parent, SelectionHandlerMode selectionMode = SelectionHandlerMode.None)
		{
			SingletonManager.Get<IInventoryLogic>(out invetnory_);
			Build(models, parent, selectionMode);
		}

		private void Build(List<SlotModel> models, Transform parent, SelectionHandlerMode selectionMode = SelectionHandlerMode.None)
		{
			SelectionMode = selectionMode;
			SingletonManager.Get<InventoryInteractionController>(out interaction_);
			interaction_.SlotClicked += HandleSlotClicked;
			Slots = new List<SlotController>(models.Count);
			for (int i = 0; i < models.Count; i++)
			{
				SlotModel model = models[i];
				SlotController slotController = new SlotController(SlotViewType.Normal, model);
				slotController.SetParent(parent);
				Slots.Add(slotController);
			}
			if (SelectionMode == SelectionHandlerMode.Select)
			{
				int index = ((invetnory_.Model.SelectedSlot != null) ? invetnory_.Model.SelectedSlot.index : 0);
				SelectSlotByIndex(index);
			}
		}

		public virtual void Dispose()
		{
			interaction_.SlotClicked -= HandleSlotClicked;
			for (int i = 0; i < Slots.Count; i++)
			{
				Slots[i].Dispose();
			}
			Slots.Clear();
		}

		public void SelectSlotByIndex(int index)
		{
			if (Slots.Count > index)
			{
				invetnory_.Model.SelectSlot(Slots[index].Model);
			}
		}

		private void HandleSlotClicked(SlotController slot)
		{
			switch (SelectionMode)
			{
			case SelectionHandlerMode.Report:
				if (slot.Model.slotType == slotType_)
				{
					this.SlotClicked.SafeInvoke(slot);
				}
				break;
			case SelectionHandlerMode.Select:
				if (slot.Model.slotType == slotType_)
				{
					SelectForUse(slot);
				}
				break;
			}
		}

		private void SelectForUse(SlotController slot)
		{
			invetnory_.Model.SelectSlot(slot.Model);
		}

		public void SetScrollView(UIScrollView scrollView, bool emptyOnly)
		{
			for (int i = 0; i < Slots.Count; i++)
			{
				Slots[i].SetScrollView(scrollView, emptyOnly);
			}
		}
	}
}
