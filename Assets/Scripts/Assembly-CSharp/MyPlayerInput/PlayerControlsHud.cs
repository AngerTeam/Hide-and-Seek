using System;
using CraftyEngine.Utils;
using DG.Tweening;
using Extensions;
using HudSystem;

namespace MyPlayerInput
{
	public class PlayerControlsHud : HeadUpDisplay, IPlayerControlsHud
	{
		private readonly ActionButtonsManager actionButtonsManager_;

		public readonly ActionButtonHierarchy actionButton;

		public readonly ActionButtonHierarchy actionAltButton;

		private readonly ActionButtonHierarchy abilityButton_;

		private readonly ActionButtonHierarchy aimButton_;

		private readonly ReloadButtonHierarchy reloadButton_;

		private readonly GrenadeButtonHierarchy grenadeButton_;

		private readonly JoystickController moveJoystickController_;

		private Sequence cooldownSequence_;

		private Sequence grenadeCooldownSequence_;

		private Sequence abilityCooldownSequence_;

		private bool visibleAimButton_;

		private bool visibleActionAltButton_;

		private bool visibleReloadButton_;

		private bool visibleAbilityButton_;

		public bool VisibleAimButton
		{
			get
			{
				return visibleAimButton_;
			}
			set
			{
				visibleAimButton_ = value;
				aimButton_.gameObject.SetActive(visibleAimButton_);
			}
		}

		public bool VisibleActionAltButton
		{
			get
			{
				return visibleActionAltButton_;
			}
			set
			{
				visibleActionAltButton_ = value;
				actionAltButton.gameObject.SetActive(visibleActionAltButton_);
			}
		}

		public bool VisibleReloadButton
		{
			get
			{
				return visibleReloadButton_;
			}
			set
			{
				visibleReloadButton_ = value;
				reloadButton_.gameObject.SetActive(visibleReloadButton_);
			}
		}

		public bool VisibleAbilityButton
		{
			get
			{
				return visibleAbilityButton_;
			}
			set
			{
				visibleAbilityButton_ = value;
				abilityButton_.gameObject.SetActive(visibleAbilityButton_);
			}
		}

		public event Action JumpButtonPressed;

		public event Action JumpButtonReleased;

		public event Action AimButtonClicked;

		public event Action ReloadButtonClicked;

		public event Action AbilityButtonClicked;

		public event Action GrenadeButtonClicked;

		public PlayerControlsHud()
		{
			actionButtonsManager_ = new ActionButtonsManager();
			moveJoystickController_ = new JoystickController();
			prefabsManager.Load("MyPlayerInput");
			actionButton = prefabsManager.InstantiateNGUIIn<ActionButtonHierarchy>("UIActionButton", nguiManager.UiRoot.Ability1Container.gameObject);
			actionAltButton = prefabsManager.InstantiateNGUIIn<ActionButtonHierarchy>("UIActionButton", nguiManager.UiRoot.Ability1AltContainer.gameObject);
			abilityButton_ = prefabsManager.InstantiateNGUIIn<ActionButtonHierarchy>("UIActionButton", nguiManager.UiRoot.SpecialAbilityContainer.gameObject);
			aimButton_ = prefabsManager.InstantiateNGUIIn<ActionButtonHierarchy>("UIAimButton", nguiManager.UiRoot.AimButtonContainer.gameObject);
			reloadButton_ = prefabsManager.InstantiateNGUIIn<ReloadButtonHierarchy>("UIReloadButton", nguiManager.UiRoot.Ability2Container.gameObject);
			grenadeButton_ = prefabsManager.InstantiateNGUIIn<GrenadeButtonHierarchy>("UIGrenadeButton", nguiManager.UiRoot.Ability3Container.gameObject);
			actionButtonsManager_.AddButton(actionButton);
			actionButtonsManager_.AddButton(actionAltButton);
			actionButtonsManager_.AddButton(aimButton_);
			actionButtonsManager_.AddButton(reloadButton_);
			actionButtonsManager_.AddButton(abilityButton_);
			actionButton.cooldownSprite.fillAmount = 0f;
			abilityButton_.cooldownSprite.fillAmount = 0f;
			actionAltButton.cooldownSprite.fillAmount = 0f;
			grenadeButton_.gameObject.SetActive(false);
			reloadButton_.cooldownSprite.fillAmount = 0f;
			reloadButton_.click.Clicked += ReportReloadButtonClick;
			aimButton_.button.autoDisableOnPress = false;
			EventDelegate.Set(aimButton_.button.onClick, HandleAimButtonClick);
			grenadeButton_.cooldownSprite.fillAmount = 0f;
			grenadeButton_.button.autoDisableOnPress = false;
			EventDelegate.Set(grenadeButton_.button.onClick, HandleGrenadeButtonClick);
			EventDelegate.Set(abilityButton_.button.onClick, HandleAbilityButtonClick);
			ActionButtonHierarchy actionButtonHierarchy = prefabsManager.InstantiateNGUIIn<ActionButtonHierarchy>("UIJumpButton", nguiManager.UiRoot.JumpButtonContainer.gameObject);
			VisibleAimButton = false;
			VisibleActionAltButton = false;
			VisibleReloadButton = false;
			visibleAbilityButton_ = false;
			hudStateSwitcher.Register(1, actionButtonHierarchy);
			hudStateSwitcher.Register(1, moveJoystickController_.gameObject);
			hudStateSwitcher.Register(4, aimButton_);
			hudStateSwitcher.Register(4, actionButton);
			hudStateSwitcher.Register(4, actionAltButton);
			hudStateSwitcher.Register(4, reloadButton_);
			hudStateSwitcher.Register(4, abilityButton_);
			hudStateSwitcher.Changed += HandleHudStateChanged;
			if (CompileConstants.MOBILE)
			{
				actionButtonsManager_.AddButton(actionButtonHierarchy, HandleJumpButtonClick, HandleJumpButtonRelease);
			}
			SetupColldown();
			grenadeCooldownSequence_ = CreateCooldownSequence(grenadeButton_.cooldownSprite);
			abilityCooldownSequence_ = CreateCooldownSequence(abilityButton_.cooldownSprite);
		}

		private void SetupColldown()
		{
			cooldownSequence_ = DOTween.Sequence();
			cooldownSequence_.Pause();
			cooldownSequence_.InsertCallback(0f, ResetTimeAlpha);
			cooldownSequence_.Insert(0f, DOTween.To(() => actionButton.cooldownSprite.fillAmount, delegate(float a)
			{
				reloadButton_.cooldownSprite.fillAmount = a;
			}, 1f, 1f).SetEase(Ease.Linear));
			cooldownSequence_.InsertCallback(1f, ResetTimeScale);
			cooldownSequence_.Insert(1f, DOTween.To(() => actionButton.cooldownSprite.alpha, delegate(float a)
			{
				reloadButton_.cooldownSprite.alpha = a;
			}, 0f, 1f).SetEase(Ease.Linear));
			cooldownSequence_.SetAutoKill(false);
		}

		private Sequence CreateCooldownSequence(UISprite cooldownSprite)
		{
			Sequence sequence = DOTween.Sequence();
			sequence.Pause();
			sequence.InsertCallback(0f, delegate
			{
				cooldownSprite.alpha = 1f;
			});
			sequence.Insert(0f, DOTween.To(() => cooldownSprite.fillAmount, delegate(float a)
			{
				cooldownSprite.fillAmount = a;
			}, 1f, 1f).SetEase(Ease.Linear));
			sequence.InsertCallback(1f, delegate
			{
				sequence.timeScale = 1f;
			});
			sequence.Insert(1f, DOTween.To(() => cooldownSprite.alpha, delegate(float a)
			{
				cooldownSprite.alpha = a;
			}, 0f, 1f).SetEase(Ease.Linear));
			sequence.SetAutoKill(false);
			return sequence;
		}

		public override void Dispose()
		{
			hudStateSwitcher.Changed -= HandleHudStateChanged;
			moveJoystickController_.Clear();
			cooldownSequence_.Kill();
			cooldownSequence_ = null;
			actionButtonsManager_.Dispose();
		}

		public override void Resubscribe()
		{
			moveJoystickController_.Clear();
			moveJoystickController_.Subscribe();
		}

		public void SetAbilityButton(string iconName)
		{
			abilityButton_.icon.spriteName = iconName;
		}

		public void SetActionButton(string iconName)
		{
			actionButton.icon.spriteName = iconName;
			actionAltButton.icon.spriteName = iconName;
		}

		public void SetReloadButton(int ammoCount)
		{
			reloadButton_.ammoLabel.text = ammoCount.ToString();
		}

		public void SetGrenadeAmmo(int ammoCount)
		{
			grenadeButton_.ammoLabel.text = ammoCount.ToString();
		}

		public void PlayCooldown(float duration)
		{
			cooldownSequence_.timeScale = 1f / duration;
			cooldownSequence_.Restart();
		}

		public void PlayGrenadeCooldown(float duration)
		{
			grenadeCooldownSequence_.timeScale = 1f / duration;
			grenadeCooldownSequence_.Restart();
		}

		public void PlayAbilityCooldown(float duration)
		{
			abilityCooldownSequence_.timeScale = 1f / duration;
			abilityCooldownSequence_.Restart();
		}

		private void HandleJumpButtonClick()
		{
			this.JumpButtonPressed.SafeInvoke();
		}

		private void HandleJumpButtonRelease()
		{
			this.JumpButtonReleased.SafeInvoke();
		}

		private void HandleAimButtonClick()
		{
			this.AimButtonClicked.SafeInvoke();
		}

		private void HandleGrenadeButtonClick()
		{
			this.GrenadeButtonClicked.SafeInvoke();
		}

		private void HandleAbilityButtonClick()
		{
			this.AbilityButtonClicked.SafeInvoke();
		}

		private void HandleHudStateChanged()
		{
			if (EnumUtils.Contains(hudStateSwitcher.SelectedType, 4))
			{
				aimButton_.gameObject.SetActive(visibleAimButton_);
				actionAltButton.gameObject.SetActive(visibleActionAltButton_);
				reloadButton_.gameObject.SetActive(visibleReloadButton_);
				abilityButton_.gameObject.SetActive(visibleAbilityButton_);
			}
		}

		private void ReportReloadButtonClick(ActionButtonHierarchy button)
		{
			this.ReloadButtonClicked.SafeInvoke();
		}

		private void ResetTimeAlpha()
		{
			actionButton.cooldownSprite.alpha = 1f;
			actionAltButton.cooldownSprite.alpha = 1f;
			reloadButton_.cooldownSprite.alpha = 1f;
			abilityButton_.cooldownSprite.alpha = 1f;
		}

		private void ResetTimeScale()
		{
			cooldownSequence_.timeScale = 1f;
		}
	}
}
