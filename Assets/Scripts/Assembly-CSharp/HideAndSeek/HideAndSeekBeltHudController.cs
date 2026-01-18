using HudSystem;
using InventoryModule;
using InventoryViewModule;
using PlayerModule.MyPlayer;
using UnityEngine;
using WindowsModule;

namespace HideAndSeek
{
	public class HideAndSeekBeltHudController : Singleton
	{
		private HideAndSeekModel model_;

		private GameHideAndSeekBeltHud gameBeltHud_;

		private MyPlayerStatsModel playerModel_;

		private SlotController slot_;

		private InventoryInteractionController controller_;

		public bool lobbyMode;

		public override void Dispose()
		{
			playerModel_.stats.hideAndSeek.RoleChanged -= HandleRoleChanged;
			playerModel_.stats.hideAndSeek.SelectedHideVoxelChanged -= HandleSelectedHideVoxelChanged;
			controller_.SlotClicked -= HandleSlotClicked;
			if (slot_ != null)
			{
				slot_.Dispose();
				slot_ = null;
			}
		}

		public override void Init()
		{
			SingletonManager.Get<MyPlayerStatsModel>(out playerModel_);
			SingletonManager.Get<HideAndSeekModel>(out model_);
			SingletonManager.Get<InventoryInteractionController>(out controller_);
			playerModel_.stats.hideAndSeek.SelectedHideVoxelChanged += HandleSelectedHideVoxelChanged;
			playerModel_.stats.hideAndSeek.RoleChanged += HandleRoleChanged;
			controller_.SlotClicked += HandleSlotClicked;
			HandleRoleChanged();
			HandleSelectedHideVoxelChanged();
		}

		private void HandleSlotClicked(SlotController slot)
		{
			if (!lobbyMode && slot == slot_)
			{
				HideAndSeekInventoryWindow hideAndSeekInventoryWindow = GuiModuleHolder.Get<HideAndSeekInventoryWindow>();
				WindowsManagerShortcut.ToggleWindow(hideAndSeekInventoryWindow);
				hideAndSeekInventoryWindow.tabs.ActivateTab(3);
			}
		}

		private void HandleSelectedHideVoxelChanged()
		{
			UpdateSelectedVoxel();
		}

		private void HandleRoleChanged()
		{
			Log.Temp("My player role", playerModel_.stats.hideAndSeek.Role);
			if (slot_ == null && GuiModuleHolder.TryGet<GameHideAndSeekBeltHud>(out gameBeltHud_))
			{
				TryInstantiate();
			}
			if (slot_ != null)
			{
				TryUpdate();
			}
		}

		private void TryUpdate()
		{
			bool flag = lobbyMode || playerModel_.stats.hideAndSeek.HasVoxel;
			slot_.View.Container.gameObject.SetActive(flag);
			if (flag)
			{
				UpdateSelectedVoxel();
			}
			UIWidget tableWidget = gameBeltHud_.Hierarchy.TableWidget;
			GameObject gameObject = gameBeltHud_.Hierarchy.watermarkLabel.gameObject;
			if (lobbyMode || playerModel_.stats.hideAndSeek.HasItems)
			{
				tableWidget.alpha = 1f;
				gameObject.SetActive(false);
			}
			else
			{
				tableWidget.alpha = 0.35f;
				gameObject.SetActive(true);
			}
		}

		private void TryInstantiate()
		{
			Transform transform = gameBeltHud_.Hierarchy.Envelop.transform;
			SlotModel slotModel = new SlotModel();
			slotModel.Splittable = false;
			slotModel.CanDrag = false;
			slotModel.CanDrag = false;
			slotModel.Movable = false;
			slot_ = new SlotController(SlotViewType.Normal, slotModel);
			UIWidget container = slot_.View.Container;
			GameObject gameObject = container.gameObject;
			gameObject.layer = transform.gameObject.layer;
			gameObject.transform.SetParent(transform.parent, false);
			gameObject.transform.transform.localScale = Vector3.one;
			container.SetAnchor(transform.gameObject, 0f, -140, 0f, -2, 0f, 0, 1f, 0);
			gameBeltHud_.Hierarchy.watermarkLabel.text = Localisations.Get("HideAndSeek_UI_INVENTORY_LOCK");
		}

		private void UpdateSelectedVoxel()
		{
			SlotModel slot;
			if (slot_ != null && playerModel_.stats.hideAndSeek.HideVoxelId > 0 && model_.GetSlotById(playerModel_.stats.hideAndSeek.HideVoxelId, out slot))
			{
				slot_.Model.Insert(slot.Item);
			}
		}
	}
}
