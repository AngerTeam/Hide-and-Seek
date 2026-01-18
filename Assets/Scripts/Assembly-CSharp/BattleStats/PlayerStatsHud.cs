using System;
using BattleStats.Hierarchy;
using CraftyEngine.Utils.Unity;
using DG.Tweening;
using HudSystem;
using PlayerModule;
using PlayerModule.MyPlayer;
using UnityEngine;

namespace BattleStats
{
	public class PlayerStatsHud : HeadUpDisplay
	{
		private PlayerInfoWidgetHierarchy healthHierarchy_;

		private UIBattleStatsCounterWidgetHierarchy counter_;

		private MyPlayerStatsModel myPlayerStatsModel_;

		private PlayerStatsModel playerModel_;

		private Sequence damageSequence_;

		private Vector3 damageVector = new Vector3(1.5f, 1.5f, 1.5f);

		public event Action CounterClicked;

		public PlayerStatsHud()
		{
			prefabsManager.Load("BattleStatsPrefabsHolder");
			healthHierarchy_ = prefabsManager.InstantiateNGUIIn<PlayerInfoWidgetHierarchy>("UIPlayerInfoWidget", nguiManager.UiRoot.PlayerInfoContainer.gameObject);
			hudStateSwitcher.Register(8388608, healthHierarchy_);
			counter_ = prefabsManager.InstantiateNGUIIn<UIBattleStatsCounterWidgetHierarchy>("UIBattleStatsCounterWidget", nguiManager.UiRoot.TopRightContainer.gameObject);
			hudStateSwitcher.Register(8, counter_.button, counter_.killCountWidget, counter_.expCountWidget);
			GameObjectUtils.SwitchActive(healthHierarchy_.healthLabel.gameObject, false);
			damageSequence_ = SetBlinkSequence(healthHierarchy_.damageLabel, damageVector);
			ButtonSet.Up(counter_.button, this.CounterClicked.SafeInvoke, ButtonSetGroup.Hud);
			ButtonSet.Up(counter_.widget, ButtonSetGroup.Hud);
		}

		public override void Resubscribe()
		{
			if (playerModel_ != null)
			{
				Dispose();
			}
			if (SingletonManager.TryGet<MyPlayerStatsModel>(out myPlayerStatsModel_))
			{
				playerModel_ = myPlayerStatsModel_.stats;
				playerModel_.HealthChanged += ShowHealthChange;
				playerModel_.combat.KillsCountChanged += UpdateKillCounter;
				playerModel_.BattleExperianceChanged += UpdateExpCounter;
			}
		}

		public override void Dispose()
		{
			playerModel_.HealthChanged -= ShowHealthChange;
			playerModel_.combat.KillsCountChanged -= UpdateKillCounter;
			playerModel_.BattleExperianceChanged -= UpdateExpCounter;
		}

		private void ShowHealthChange(int prev, int current, string persId)
		{
			if (!(healthHierarchy_ != null))
			{
				return;
			}
			healthHierarchy_.healthLabel.text = current.ToString();
			float value = (float)current / (float)playerModel_.HealthMax;
			healthHierarchy_.healthSlider.value = value;
			if (healthHierarchy_.gameObject.activeInHierarchy)
			{
				int num = current - prev;
				if (num < 0)
				{
					healthHierarchy_.damageLabel.text = string.Format("{0}", num);
					damageSequence_.Rewind();
					damageSequence_.Play();
				}
			}
		}

		private Sequence SetBlinkSequence(UILabel label, Vector3 sizeVector, float minAlpha = 0f)
		{
			Sequence sequence = DOTween.Sequence();
			sequence.SetAutoKill(false);
			label.alpha = minAlpha;
			label.transform.localScale = Vector3.one;
			sequence.Insert(0f, DOTween.To(() => label.alpha, delegate(float s)
			{
				label.alpha = s;
			}, 1f, 0.6f).SetEase(Ease.OutBack));
			sequence.Insert(0.6f, DOTween.To(() => label.alpha, delegate(float s)
			{
				label.alpha = s;
			}, minAlpha, 0.6f).SetEase(Ease.OutCubic));
			sequence.Insert(0f, DOTween.To(() => label.transform.localScale, delegate(Vector3 s)
			{
				label.transform.localScale = s;
			}, sizeVector, 0.6f).SetEase(Ease.InOutQuad));
			sequence.Insert(0.6f, DOTween.To(() => label.transform.localScale, delegate(Vector3 s)
			{
				label.transform.localScale = s;
			}, Vector3.one, 0.6f).SetEase(Ease.InOutQuad));
			return sequence;
		}

		private void UpdateKillCounter()
		{
			UpdateKillCounter(playerModel_.combat.KillFragsCount);
		}

		private void UpdateKillCounter(int count)
		{
			if (counter_ != null)
			{
				counter_.killCountLabel.text = string.Format("{0}", playerModel_.combat.KillFragsCount);
			}
		}

		private void UpdateExpCounter()
		{
			if (counter_ != null)
			{
				counter_.expCountLabel.text = string.Format("{0}", playerModel_.BattleExperiance);
			}
		}
	}
}
