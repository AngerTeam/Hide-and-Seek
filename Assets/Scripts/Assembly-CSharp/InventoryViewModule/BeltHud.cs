using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using HudSystem;
using InventoryModule;
using UnityEngine;
using WindowsModule;

namespace InventoryViewModule
{
	public class BeltHud<T> : HeadUpDisplay where T : InventoryWindow
	{
		protected SlotsViewManager slotsController;

		public bool enableTrashSlot;

		private InventoryInteractionController controller_;

		private int hudState_;

		private KeyboardInputManager inputManager_;

		private InventoryModel inventoryModel_;

		private SlotController trashSlot_;

		private bool visible_;

		public BeltPanelHierarchy Hierarchy { get; private set; }

		public BeltHud(char type, int hudState, SelectionHandlerMode mode)
		{
			Instantiate();
			slotsController = new SlotsViewManager(type, Hierarchy.Table.transform, mode);
			Build(hudState);
		}

		public BeltHud()
		{
			Instantiate();
		}

		public override void Dispose()
		{
			base.Dispose();
			slotsController.Dispose();
			Object.Destroy(Hierarchy.gameObject);
			hudStateSwitcher.Changed -= HandleHudStateChanged;
			inputManager_.ButtonAlphaReleased -= HandleInputManagerButtonPressed;
			controller_.SlotDragStarting -= HandleSlotDragStarting;
			controller_.SlotDragged -= HandleSlotDragged;
			controller_.DragCanceled -= HandleDragCanceled;
			trashSlot_.Dispose();
		}

		public void SetSlots(List<SlotModel> slots, SelectionHandlerMode mode, int hudState)
		{
			slotsController = new SlotsViewManager(slots, Hierarchy.Table.transform, mode);
			Build(hudState);
		}

		private void Build(int hudState)
		{
			hudState_ = hudState;
			SingletonManager.Get<KeyboardInputManager>(out inputManager_);
			inputManager_.ButtonAlphaReleased += HandleInputManagerButtonPressed;
			Hierarchy.Table.columns = 100;
			Hierarchy.widget.SetAnchor(nguiManager.UiRoot.PlayerPanelContainer.transform);
			InventoryButtonHierarchy inventoryButtonHierarchy = prefabsManager.InstantiateNGUIIn<InventoryButtonHierarchy>("UIInventoryButton", Hierarchy.Table.gameObject);
			hudStateSwitcher.Register(hudState, inventoryButtonHierarchy);
			hudStateSwitcher.Register(hudState, Hierarchy.BeltWidget);
			if (!CompileConstants.MOBILE)
			{
				inventoryButtonHierarchy.bindKeyLabel.text = KeyCode.E.ToString();
			}
			ButtonSet.Up(inventoryButtonHierarchy.button, HandleInventoryClick, ButtonSetGroup.Slots);
			Hierarchy.Table.columns += 2;
			Hierarchy.widget.SetAnchor(nguiManager.UiRoot.PlayerPanelContainer.transform);
			hudStateSwitcher.Changed += HandleHudStateChanged;
			SingletonManager.Get<InventoryInteractionController>(out controller_);
			SingletonManager.Get<InventoryModel>(out inventoryModel_);
			controller_.SlotDragStarting += HandleSlotDragStarting;
			controller_.SlotDragged += HandleSlotDragged;
			controller_.DragCanceled += HandleDragCanceled;
			SetTrashVisible(false);
			foreach (SlotController slot in slotsController.Slots)
			{
				slot.Model.Splittable = false;
			}
		}

		private void HandleDragCanceled(SlotModel obj)
		{
			SetTrashVisible(false);
		}

		private void HandleHudStateChanged()
		{
			if (!EnumUtils.Contains(hudStateSwitcher.SelectedType, hudState_))
			{
				return;
			}
			Hierarchy.Table.repositionNow = true;
			visible_ = true;
			UnityEvent.OnNextUpdate(delegate
			{
				Hierarchy.Envelop.executeOnNextUpdate = true;
				UnityEvent.OnNextUpdate(delegate
				{
					UnityEvent.OnNextUpdate(UpdateAnchors);
				});
			});
		}

		private void HandleInputManagerButtonPressed(object sender, InputEventArgs e)
		{
			if (e.alpha.HasValue && EnumUtils.Contains(hudStateSwitcher.SelectedType, hudState_))
			{
				slotsController.SelectSlotByIndex(e.alpha.Value);
			}
		}

		private void HandleInventoryClick()
		{
			WindowsManagerShortcut.ToggleWindow<T>();
		}

		private void HandleSlotDragged(SlotModel source, SlotModel target)
		{
			if (enableTrashSlot && visible_)
			{
				if (target == trashSlot_.Model)
				{
					source.Clear();
					trashSlot_.Model.Clear();
					inventoryModel_.ReportDeleteSlot(source);
				}
				SetTrashVisible(false);
			}
		}

		private void HandleSlotDragStarting(SlotModel source)
		{
			T module;
			if (visible_ && source.AllowEvents && GuiModuleHolder.TryGet<T>(out module) && (source.slotType != 'p' || module.Visible))
			{
				SetTrashVisible(true);
			}
		}

		private void Instantiate()
		{
			prefabsManager.Load("InventotyPrefabHolder");
			Hierarchy = prefabsManager.InstantiateNGUIIn<BeltPanelHierarchy>("UIBeltPanel", nguiManager.UiRoot.PlayerPanelContainer.gameObject);
			trashSlot_ = new SlotController(SlotViewType.Trash, new SlotModel());
			trashSlot_.Model.AllowEvents = false;
			trashSlot_.Model.slotType = 'p';
			trashSlot_.Model.CanDrag = false;
			trashSlot_.Model.AllowTake = false;
			trashSlot_.Model.system = true;
			trashSlot_.SetParent(Hierarchy.TrashWidget.transform);
		}

		private void SetTrashVisible(bool b)
		{
			trashSlot_.View.Container.gameObject.SetActive(enableTrashSlot && b);
		}

		private void UpdateAnchors()
		{
			Hierarchy.ButtonsWidget.width = 1600;
			T module;
			if (GuiModuleHolder.TryGet<T>(out module) && module.Hierarchy != null && Hierarchy != null && Hierarchy.BackWidget != null)
			{
				module.Hierarchy.closeButtonWidget.SetAnchor(Hierarchy.BackWidget.gameObject, 0, 0, 0, 0);
			}
		}
	}
}
