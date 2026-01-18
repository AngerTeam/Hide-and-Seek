using System;
using ChestsViewModule;
using CraftyEngine.Infrastructure;
using CraftyEngine.Sounds;
using CraftyEngine.Utils;
using CraftyGameEngine.Gui.Fx;
using DG.Tweening;
using DailyBonusModule;
using Extensions;
using HudSystem;
using InventoryModule;
using NguiTools;
using UnityEngine;
using WindowsModule;

public class DailyBonusWindow : GameWindow
{
	public Action WindowShow;

	public Action WindowHide;

	private DailyBonusModel model_;

	private NguiManager nguiManager_;

	private NguiFileManager nguiFileManager_;

	private DailyBonusController dailyBonusManager_;

	private DailyBonusWindowHierarchy windowHierarchy_;

	private DailyBonusItemHierarchy[] bonusItems_;

	private DailyBonusItemHierarchy selectedBonus_;

	private RayGlow rayGlow_;

	private Sequence bubbleSequence_;

	private ViewChest viewChest_;

	private QueueManager queueManager_;

	public DailyBonusWindow()
		: base(false)
	{
		prefabsManager.Load("DailyBonusModule");
		SingletonManager.Get<DailyBonusModel>(out model_);
		SingletonManager.Get<DailyBonusController>(out dailyBonusManager_);
		SingletonManager.Get<NguiFileManager>(out nguiFileManager_);
		SingletonManager.Get<NguiManager>(out nguiManager_);
		SingletonManager.Get<QueueManager>(out queueManager_);
		windowHierarchy_ = prefabsManager.InstantiateNGUIIn<DailyBonusWindowHierarchy>("UIDailyBonusWindow", nguiManager.UiRoot.gameObject);
		windowHierarchy_.GetBonusButtonLabel.text = Localisations.Get("UI_Button_Open_Daily_Chest");
		windowHierarchy_.GetBonusNowButtonLabel.text = Localisations.Get("UI_Open_Now");
		windowHierarchy_.CollectBonusButtonLabel.text = Localisations.Get("UI_Take");
		windowHierarchy_.TitleLabel.text = Localisations.Get("UI_Lucky_Chest");
		windowHierarchy_.TitleLabelCopy.text = windowHierarchy_.TitleLabel.text;
		windowHierarchy_.DescriptionLabel.text = Localisations.Get("UI_TimeLeft");
		ButtonSet.Up(windowHierarchy_.GetBonusButton, OnGetBonusFree, ButtonSetGroup.InWindow);
		ButtonSet.Up(windowHierarchy_.GetBonusNowButton, OnGetBonus, ButtonSetGroup.InWindow);
		ButtonSet.Up(windowHierarchy_.CollectBonusButton, OnCollectBonus, ButtonSetGroup.InWindow);
		ButtonSet.Up(windowHierarchy_.PrevBonusButton, OnPrevBonus, ButtonSetGroup.InWindow);
		ButtonSet.Up(windowHierarchy_.NextBonusButton, OnNextBonus, ButtonSetGroup.InWindow);
		rayGlow_ = new RayGlow();
		rayGlow_.RandomizeRays();
		rayGlow_.SetParent(windowHierarchy_.Rays);
		SetContent(windowHierarchy_.transform, true, true, false, false, true);
		base.ViewChanged += OnViewChanged;
		base.IsFrontChanged += OnFrontChanged;
	}

	public void OpenWindow(RewardChest chest)
	{
		if (viewChest_ == null)
		{
			viewChest_ = new ViewChest();
			viewChest_.Instantiate(callback: OnViewChestLoaded, modelId: chest.artikul.model_id);
		}
		if (!Visible)
		{
			windowsManager.ToggleWindow(this);
		}
	}

	private void OnViewChestLoaded()
	{
		viewChest_.SetParent(windowHierarchy_.ChestHolder.transform, true);
		viewChest_.SetCameraDistance(2.4f);
		viewChest_.SwitchActive(true);
		viewChest_.Animate("chest_impatience");
	}

	public void InitBonuses()
	{
		model_.loading = true;
		UnityThreadQueue queue = queueManager_.AddUnityThreadQueue();
		bonusItems_ = new DailyBonusItemHierarchy[dailyBonusManager_.bonuses.Count];
		for (int i = 0; i < dailyBonusManager_.bonuses.Count; i++)
		{
			BonusItem bonusItem = dailyBonusManager_.bonuses[i];
			bonusItems_[i] = prefabsManager.InstantiateNGUIIn<DailyBonusItemHierarchy>("UIDailyBonusItem", windowHierarchy_.Container.gameObject);
			bonusItems_[i].gameObject.SetActive(false);
			bonusItems_[i].Select.gameObject.SetActive(false);
			switch (bonusItem.bonusItemType)
			{
			case BonusItemType.Artikul:
			{
				ArtikulsEntries value2;
				if (InventoryContentMap.Artikuls.TryGetValue(bonusItem.artikulId, out value2))
				{
					bonusItems_[i].DescriptionLabel.text = value2.title;
					bonusItems_[i].CountLabel.text = string.Empty;
					if (!string.IsNullOrEmpty(value2.large_icon))
					{
						string fullLargeIconPath2 = value2.GetFullLargeIconPath();
						bonusItems_[i].Texture.gameObject.SetActive(true);
						bonusItems_[i].Icon.gameObject.SetActive(false);
						nguiFileManager_.SetUiTexture(bonusItems_[i].Texture, fullLargeIconPath2, queue);
					}
					else
					{
						bonusItems_[i].Texture.gameObject.SetActive(false);
						bonusItems_[i].Icon.gameObject.SetActive(true);
						nguiManager_.SetIconSprite(bonusItems_[i].Icon, value2.id.ToString());
					}
					RarityEntries value3;
					InventoryContentMap.Rarity.TryGetValue(value2.rarity_id, out value3);
					if (value3 == null)
					{
						InventoryContentMap.Rarity.TryGetValue(InventoryContentMap.CraftSettings.default_rarity_id, out value3);
					}
					if (value3 != null)
					{
						bonusItems_[i].Rarity.spriteName = value3.background_sprite_name;
					}
				}
				break;
			}
			case BonusItemType.Money:
			{
				ArtikulsEntries value;
				if (InventoryContentMap.Artikuls.TryGetValue(InventoryContentMap.CraftSettings.CRYSTAL_ARTIKUL_ID, out value))
				{
					bonusItems_[i].DescriptionLabel.text = value.title;
					bonusItems_[i].CountLabel.text = bonusItem.count.ToString();
					string fullLargeIconPath = value.GetFullLargeIconPath();
					bonusItems_[i].Texture.gameObject.SetActive(true);
					bonusItems_[i].Icon.gameObject.SetActive(false);
					nguiFileManager_.SetUiTexture(bonusItems_[i].Texture, fullLargeIconPath, queue);
				}
				break;
			}
			}
			windowHierarchy_.PriceLabel.text = DailyBonusContentMap.DailyBonusSettings.dailyBonusPrice.ToString();
		}
		queueManager_.AddTask(Init, queue);
		UpdateUIElements();
	}

	private void Init()
	{
		for (int i = 0; i < bonusItems_.Length; i++)
		{
			bonusItems_[i].gameObject.SetActive(true);
		}
		windowHierarchy_.scroller.Init(bonusItems_, true);
		model_.loading = false;
	}

	public void DisposeBonuses()
	{
		windowHierarchy_.scroller.Dispose();
		bonusItems_ = null;
		selectedBonus_ = null;
	}

	public void UpdateUIElements()
	{
		base.Hierarchy.closeButton.gameObject.SetActive(model_.collected);
		windowHierarchy_.ScrollViewDrag.gameObject.SetActive(model_.collected);
		windowHierarchy_.PrevBonusButton.gameObject.SetActive(model_.collected);
		windowHierarchy_.NextBonusButton.gameObject.SetActive(model_.collected);
		windowHierarchy_.TimeLabel.gameObject.SetActive(model_.collected && !model_.avalible);
		windowHierarchy_.DescriptionLabel.gameObject.SetActive(model_.collected && !model_.avalible);
		windowHierarchy_.GetBonusNowButton.gameObject.SetActive(model_.collected && !model_.avalible);
		windowHierarchy_.GetBonusButton.gameObject.SetActive(model_.collected && model_.avalible);
		windowHierarchy_.CollectBonusButton.gameObject.SetActive(!model_.collected && !model_.rolling);
		windowHierarchy_.Trigger.gameObject.SetActive(!model_.collected);
		windowHierarchy_.TimeLabel.text = TimeUtils.ToTimerCounter(dailyBonusManager_.TimeLeft);
	}

	public void SpinBonuses(int targetIndex)
	{
		windowHierarchy_.scroller.Spin(2, targetIndex);
	}

	public void SelectBonus(DailyBonusItemHierarchy bonusItem)
	{
		DeselectBonus(selectedBonus_);
		selectedBonus_ = bonusItem;
		if (selectedBonus_ != null)
		{
			selectedBonus_.Select.gameObject.SetActive(true);
		}
	}

	public void DeselectBonus(DailyBonusItemHierarchy bonusItem)
	{
		if (bonusItem != null)
		{
			bonusItem.Select.gameObject.SetActive(false);
		}
	}

	private void ShowBonuses()
	{
		WindowShow.SafeInvoke();
		windowHierarchy_.scroller.OnScrollingFinish += OnScrollingFinish;
		windowHierarchy_.scroller.OnScrollingStart += OnScrollingStart;
		windowHierarchy_.scroller.OnChangeElement += OnChangeElement;
		InitBonuses();
	}

	private void HideBonuses()
	{
		WindowHide.SafeInvoke();
		windowHierarchy_.scroller.OnScrollingFinish -= OnScrollingFinish;
		windowHierarchy_.scroller.OnScrollingStart -= OnScrollingStart;
		windowHierarchy_.scroller.OnChangeElement -= OnChangeElement;
		DisposeBonuses();
	}

	private void OnViewChanged(object sender, BoolEventArguments e)
	{
		if (Visible)
		{
			ShowBonuses();
		}
		else
		{
			HideBonuses();
		}
		VisibilityChanged(Visible && base.IsFront);
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

	private void OnScrollingStart()
	{
	}

	private void OnChangeElement()
	{
		if (model_.rolling)
		{
			SoundProvider.PlaySingleSound2D(7);
		}
	}

	private void OnScrollingFinish()
	{
		if (model_.rolling)
		{
			model_.rolling = false;
		}
	}

	private void OnCollectBonus()
	{
		if (!model_.loading)
		{
			model_.collected = true;
			UpdateUIElements();
		}
	}

	private void OnGetBonusFree()
	{
		if (!model_.loading)
		{
			dailyBonusManager_.GetDailyBonusFree();
			model_.avalible = false;
			model_.collected = false;
			model_.opened = false;
			model_.rolling = true;
			UpdateUIElements();
		}
	}

	private void OnGetBonus()
	{
		if (!model_.loading && dailyBonusManager_.GetDailyBonus())
		{
			model_.avalible = false;
			model_.collected = false;
			model_.opened = false;
			model_.rolling = true;
			UpdateUIElements();
		}
	}

	private void OnNextBonus()
	{
		if (!model_.loading)
		{
			int num = windowHierarchy_.scroller.VisualElementsCount / 2;
			if (num > 0)
			{
				windowHierarchy_.scroller.ShiftScrollElementsByElements(num);
			}
		}
	}

	private void OnPrevBonus()
	{
		if (!model_.loading)
		{
			int num = windowHierarchy_.scroller.VisualElementsCount / 2;
			if (num > 0)
			{
				windowHierarchy_.scroller.ShiftScrollElementsByElements(-num);
			}
		}
	}

	public void SwitchState()
	{
		UpdateUIElements();
	}

	public void StartStateAvalible()
	{
		if (viewChest_ != null)
		{
			viewChest_.Animate("chest_idle");
		}
	}

	public void StartStateNotAvalible()
	{
		if (viewChest_ != null)
		{
			viewChest_.Animate("chest_closing");
		}
	}

	public void StartStateRolling()
	{
		if (bubbleSequence_ != null)
		{
			bubbleSequence_.Restart();
			bubbleSequence_.Kill();
		}
		windowHierarchy_.Trigger.SetActive(true);
		if (viewChest_ != null)
		{
			viewChest_.Animate("chest_impatience");
		}
	}

	public void ExitStateRolling()
	{
		Log.Info("ExitStateRolling");
		if (bubbleSequence_ != null)
		{
			bubbleSequence_.Restart();
			bubbleSequence_.Kill(true);
		}
		Transform element = windowHierarchy_.scroller.GetSelectedElement().element;
		if (element != null)
		{
			bubbleSequence_ = DOTween.Sequence();
			bubbleSequence_.Insert(0f, element.DOScale(new Vector3(1.1f, 1.1f, 1.1f), 1.5f));
			bubbleSequence_.SetLoops(-1, LoopType.Yoyo);
			DailyBonusItemHierarchy component = element.GetComponent<DailyBonusItemHierarchy>();
			if (component != null)
			{
				SelectBonus(component);
			}
		}
		SoundProvider.PlaySingleSound2D(70);
		if (viewChest_ != null)
		{
			viewChest_.Animate("chest_opening");
		}
	}

	public void StartStateOpened()
	{
		windowHierarchy_.Trigger.SetActive(false);
	}

	public void ExitStateOpened()
	{
		if (bubbleSequence_ != null)
		{
			bubbleSequence_.Restart();
			bubbleSequence_.Kill(true);
		}
		DeselectBonus(selectedBonus_);
		SoundProvider.PlaySingleSound2D(14);
		if (viewChest_ != null)
		{
			viewChest_.Animate("chest_closing");
		}
	}
}
