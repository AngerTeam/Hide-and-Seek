using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using CraftyEngine.Utils.Unity;
using HudSystem;
using WindowsModule;

namespace ChestsViewModule
{
	public abstract class ChestsWindowBase : GameWindow
	{
		protected ChestsWindowHierarchy chestsHierarchy;

		private ChestsManagerBase chestsManagerBase_;

		private TimeManager timeManager_;

		protected ChestRewardSlotHierarchy[] chestRewardHolders;

		protected ChestsWindowBase()
			: base(false)
		{
			base.HudState = 41088;
			SingletonManager.Get<TimeManager>(out timeManager_);
			SingletonManager.Get<ChestsManagerBase>(out chestsManagerBase_);
			prefabsManager.Load("ChestsPrefabsHolder");
			chestsHierarchy = prefabsManager.InstantiateNGUIIn<ChestsWindowHierarchy>("UIChestsWindow", nguiManager.UiRoot.gameObject);
			chestRewardHolders = new ChestRewardSlotHierarchy[4];
			for (int i = 0; i < chestRewardHolders.Length; i++)
			{
				ChestRewardSlotHierarchy chestRewardSlotHierarchy = prefabsManager.InstantiateNGUIIn<ChestRewardSlotHierarchy>("UIChestReward", chestsHierarchy.chestsGrid.gameObject);
				chestRewardHolders[i] = chestRewardSlotHierarchy;
			}
			chestsHierarchy.chestsGrid.repositionNow = true;
			SetContent(chestsHierarchy.transform, true, true, false, false, true);
			chestsHierarchy.title.text = Localisations.Get("UI_Rewards");
			chestsHierarchy.combatRewardsTitle.text = Localisations.Get("UI_Combat_Rewards");
			ClearRewardChestSlots();
			base.ViewChanged += HandleViewChanged;
			base.IsFrontChanged += HandleIsFrontChanged;
			FillRewardChestSlots();
		}

		public override void Clear()
		{
			base.ViewChanged -= HandleViewChanged;
		}

		public void FillRewardChestSlots()
		{
			ClearRewardChestSlots();
			foreach (RewardChest rewardChest in chestsManagerBase_.RewardChests)
			{
				if (rewardChest.slotId > chestRewardHolders.Length)
				{
					Log.Error("No such slot for id:" + rewardChest.slotId);
					continue;
				}
				ChestRewardSlotHierarchy slot = chestRewardHolders[rewardChest.slotId - 1];
				slot.observedItem = rewardChest;
				slot.priceWidget.gameObject.SetActive(false);
				slot.icon.gameObject.SetActive(false);
				ButtonSet.Up(slot.button, delegate
				{
					OnChestClicked(slot.observedItem);
				}, ButtonSetGroup.InWindow);
			}
		}

		public void ToggleWindow()
		{
			windowsManager.ToggleWindow(this);
			UpdateRewardChests();
		}

		public void UpdateRewardChests()
		{
			if (!Visible)
			{
				return;
			}
			ChestRewardSlotHierarchy[] array = chestRewardHolders;
			foreach (ChestRewardSlotHierarchy chestRewardSlotHierarchy in array)
			{
				if (chestRewardSlotHierarchy.observedItem != null)
				{
					chestRewardSlotHierarchy.button.enabled = true;
					chestRewardSlotHierarchy.icon.gameObject.SetActive(true);
					chestRewardSlotHierarchy.iconEmpty.gameObject.SetActive(false);
					chestRewardSlotHierarchy.openWidget.gameObject.SetActive(false);
					if (chestRewardSlotHierarchy.observedItem.state == RewardChestState.Opening)
					{
						GameObjectUtils.SwitchActive(chestRewardSlotHierarchy.timerWidget.gameObject, true);
						chestRewardSlotHierarchy.timer.text = TimeUtils.ToTimerCounter(chestRewardSlotHierarchy.observedItem.EndTime - timeManager_.CurrentTimestamp);
						chestRewardSlotHierarchy.priceWidget.gameObject.SetActive(true);
						chestRewardSlotHierarchy.openNowLabel.text = Localisations.Get("UI_Open_Now");
						chestRewardSlotHierarchy.statusLabel.text = string.Empty;
						chestRewardSlotHierarchy.timeToTakeLabel.text = string.Empty;
						chestRewardSlotHierarchy.priceLabel.text = ChestsManagerBase.GetCurrentBoostPrice(chestRewardSlotHierarchy.observedItem, timeManager_.CurrentTimestamp).ToString();
					}
					else if (chestRewardSlotHierarchy.observedItem.state == RewardChestState.Idle)
					{
						if (chestsManagerBase_.OpeningChest == null)
						{
							chestRewardSlotHierarchy.statusLabel.text = Localisations.Get("UI_Tap_to_unlock");
						}
						else
						{
							chestRewardSlotHierarchy.statusLabel.text = Localisations.Get("UI_Closed");
						}
						chestRewardSlotHierarchy.priceWidget.gameObject.SetActive(false);
						chestRewardSlotHierarchy.timeToTakeLabel.text = TimeUtils.ToTimerCounter(chestRewardSlotHierarchy.observedItem.timeToOpen);
						GameObjectUtils.SwitchActive(chestRewardSlotHierarchy.timerWidget.gameObject, false);
					}
					else
					{
						chestRewardSlotHierarchy.statusLabel.text = string.Empty;
						chestRewardSlotHierarchy.openLabel.text = Localisations.Get("UI_Open");
						chestRewardSlotHierarchy.openWidget.gameObject.SetActive(true);
						chestRewardSlotHierarchy.priceWidget.gameObject.SetActive(false);
						chestRewardSlotHierarchy.timerWidget.gameObject.SetActive(false);
						chestRewardSlotHierarchy.timeToTakeLabel.text = string.Empty;
						chestRewardSlotHierarchy.timer.text = string.Empty;
						chestRewardSlotHierarchy.observedItem.view.Animate("chest_impatience");
					}
				}
				else
				{
					chestRewardSlotHierarchy.button.enabled = false;
					chestRewardSlotHierarchy.statusLabel.text = Localisations.Get("UI_Empty");
					chestRewardSlotHierarchy.icon.gameObject.SetActive(false);
					chestRewardSlotHierarchy.iconEmpty.gameObject.SetActive(true);
					chestRewardSlotHierarchy.openWidget.gameObject.SetActive(false);
				}
			}
		}

		private void ClearRewardChestSlots()
		{
			ChestRewardSlotHierarchy[] array = chestRewardHolders;
			foreach (ChestRewardSlotHierarchy chestRewardSlotHierarchy in array)
			{
				chestRewardSlotHierarchy.priceWidget.gameObject.SetActive(false);
				chestRewardSlotHierarchy.icon.gameObject.SetActive(false);
				chestRewardSlotHierarchy.observedItem = null;
				chestRewardSlotHierarchy.timerWidget.gameObject.SetActive(false);
				chestRewardSlotHierarchy.timeToTakeLabel.text = string.Empty;
			}
		}

		private void HandleIsFrontChanged(object sender, BoolEventArguments e)
		{
			VisibilityChanged(Visible && base.IsFront);
		}

		private void HandleViewChanged(object sender, BoolEventArguments e)
		{
			VisibilityChanged(Visible && base.IsFront);
		}

		protected virtual void VisibilityChanged(bool visible)
		{
			UpdateSlotModels(visible);
		}

		private void UpdateSlotModels(bool visible)
		{
			if (UICamera.currentCamera == null)
			{
				return;
			}
			ChestRewardSlotHierarchy[] array = chestRewardHolders;
			foreach (ChestRewardSlotHierarchy chestRewardSlotHierarchy in array)
			{
				if (chestRewardSlotHierarchy.observedItem != null && chestRewardSlotHierarchy.observedItem.view != null)
				{
					chestRewardSlotHierarchy.observedItem.view.SetParent(chestRewardSlotHierarchy.modelHolder.transform, true);
					chestRewardSlotHierarchy.observedItem.view.SwitchActive(visible);
				}
			}
		}

		private void OnChestClicked(RewardChest rewardChest)
		{
			if (rewardChest != null)
			{
				if (rewardChest.state == RewardChestState.Completed)
				{
					chestsManagerBase_.OpenChest(rewardChest);
				}
				else
				{
					chestsManagerBase_.OpenSelectedChestWindow(rewardChest);
				}
			}
		}
	}
}
