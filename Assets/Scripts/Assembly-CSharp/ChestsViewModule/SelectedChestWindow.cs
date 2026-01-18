using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using CraftyEngine.Sounds;
using CraftyEngine.Utils;
using CraftyGameEngine.Gui.Fx;
using DG.Tweening;
using HideAndSeek;
using HudSystem;
using InventoryModule;
using InventoryViewModule;
using UnityEngine;
using WindowsModule;

namespace ChestsViewModule
{
	public class SelectedChestWindow : GameWindow
	{
		private TimeManager timeManager_;

		private ChestsManagerBase chestsManagerBase_;

		private UnityTimerManager unityTimerManager_;

		private SelectedChestWindowHierarchy hierarchy_;

		private RewardChest rewardChest_;

		private ViewChest viewChest_;

		private List<UIWidget> rewardHolders_;

		private Vector3 buttonDefaultPosition_ = new Vector3(0f, -255f, 0f);

		private Vector3 buttonTakePosition_ = new Vector3(0f, -420f, 0f);

		private Sequence moveSequence_;

		private Sequence rewardSequence_;

		private List<BonusItem> rewardItems_;

		private bool rewardsReady_;

		private bool chestAnimationFinished_;

		private float animationTimeStep_ = 0.1f;

		public SelectedChestWindow()
			: base(false)
		{
			SingletonManager.Get<TimeManager>(out timeManager_);
			SingletonManager.Get<UnityTimerManager>(out unityTimerManager_);
			SingletonManager.TryGet<ChestsManagerBase>(out chestsManagerBase_);
			prefabsManager.Load("ChestsPrefabsHolder");
			hierarchy_ = prefabsManager.InstantiateNGUIIn<SelectedChestWindowHierarchy>("UISelectedChestWindow", nguiManager.UiRoot.gameObject);
			ButtonSet.Up(hierarchy_.openButton, OnOpenClicked, ButtonSetGroup.InWindow);
			SetContent(hierarchy_.transform, true, true, false, false, true);
			rewardHolders_ = new List<UIWidget>();
			RayGlow rayGlow = new RayGlow();
			rayGlow.RandomizeRays();
			rayGlow.SetParent(hierarchy_.rays.transform);
			base.ViewChanged += HandleViewChanged;
			base.IsFrontChanged += OnFrontChanged;
		}

		private void HandleViewChanged(object sender, BoolEventArguments e)
		{
			SingletonManager.TryGet<ChestsManagerBase>(out chestsManagerBase_);
			VisibilityChanged(Visible && base.IsFront);
			if (!Visible)
			{
				rewardsReady_ = false;
				chestAnimationFinished_ = false;
				if (viewChest_ != null)
				{
					viewChest_.Dispose();
					viewChest_ = null;
				}
			}
		}

		private void OnFrontChanged(object sender, BoolEventArguments e)
		{
			VisibilityChanged(Visible && base.IsFront);
		}

		private void VisibilityChanged(bool visible)
		{
			if (viewChest_ != null)
			{
				viewChest_.SwitchActive(visible);
			}
		}

		public void OpenWindow(RewardChest rewardChest)
		{
			chestAnimationFinished_ = false;
			if (!Visible)
			{
				rewardChest_ = rewardChest;
				viewChest_ = new ViewChest();
				viewChest_.Instantiate(callback: OnViewChestLoaded, modelId: rewardChest.artikul.model_id);
				hierarchy_.titleLabel.text = rewardChest_.itemName;
				ClearRewards();
				windowsManager.ToggleWindow(this);
			}
			else
			{
				PlayOpenAnimation();
			}
			hierarchy_.openButton.gameObject.SetActive(rewardChest_.state != RewardChestState.Taking);
			UpdateView();
		}

		private void OnViewChestLoaded()
		{
			if (viewChest_ != null)
			{
				viewChest_.SetParent(hierarchy_.modelHolder.transform);
				viewChest_.SetCameraDistance(3.5f);
				viewChest_.SwitchActive(true);
				SetMoveSequence();
				hierarchy_.rays.alpha = 0f;
				moveSequence_.Play();
			}
		}

		private void PlayOpenAnimation()
		{
			if (rewardChest_.state == RewardChestState.Taking)
			{
				viewChest_.Animate("chest_opening");
				SoundProvider.PlaySingleSound2D(70);
				UnityTimer unityTimer = unityTimerManager_.SetTimer();
				unityTimer.Completeted += OnOpenAnimationFinished;
			}
		}

		private void OnOpenAnimationFinished()
		{
			chestAnimationFinished_ = true;
			TryGiveRewards();
		}

		private void SetMoveSequence()
		{
			if (moveSequence_ != null)
			{
				moveSequence_.Kill();
				moveSequence_ = null;
			}
			viewChest_.SetParent(hierarchy_.modelHolder.transform, false, false);
			moveSequence_ = DOTween.Sequence();
			moveSequence_.SetAutoKill(false);
			moveSequence_.Insert(0.2f, DOTween.To(() => hierarchy_.rays.alpha, delegate(float s)
			{
				hierarchy_.rays.alpha = s;
			}, 1f, 0.3f).SetEase(Ease.InOutQuad));
			moveSequence_.InsertCallback(0.3f, OnMoveFinished);
			moveSequence_.Goto(0f);
		}

		private void OnMoveFinished()
		{
			viewChest_.SetParent(hierarchy_.modelHolder.transform);
			PlayOpenAnimation();
		}

		public void RewardsReady(List<BonusItem> rewardItems)
		{
			rewardItems_ = rewardItems;
			rewardsReady_ = true;
			TryGiveRewards();
		}

		private UIWidget MakeRewardHolder(Transform transform)
		{
			UIWidget uIWidget = PrepareRewardHolder();
			transform.SetParent(uIWidget.transform, false);
			transform.localScale = Vector3.zero;
			transform.gameObject.SetActive(true);
			return uIWidget;
		}

		public void TryGiveRewards()
		{
			if (!rewardsReady_ || !chestAnimationFinished_)
			{
				return;
			}
			ClearRewards();
			hierarchy_.receivedItems.gameObject.SetActive(true);
			if (rewardSequence_ != null)
			{
				rewardSequence_.Kill();
				rewardSequence_ = null;
			}
			rewardSequence_ = DOTween.Sequence();
			rewardSequence_.SetAutoKill(false);
			int num = 0;
			foreach (BonusItem item2 in rewardItems_)
			{
				HideVoxelsEntries value;
				if (item2.bonusItemType == BonusItemType.Artikul)
				{
					SlotModel slotModel = new SlotModel();
					slotModel.CanDrag = false;
					slotModel.CanDrop = false;
					slotModel.Insert(item2.artikulId, item2.count, item2.wear);
					SlotController slotController = new SlotController(SlotViewType.Normal, slotModel);
					slotController.SetParent(hierarchy_.receivedItemsTable.transform);
					rewardHolders_.Add(slotController.View.Container);
					AddToRewardSequence(slotController.View.Container, slotController.View.Container.transform, num);
				}
				else if (item2.bonusItemType == BonusItemType.Money)
				{
					SelectedChestRewardItemHierarchy selectedChestRewardItemHierarchy = Object.Instantiate(hierarchy_.chestRewardItem);
					UIWidget item = MakeRewardHolder(selectedChestRewardItemHierarchy.transform);
					selectedChestRewardItemHierarchy.widget.alpha = 0f;
					selectedChestRewardItemHierarchy.count.text = item2.count.ToString();
					rewardHolders_.Add(item);
					AddToRewardSequence(selectedChestRewardItemHierarchy.widget, selectedChestRewardItemHierarchy.transform, num);
				}
				else if (item2.bonusItemType == BonusItemType.HideVoxel && HideAndSeekContentMap.HideVoxels.TryGetValue(item2.hideVoxelId, out value))
				{
					SlotModel slotModel2 = new SlotModel();
					slotModel2.Interactable = false;
					slotModel2.Insert(value.artikul.id, item2.count, item2.wear);
					SlotController slotController2 = new SlotController(SlotViewType.Normal, slotModel2);
					slotController2.SetParent(hierarchy_.receivedItemsTable.transform);
					rewardHolders_.Add(slotController2.View.Container);
					AddToRewardSequence(slotController2.View.Container, slotController2.View.Container.transform, num);
				}
				num++;
			}
			rewardSequence_.AppendCallback(delegate
			{
				hierarchy_.openButton.gameObject.SetActive(true);
			});
			hierarchy_.receivedItemsTable.Reposition();
			UpdateView();
			rewardSequence_.Play();
		}

		private void AddToRewardSequence(UIWidget widget, Transform transform, int step)
		{
			float atPosition = (float)step * animationTimeStep_;
			rewardSequence_.Insert(atPosition, DOTween.To(() => widget.alpha, delegate(float s)
			{
				widget.alpha = s;
			}, 1f, animationTimeStep_).SetEase(Ease.InOutQuad));
			rewardSequence_.Insert(atPosition, DOTween.To(() => transform.localScale, delegate(Vector3 s)
			{
				transform.localScale = s;
			}, Vector3.one, animationTimeStep_).SetEase(Ease.InOutQuad));
		}

		private UIWidget PrepareRewardHolder()
		{
			UIWidget uIWidget = Object.Instantiate(hierarchy_.chestRewardHolder);
			uIWidget.transform.SetParent(hierarchy_.receivedItemsTable.transform, false);
			uIWidget.transform.localScale = Vector3.one;
			uIWidget.gameObject.SetActive(true);
			return uIWidget;
		}

		private void ClearRewards()
		{
			hierarchy_.receivedItems.gameObject.SetActive(false);
			for (int i = 0; i < rewardHolders_.Count; i++)
			{
				Object.Destroy(rewardHolders_[i].gameObject);
				rewardHolders_[i] = null;
			}
			rewardHolders_ = new List<UIWidget>();
		}

		public void UpdateView()
		{
			if (!Visible || rewardChest_ == null)
			{
				return;
			}
			base.Hierarchy.closeButtonWidget.gameObject.SetActive(true);
			hierarchy_.openButton.transform.localPosition = buttonDefaultPosition_;
			if (rewardChest_.state == RewardChestState.Opening)
			{
				hierarchy_.titleLabel.gameObject.SetActive(false);
				hierarchy_.currentTimeLabel.gameObject.SetActive(true);
				hierarchy_.timeToOpenLabel.gameObject.SetActive(false);
				hierarchy_.priceWidget.gameObject.SetActive(true);
				hierarchy_.statusLabel.text = Localisations.Get("UI_TimeLeft");
				hierarchy_.currentTimeLabel.text = TimeUtils.ToTimerCounter(rewardChest_.EndTime - timeManager_.CurrentTimestamp);
				hierarchy_.priceLabel.text = ChestsManagerBase.GetCurrentBoostPrice(rewardChest_, timeManager_.CurrentTimestamp).ToString();
				hierarchy_.openLabel.text = Localisations.Get("UI_Open_Now");
				hierarchy_.openButton.normalSprite = "button_yellow";
			}
			else if (rewardChest_.state == RewardChestState.Idle)
			{
				if (chestsManagerBase_ != null && chestsManagerBase_.OpeningChest == null)
				{
					hierarchy_.titleLabel.gameObject.SetActive(true);
					hierarchy_.priceWidget.gameObject.SetActive(false);
					hierarchy_.currentTimeLabel.gameObject.SetActive(false);
					hierarchy_.timeToOpenLabel.gameObject.SetActive(true);
					hierarchy_.timeToOpenLabel.text = TimeUtils.ToTimerCounter(rewardChest_.timeToOpen);
					hierarchy_.statusLabel.text = string.Empty;
					hierarchy_.openLabel.text = Localisations.Get("UI_Unlock");
					hierarchy_.openButton.normalSprite = "button_green";
				}
				else
				{
					hierarchy_.titleLabel.gameObject.SetActive(false);
					hierarchy_.priceWidget.gameObject.SetActive(true);
					hierarchy_.currentTimeLabel.gameObject.SetActive(false);
					hierarchy_.timeToOpenLabel.gameObject.SetActive(false);
					hierarchy_.statusLabel.text = Localisations.Get("UI_Opening_Other");
					hierarchy_.priceLabel.text = rewardChest_.boostPrice.ToString();
					hierarchy_.openLabel.text = Localisations.Get("UI_Open_Now");
					hierarchy_.openButton.normalSprite = "button_yellow";
				}
			}
			else if (rewardChest_.state == RewardChestState.Completed)
			{
				hierarchy_.titleLabel.gameObject.SetActive(true);
				hierarchy_.currentTimeLabel.gameObject.SetActive(false);
				hierarchy_.timeToOpenLabel.gameObject.SetActive(false);
				hierarchy_.priceWidget.gameObject.SetActive(false);
				hierarchy_.statusLabel.text = string.Empty;
				hierarchy_.openLabel.text = Localisations.Get("UI_Open");
				hierarchy_.openButton.normalSprite = "button_green";
			}
			else if (rewardChest_.state == RewardChestState.Taking)
			{
				hierarchy_.openButton.transform.localPosition = buttonTakePosition_;
				hierarchy_.openButton.normalSprite = "button_green";
				base.Hierarchy.closeButtonWidget.gameObject.SetActive(false);
				hierarchy_.titleLabel.gameObject.SetActive(false);
				hierarchy_.currentTimeLabel.gameObject.SetActive(false);
				hierarchy_.timeToOpenLabel.gameObject.SetActive(false);
				hierarchy_.priceWidget.gameObject.SetActive(false);
				hierarchy_.statusLabel.text = string.Empty;
				hierarchy_.openLabel.text = Localisations.Get("UI_Take");
			}
		}

		private void OnOpenClicked()
		{
			if (rewardChest_.state == RewardChestState.Taking)
			{
				viewChest_.Animate("chest_closing");
				ToggleWindow();
			}
			else if (chestsManagerBase_ != null)
			{
				if (rewardChest_.state == RewardChestState.Idle && chestsManagerBase_.OpeningChest == null)
				{
					chestsManagerBase_.StartChest(rewardChest_);
				}
				else
				{
					chestsManagerBase_.OpenChest(rewardChest_);
				}
			}
		}

		public void ToggleWindow()
		{
			windowsManager.ToggleWindow(this);
		}

		public override void Clear()
		{
			base.ViewChanged -= HandleViewChanged;
		}
	}
}
