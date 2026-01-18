using BattleStats.Hierarchy;
using DG.Tweening;
using PlayerModule;
using UnityEngine;

namespace BattleStats
{
	public class BattleStatsItemController
	{
		private const float MOVE_DURATION = 1f;

		public BattleStatsRawHierarchy view;

		public PlayerStatsModel model;

		public bool virgin;

		private Tweener placeTween_;

		private Tweener directionTween_;

		private Tweener backgroundTween_;

		private Vector3 targetPosition_;

		private Color targetColor_;

		internal void Init(BattleStatsRawHierarchy view, PlayerStatsModel model)
		{
			this.view = view;
			this.model = model;
			virgin = true;
			view.container.alpha = 0f;
		}

		internal void MoveTo(Vector3 position, Color backgroundColor)
		{
			if (virgin)
			{
				virgin = false;
				view.gameObject.transform.localPosition = position;
				targetPosition_ = position;
				DOTween.To(() => view.container.alpha, delegate(float a)
				{
					view.container.alpha = a;
				}, 1f, 1f);
				targetColor_ = backgroundColor;
				view.background.color = backgroundColor;
			}
			else if (targetPosition_ != position)
			{
				bool up = position.y > targetPosition_.y;
				if (model.BattleExperiance > 0)
				{
					AnimateArrow(up);
				}
				targetPosition_ = position;
				AnimatePosition();
				AnimateColor(backgroundColor);
			}
		}

		private void AnimateColor(Color backgroundColor)
		{
			if (targetColor_ != backgroundColor)
			{
				targetColor_ = backgroundColor;
				if (backgroundTween_ != null)
				{
					backgroundTween_.Kill();
				}
				backgroundTween_ = DOTween.To(() => view.background.color, delegate(Color a)
				{
					view.background.color = a;
				}, targetColor_, 1f).SetEase(Ease.Linear);
			}
		}

		private void AnimatePosition()
		{
			if (placeTween_ != null)
			{
				placeTween_.Kill();
			}
			placeTween_ = DOTween.To(() => view.gameObject.transform.localPosition, delegate(Vector3 p)
			{
				view.gameObject.transform.localPosition = p;
			}, targetPosition_, 1f).SetEase(Ease.InOutExpo);
		}

		private void AnimateArrow(bool up)
		{
			if (directionTween_ != null)
			{
				directionTween_.Kill();
			}
			UISprite uISprite;
			UISprite show;
			if (up)
			{
				uISprite = view.arrowDownSprite;
				show = view.arrowUpSprite;
			}
			else
			{
				show = view.arrowDownSprite;
				uISprite = view.arrowUpSprite;
			}
			uISprite.alpha = 0f;
			show.alpha = 1f;
			directionTween_ = DOTween.To(() => show.alpha, delegate(float a)
			{
				show.alpha = a;
			}, 0f, 10f).SetEase(Ease.InExpo);
		}

		public override string ToString()
		{
			return (model != null) ? model.ToString() : "null";
		}
	}
}
