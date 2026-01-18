using System;
using Extensions;
using InventoryViewModule;
using NguiTools;
using UnityEngine;

namespace InventoryModule
{
	public class InventoryInteractionController : Singleton
	{
		private bool canceled_;

		private DragController dragController_;

		private bool dragging_;

		private SlotController draggingSlot_;

		private Transform dragPanel_;

		private NguiManager nguiManager_;

		private SlotController sourceSlot_;

		private Camera uiCamera_;

		public event Action<SlotController> SlotClicked;

		public event Action<SlotModel, SlotModel> SlotDragged;

		public event Action<SlotModel> DragCanceled;

		public event Action<SlotModel> SlotDragStarting;

		public void CancelDrag()
		{
			dragging_ = false;
			canceled_ = true;
			if (sourceSlot_ != null)
			{
				sourceSlot_.Dirtyfy();
			}
			sourceSlot_ = null;
			draggingSlot_.Model.Clear();
			draggingSlot_.View.Container.gameObject.SetActive(false);
		}

		public override void Dispose()
		{
			draggingSlot_.Dispose();
			dragController_.Dispose();
		}

		public override void OnDataLoaded()
		{
			GetSingleton<NguiManager>(out nguiManager_, 4);
			draggingSlot_ = new SlotController(SlotViewType.IconOnly, new SlotModel());
			draggingSlot_.SetParent(nguiManager_.UiRoot.CursorPanel.transform);
			draggingSlot_.View.Container.gameObject.SetActive(false);
			uiCamera_ = nguiManager_.UiRoot.UICamera.GetComponent<Camera>();
			dragPanel_ = nguiManager_.UiRoot.CursorPanel.transform;
			dragController_ = new DragController();
			dragController_.DragStarted += HandleDragStarted;
			dragController_.DragUpdate += HandleDragUpdate;
			dragController_.DragEnded += HandleDragEnded;
			dragController_.Clicked += HandleClicked;
		}

		private bool GetSlotUnderTouch(Vector2 position, out SlotController slot)
		{
			Ray ray = uiCamera_.ScreenPointToRay(position);
			RaycastHit[] array = Physics.RaycastAll(ray, 32f);
			for (int i = 0; i < array.Length; i++)
			{
				InventorySlotHierarchy component = array[i].collider.GetComponent<InventorySlotHierarchy>();
				if (component != null && component.widget.isVisible && !(draggingSlot_.View.Hierarchy == component) && (sourceSlot_ == null || !(sourceSlot_.View.Hierarchy == component)) && component.slot.Model.Interactable)
				{
					slot = component.slot;
					return true;
				}
			}
			slot = null;
			return false;
		}

		private void HandleClicked(Vector2 position)
		{
			SlotController slot;
			if (GetSlotUnderTouch(position, out slot))
			{
				this.SlotClicked.SafeInvoke(slot);
			}
			if (!dragging_)
			{
				sourceSlot_ = null;
			}
		}

		private void HandleDragEnded(Vector2 position)
		{
			if (!dragging_)
			{
				return;
			}
			SlotController slotController = sourceSlot_;
			CancelDrag();
			if (slotController != null)
			{
				SlotController slot;
				if (GetSlotUnderTouch(position, out slot) && slot.Model.CanDrop && slot != slotController)
				{
					this.SlotDragged.SafeInvoke(slotController.Model, slot.Model);
				}
				else
				{
					this.DragCanceled.SafeInvoke(slotController.Model);
				}
			}
			else
			{
				this.DragCanceled.SafeInvoke(null);
			}
		}

		private void HandleDragStarted(Vector2 position)
		{
			if (UICamera.selectedObject != null)
			{
				if (!GetSlotUnderTouch(position, out sourceSlot_) || !sourceSlot_.Model.CanDrag || sourceSlot_.LockDrag || sourceSlot_.Model.IsEmpty)
				{
					return;
				}
				canceled_ = false;
				this.SlotDragStarting.SafeInvoke(sourceSlot_.Model);
				if (!canceled_)
				{
					dragging_ = true;
					ArtikulItem item = sourceSlot_.Model.Item;
					draggingSlot_.Model.Insert(item);
					draggingSlot_.View.Container.gameObject.SetActive(true);
					if (!item.infiniteLogic)
					{
						sourceSlot_.HideItem();
					}
				}
			}
			else
			{
				sourceSlot_ = null;
			}
		}

		private void HandleDragUpdate(Vector2 position)
		{
			if (dragging_)
			{
				position = NGUIMath.ScreenToPixels(position, dragPanel_);
				draggingSlot_.Move(position);
			}
		}
	}
}
