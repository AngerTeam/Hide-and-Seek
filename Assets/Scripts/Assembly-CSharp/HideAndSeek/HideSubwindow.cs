using HudSystem;
using InventoryModule;
using InventoryViewModule;
using NguiTools;
using PlayerModule.MyPlayer;
using WindowsModule;

namespace HideAndSeek
{
	public class HideSubwindow : BackpackSubwindow
	{
		private HideVoxelsSubwindowHierarchy hierarchy_;

		private InventoryInteractionController interaction_;

		private SlotController selectedSlot_;

		private HideAndSeekModel model_;

		private MyPlayerStatsModel player_;

		public HideSubwindow()
		{
			Init(')');
			SingletonManager.Get<MyPlayerStatsModel>(out player_);
			SingletonManager.Get<HideAndSeekModel>(out model_);
			SingletonManager.Get<InventoryInteractionController>(out interaction_);
			interaction_.SlotClicked += HandleSlotClicked;
			model_.AmountChanged += HandleAmountChanged;
			PrefabsManagerNGUI prefabsManagerNGUI = SingletonManager.Get<PrefabsManagerNGUI>();
			prefabsManagerNGUI.Load("UIHideAndSeek");
			hierarchy_ = prefabsManagerNGUI.InstantiateNGUIIn<HideVoxelsSubwindowHierarchy>("UIHideVoxelsSubwindow", windowHierarchy.gameObject);
			hierarchy_.BuyButtonLabel.text = Localisations.Get("UI_BuyShopItem");
			hierarchy_.SelectButtonLabel.text = Localisations.Get("UI_Select");
			ButtonSet.Up(hierarchy_.BuyButton, HandleBuy, ButtonSetGroup.InWindow);
			ButtonSet.Up(hierarchy_.SelectButton, HandleSelect, ButtonSetGroup.InWindow);
			model_.AllowSelectChanged += HandleAllowSelectChanged;
			UpdateContent(null);
		}

		private void HandleAmountChanged(int obj)
		{
			HideVoxelsEntries value;
			if (HideAndSeekContentMap.HideVoxels.TryGetValue(obj, out value))
			{
				TryEnableSelect(value);
			}
		}

		private void HandleAllowSelectChanged()
		{
			UpdateContent(player_.stats.hideAndSeek.HideVoxelId);
		}

		private void HandleSelect()
		{
			model_.lastSelectedVoxel = true;
			player_.stats.hideAndSeek.HideVoxelId = selectedSlot_.Model.GhostItem.Entry.hideVoxel.id;
			WindowsManagerShortcut.ToggleWindow<HideAndSeekInventoryWindow>();
		}

		private void HandleBuy()
		{
			int id = selectedSlot_.Model.GhostItem.Entry.hideVoxel.id;
			model_.TryBuy(id, HideAndSeekContentMap.HideSeekSettings.hideVoxelsCount);
		}

		public override void Clear()
		{
			interaction_.SlotClicked -= HandleSlotClicked;
			model_.AllowSelectChanged -= HandleAllowSelectChanged;
		}

		private void EnableSelect(bool enable)
		{
			hierarchy_.SelectButton.gameObject.SetActive(model_.AllowSelect && enable);
		}

		private void EnableBuy(bool enable)
		{
			hierarchy_.BuyButton.gameObject.SetActive(enable);
			hierarchy_.PriceLabel.gameObject.SetActive(enable);
		}

		private void HandleSlotClicked(SlotController slot)
		{
			if (selectedSlot_ != null)
			{
				selectedSlot_.Split(false);
			}
			if (slot.Model.slotType == ')')
			{
				ArtikulsEntries entry = slot.Model.GhostItem.Entry;
				UpdateContent(entry.hideVoxel);
				selectedSlot_ = slot;
				selectedSlot_.Split(true);
			}
			else
			{
				UpdateContent(null);
			}
		}

		private void UpdateContent(int voxelId)
		{
			HideVoxelsEntries value;
			UpdateContent((!HideAndSeekContentMap.HideVoxels.TryGetValue(voxelId, out value)) ? null : value);
		}

		private void UpdateContent(HideVoxelsEntries hideVoxel)
		{
			if (hideVoxel != null && hideVoxel.voxel != null)
			{
				int hideVoxelsCount = HideAndSeekContentMap.HideSeekSettings.hideVoxelsCount;
				int num = hideVoxelsCount * hideVoxel.money_cnt;
				hierarchy_.DescriptionLabel.text = string.Format("{0} x{1}", hideVoxel.voxel.title, hideVoxelsCount);
				hierarchy_.PriceLabel.text = num.ToString();
				bool enable = model_.DefaultHideVoxel == null || model_.DefaultHideVoxel.id != hideVoxel.id;
				EnableBuy(enable);
				TryEnableSelect(hideVoxel);
			}
			else
			{
				hierarchy_.DescriptionLabel.text = string.Empty;
				hierarchy_.PriceLabel.text = string.Empty;
				EnableBuy(false);
				EnableSelect(false);
			}
		}

		private void TryEnableSelect(HideVoxelsEntries hideVoxel)
		{
			SlotModel slot;
			if (model_.GetSlotById(hideVoxel.id, out slot))
			{
				EnableSelect(!slot.IsEmpty && (slot.Item.infiniteLogic || slot.Item.Amount > 0));
			}
		}
	}
}
