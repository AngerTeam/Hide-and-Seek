using System;
using CraftyEngine.Infrastructure;
using CraftyEngine.Sounds;
using DG.Tweening;
using Extensions;
using HudSystem;
using NguiTools;
using PlayerModule.MyPlayer;
using UnityEngine;

namespace HideAndSeek
{
	public class HideAndSeekActionsHud : GuiModlule
	{
		private ActionButtonHierarchy actionButton_;

		private InputModel inputManager_;

		private MyPlayerStatsModel myPlayerStatsModel_;

		private Sequence sequence_;

		private RushWidgetHierarchy rushWidget_;

		private GameModel gameModel_;

		public event Action ActionButtonClicked;

		public HideAndSeekActionsHud()
		{
			SingletonManager.Get<InputModel>(out inputManager_);
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			SingletonManager.Get<GameModel>(out gameModel_);
			myPlayerStatsModel_.stats.hideAndSeek.RoleChanged += HandleRoleChanged;
			PrefabsManagerNGUI prefabsManagerNGUI = SingletonManager.Get<PrefabsManagerNGUI>();
			NguiManager nguiManager = SingletonManager.Get<NguiManager>();
			prefabsManagerNGUI.Load("MyPlayerInput");
			actionButton_ = prefabsManagerNGUI.InstantiateNGUIIn<ActionButtonHierarchy>("UIActionButton", nguiManager.UiRoot.SpecialAbilityContainer.gameObject);
			ButtonSet.Up(actionButton_.button, HandleClick, ButtonSetGroup.Hud);
			actionButton_.button.onPress += HandlePress;
			actionButton_.cooldownSprite.gameObject.SetActive(false);
			int num = 90;
			actionButton_.widget.SetAnchor(nguiManager.UiRoot.SpecialAbilityContainer.gameObject, 0.5f, -num, 0.5f, -num, 0.5f, num, 0.5f, num);
			rushWidget_ = prefabsManagerNGUI.InstantiateNGUIIn<RushWidgetHierarchy>("UIRushWidget", nguiManager.UiRoot.gameObject);
			rushWidget_.container.SetAnchor(nguiManager.UiRoot.gameObject, 0.5f, 0, 0.5f, 0, 0.5f, 0, 0.5f, 0);
			rushWidget_.stageTitleLabel.text = Localisations.Get("UI_HNS_MonstrStage");
			rushWidget_.stageHintLabel.text = Localisations.Get("UI_HNS_MonstrStage_hint");
			string text = Localisations.Get("UI_HNS_MonstrStage_stats");
			text = text.Replace("%defence%", HideAndSeekContentMap.HideSeekSettings.hidePlayerDefenseCoef.ToString());
			text = text.Replace("%damage%", HideAndSeekContentMap.HideSeekSettings.hidePlayerDamageCoef.ToString());
			rushWidget_.statsLabel.text = text;
			SetupSequence(rushWidget_.container);
			HandleRoleChanged();
			gameModel_.StageChanged += HandleStageChanged;
		}

		private void HandleStageChanged()
		{
			if (gameModel_.CurrentStage.id == 4 && myPlayerStatsModel_.stats.Side == 3)
			{
				SoundProvider.PlaySingleSound2D(HideAndSeekContentMap.HideSeekSettings.MONSTER_STAGE_START_SOUND_ID);
				sequence_.Restart();
			}
		}

		private void HandleRoleChanged()
		{
			bool active = !myPlayerStatsModel_.stats.hideAndSeek.IsSeeker;
			bool isHidden = myPlayerStatsModel_.stats.hideAndSeek.IsHidden;
			bool isMonstr = myPlayerStatsModel_.stats.hideAndSeek.IsMonstr;
			actionButton_.gameObject.SetActive(active);
			int num = ((!isMonstr) ? 90 : 60);
			actionButton_.widget.bottomAnchor.absolute = -num;
			actionButton_.widget.topAnchor.absolute = num;
			actionButton_.widget.leftAnchor.absolute = -num;
			actionButton_.widget.rightAnchor.absolute = num;
			SetActionButton((!isHidden) ? "Eye1_opened_trans" : "Eye1_closed_trans");
		}

		private void SetupSequence(UIWidget widget)
		{
			rushWidget_.container.gameObject.SetActive(false);
			Transform transform = widget.transform;
			Vector3 endValue = Vector3.one * 1.2f;
			Vector3 vector = Vector3.one * 0.2f;
			transform.localScale = vector;
			widget.color = new Color(1f, 1f, 1f, 0f);
			float num = 0.5f;
			float num2 = 3f;
			float duration = 1.5f;
			sequence_ = DOTween.Sequence();
			sequence_.AppendCallback(delegate
			{
				widget.gameObject.SetActive(true);
			});
			sequence_.Insert(0f, DOTween.ToAlpha(() => widget.color, delegate(Color c)
			{
				widget.color = c;
			}, 1f, num).SetEase(Ease.Linear));
			sequence_.Insert(0f, DOTween.To(() => transform.localScale, delegate(Vector3 c)
			{
				transform.localScale = c;
			}, endValue, num).SetEase(Ease.OutQuad));
			sequence_.Insert(num2 + num, DOTween.ToAlpha(() => widget.color, delegate(Color c)
			{
				widget.color = c;
			}, 0f, duration).SetEase(Ease.Linear));
			sequence_.Insert(num2 + num, DOTween.To(() => transform.localScale, delegate(Vector3 c)
			{
				transform.localScale = c;
			}, vector, duration).SetEase(Ease.InQuad));
			sequence_.AppendCallback(delegate
			{
				widget.gameObject.SetActive(false);
			});
			sequence_.SetAutoKill(false);
			sequence_.Pause();
		}

		private void HandlePress()
		{
			inputManager_.CurrentInstance.Used = true;
		}

		private void HandleClick()
		{
			this.ActionButtonClicked.SafeInvoke();
		}

		public override void Dispose()
		{
			sequence_.Kill();
			this.ActionButtonClicked = null;
			myPlayerStatsModel_.stats.hideAndSeek.RoleChanged -= HandleRoleChanged;
			UnityEngine.Object.Destroy(actionButton_.gameObject);
			UnityEngine.Object.Destroy(rushWidget_.gameObject);
		}

		public void SetActionButton(string iconName)
		{
			actionButton_.icon.spriteName = iconName;
		}
	}
}
