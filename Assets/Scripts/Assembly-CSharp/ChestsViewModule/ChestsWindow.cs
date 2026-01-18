using AdsModule;
using ChestsViewModule.Content;
using CraftyEngine.Utils;
using DailyBonusModule;
using HudSystem;
using UnityEngine;

namespace ChestsViewModule
{
	public class ChestsWindow : ChestsWindowBase
	{
		private AdsManager adsManager_;

		private UnityTimer adsTimer_;

		private ChestsManager chestsManager_;

		private ChestsPermanent chestsPermanent_;

		private UnityTimerManager unityTimerManager_;

		private DailyBonusController dailyBonusController_;

		public ChestsWindow()
		{
			SingletonManager.Get<AdsManager>(out adsManager_);
			SingletonManager.Get<ChestsManager>(out chestsManager_);
			SingletonManager.Get<ChestsPermanent>(out chestsPermanent_);
			SingletonManager.Get<UnityTimerManager>(out unityTimerManager_);
			SingletonManager.Get<DailyBonusController>(out dailyBonusController_);
			chestsHierarchy.adsOpenLabel.text = Localisations.Get("UI_Open");
			chestsHierarchy.assassinsOpenLabel.text = Localisations.Get("UI_Open");
			chestsHierarchy.dailyOpenLabel.text = Localisations.Get("UI_Open");
			chestsHierarchy.assassinsKillsLabel.text = Localisations.Get("UI_AssassinsChest_Kills");
			chestsHierarchy.dailyNotAvailableInLabel.text = Localisations.Get("UI_Next_Day");
			chestsHierarchy.adsNotAvailableLabel.text = Localisations.Get("UI_Ads_Video_Not_Available");
			chestsHierarchy.adsAvailableInLabel.text = Localisations.Get("UI_Ads_Video_Available_In");
			ButtonSet.Up(chestsHierarchy.adsButton, adsManager_.TryShowAd, ButtonSetGroup.InWindow);
			ButtonSet.Up(chestsHierarchy.assassinsButton, chestsManager_.AssassinsChestClick, ButtonSetGroup.InWindow);
			ButtonSet.Up(chestsHierarchy.dailyButton, DailyChestClick, ButtonSetGroup.InWindow);
			FillStaticChests();
			adsTimer_ = unityTimerManager_.SetTimer();
			adsTimer_.repeat = true;
			adsTimer_.Completeted += HandleTimers;
		}

		public void DailyChestClick()
		{
			DailyBonusWindow dailyBonusWindow = GuiModuleHolder.Get<DailyBonusWindow>();
			dailyBonusWindow.OpenWindow(chestsManager_.DailyChest);
		}

		private void HandleTimers()
		{
			if (Visible && base.IsFront)
			{
				HandleAdsTimer();
				HandleDailyTimer();
			}
		}

		public void UpdateAssassinsChest()
		{
			if (chestsPermanent_.IsAssassinsChestReady())
			{
				chestsHierarchy.assassinsTakeWidget.gameObject.SetActive(true);
				chestsHierarchy.assassinsKillsWidget.gameObject.SetActive(false);
				chestsManager_.AssassinsChest.view.Animate("chest_impatience");
			}
			else
			{
				chestsHierarchy.assassinsTakeWidget.gameObject.SetActive(false);
				chestsHierarchy.assassinsKillsWidget.gameObject.SetActive(true);
				chestsHierarchy.assassinsKillsCountLabel.text = string.Format("{0}/{1}", chestsPermanent_.AssassinChestKills, ChestsContentMap.ChestSettings.assassinChestKills);
				chestsHierarchy.assassinsKillsSlider.value = Mathf.Clamp01((float)chestsPermanent_.AssassinChestKills / (float)ChestsContentMap.ChestSettings.assassinChestKills);
				chestsManager_.AssassinsChest.view.Animate("chest_idle");
			}
		}

		public void UpdateDailyChest()
		{
			if (dailyBonusController_.IsBonusEnable)
			{
				chestsHierarchy.dailyTimeCountLabel.gameObject.SetActive(false);
				chestsHierarchy.dailyNotAvailableInLabel.gameObject.SetActive(false);
				chestsHierarchy.dailyTakeWidget.gameObject.SetActive(true);
				chestsManager_.DailyChest.view.Animate("chest_impatience");
			}
			else
			{
				chestsHierarchy.dailyTimeCountLabel.gameObject.SetActive(true);
				chestsHierarchy.dailyTimeCountLabel.text = TimeUtils.ToTimerCounter(dailyBonusController_.TimeLeft);
				chestsHierarchy.dailyNotAvailableInLabel.gameObject.SetActive(true);
				chestsHierarchy.dailyTakeWidget.gameObject.SetActive(false);
				chestsManager_.DailyChest.view.Animate("chest_idle");
			}
		}

		protected override void VisibilityChanged(bool visible)
		{
			base.VisibilityChanged(visible);
			chestsHierarchy.dailyButton.gameObject.SetActive(dailyBonusController_.IsModuleEnable);
			if (visible)
			{
				HandleTimers();
				UpdateAssassinsChest();
				chestsManager_.AssassinsChest.view.SetParent(chestsHierarchy.assassinsModelHolder.transform, true);
				UpdateRewardChests();
				chestsManager_.AdsChest.view.SetParent(chestsHierarchy.adsModelHolder.transform, true);
				UpdateDailyChest();
				chestsManager_.DailyChest.view.SetParent(chestsHierarchy.dailyModelHolder.transform, true);
			}
			chestsManager_.AssassinsChest.view.SwitchActive(visible);
			chestsManager_.AdsChest.view.SwitchActive(visible);
			if (dailyBonusController_.IsModuleEnable)
			{
				chestsManager_.DailyChest.view.SwitchActive(visible);
			}
			else
			{
				chestsManager_.DailyChest.view.SwitchActive(false);
			}
		}

		private void HandleAdsTimer()
		{
			if (adsManager_.IsAvailableByTime())
			{
				chestsHierarchy.adsTimeWidget.gameObject.SetActive(false);
				if (adsManager_.IsVideoAvailable())
				{
					chestsHierarchy.adsButton.enabled = true;
					chestsHierarchy.adsTakeWidget.gameObject.SetActive(true);
					chestsHierarchy.adsNotAvailableLabel.gameObject.SetActive(false);
					chestsManager_.AdsChest.view.Animate("chest_impatience");
				}
				else
				{
					chestsHierarchy.adsButton.enabled = false;
					chestsHierarchy.adsTakeWidget.gameObject.SetActive(false);
					chestsHierarchy.adsNotAvailableLabel.gameObject.SetActive(true);
					chestsManager_.AdsChest.view.Animate("chest_idle");
				}
			}
			else
			{
				chestsHierarchy.adsButton.enabled = false;
				chestsHierarchy.adsTakeWidget.gameObject.SetActive(false);
				chestsHierarchy.adsTimeWidget.gameObject.SetActive(true);
				chestsHierarchy.adsNotAvailableLabel.gameObject.SetActive(false);
				chestsHierarchy.adsTimeCountLabel.text = TimeUtils.ToTimerCounter(adsManager_.GetTimeLeft());
				chestsManager_.AdsChest.view.Animate("chest_idle");
			}
		}

		private void HandleDailyTimer()
		{
			UpdateDailyChest();
		}

		public void FillStaticChests()
		{
			chestsHierarchy.adsLabel.text = chestsManager_.AdsChest.itemName;
			chestsHierarchy.assassinsLabel.text = chestsManager_.AssassinsChest.itemName;
			chestsHierarchy.dailyLabel.text = chestsManager_.DailyChest.itemName;
		}
	}
}
