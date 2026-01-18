using BattleStats.Hierarchy;
using DG.Tweening;
using UnityEngine;

namespace BattleStats
{
	public class BattleStatsTableAnimator
	{
		private BattleStatsTableWindowHierarchy hierarchy_;

		private bool isSandBox_;

		private Vector3 resultWidgetPos_ = new Vector3(0f, 487f, 0f);

		private Vector3 resultWidgetSize_ = new Vector3(3f, 3f, 3f);

		private Sequence rewardSequence_;

		public BattleStatsTableAnimator(BattleStatsTableWindowHierarchy hierarchy, bool isSandBox)
		{
			hierarchy_ = hierarchy;
			isSandBox_ = isSandBox;
		}

		public void PlayResultAnimation()
		{
			hierarchy_.mainWidget.alpha = 0f;
			hierarchy_.resultWidget.alpha = 0f;
			hierarchy_.rewardWidget.alpha = 0f;
			hierarchy_.blackBackground.alpha = 0f;
			hierarchy_.resultWidget.transform.localPosition = Vector3.zero;
			hierarchy_.resultWidget.transform.localScale = Vector3.zero;
			hierarchy_.rewardWidget.transform.localScale = Vector3.zero;
			if (rewardSequence_ != null)
			{
				rewardSequence_.Kill();
				rewardSequence_ = null;
			}
			rewardSequence_ = DOTween.Sequence();
			rewardSequence_.SetAutoKill(false);
			AddAlphaSequence(hierarchy_.resultWidget, 0f, 0.5f, 1f);
			AddAlphaSequence(hierarchy_.blackBackground, 0f, 0.5f, 0.8f);
			rewardSequence_.Insert(0f, DOTween.To(() => hierarchy_.resultWidget.transform.localScale, delegate(Vector3 s)
			{
				hierarchy_.resultWidget.transform.localScale = s;
			}, resultWidgetSize_, 0.5f).SetEase(Ease.OutBack));
			if (!isSandBox_)
			{
				rewardSequence_.Insert(1f, DOTween.To(() => hierarchy_.resultWidget.transform.localPosition, delegate(Vector3 s)
				{
					hierarchy_.resultWidget.transform.localPosition = s;
				}, resultWidgetPos_, 0.5f).SetEase(Ease.InOutQuad));
				rewardSequence_.Insert(1f, DOTween.To(() => hierarchy_.resultWidget.transform.localScale, delegate(Vector3 s)
				{
					hierarchy_.resultWidget.transform.localScale = s;
				}, Vector3.one, 0.5f).SetEase(Ease.InOutQuad));
			}
			AddAlphaSequence(hierarchy_.mainWidget, 1.5f, 0.5f, 1f);
			AddAlphaSequence(hierarchy_.rewardWidget, 2f, 0.5f, 1f);
			rewardSequence_.Insert(2f, DOTween.To(() => hierarchy_.rewardWidget.transform.localScale, delegate(Vector3 s)
			{
				hierarchy_.rewardWidget.transform.localScale = s;
			}, Vector3.one, 1f).SetEase(Ease.OutElastic));
			rewardSequence_.Play();
		}

		private void AddAlphaSequence(UIWidget widget, float startTime, float length, float maxAlpha = 1f)
		{
			rewardSequence_.Insert(startTime, DOTween.To(() => widget.alpha, delegate(float s)
			{
				widget.alpha = s;
			}, maxAlpha, length).SetEase(Ease.InOutQuad));
		}
	}
}
