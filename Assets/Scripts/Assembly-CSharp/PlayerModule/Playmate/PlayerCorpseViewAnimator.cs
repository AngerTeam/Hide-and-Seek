using DG.Tweening;
using UnityEngine;

namespace PlayerModule.Playmate
{
	public class PlayerCorpseViewAnimator
	{
		public Transform target;

		public Vector3 result;

		private Vector3 lerp_;

		public void Play()
		{
			lerp_ = target.eulerAngles;
			DOTween.To(() => lerp_.x, delegate(float x)
			{
				lerp_.x = x;
			}, result.x, 1f).SetEase(Ease.OutBounce);
			DOTween.To(() => lerp_.y, delegate(float y)
			{
				lerp_.y = y;
			}, result.y, 1f).SetEase(Ease.OutQuart).OnUpdate(Update);
		}

		private void Update()
		{
			target.eulerAngles = lerp_;
		}
	}
}
