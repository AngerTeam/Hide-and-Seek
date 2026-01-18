using System;
using DG.Tweening;
using UnityEngine;

namespace PlayerModule.MyPlayer
{
	public class MyPlayerHandShaker : IDisposable
	{
		private float ratioByMovementSpeed_;

		private float animValue_;

		private GameObject container_;

		private Sequence shakingSequence_;

		private float smoothness_;

		public MyPlayerHandShaker(GameObject container)
		{
			smoothness_ = 0.7f;
			container_ = container;
			container_.layer = 9;
			MakeSequence();
		}

		public void Dispose()
		{
			shakingSequence_.Kill();
		}

		public void Update(bool enabled, float distance)
		{
			ratioByMovementSpeed_ = ((!enabled) ? Mathf.Lerp(ratioByMovementSpeed_, 0f, 1f - smoothness_) : Mathf.Lerp(ratioByMovementSpeed_, distance * 0.15f, 1f - smoothness_));
		}

		private void MakeSequence()
		{
			shakingSequence_ = DOTween.Sequence();
			animValue_ = -1f;
			shakingSequence_.Insert(0f, DOTween.To(() => animValue_, delegate(float p)
			{
				animValue_ = p;
				container_.transform.localPosition = new Vector3(animValue_ * ratioByMovementSpeed_ * 2.6f, Mathf.Pow(animValue_, 2f) * ratioByMovementSpeed_ * 0.8f, 0f);
			}, 1f, 0.3f).SetEase(Ease.InOutQuad)).SetLoops(-1, LoopType.Yoyo);
		}
	}
}
