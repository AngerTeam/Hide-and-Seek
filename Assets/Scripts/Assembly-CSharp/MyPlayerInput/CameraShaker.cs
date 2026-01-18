using System;
using CraftyEngine.Infrastructure;
using DG.Tweening;
using UnityEngine;

namespace MyPlayerInput
{
	public class CameraShaker : IDisposable
	{
		public bool enabled;

		private Transform cameraTransform_;

		private float smoothness_ = 0.7f;

		private float cameraShaking_;

		private float cameraShakingPower_;

		private Sequence playerHeadSequence;

		private float cameraHeight_;

		public CameraShaker(float cameraHeight)
		{
			cameraHeight_ = cameraHeight;
			playerHeadSequence = DOTween.Sequence();
			cameraShaking_ = -1f;
			playerHeadSequence.Insert(0f, DOTween.To(() => cameraShaking_, HeadUpdate, 10f, 0.15f).SetEase(Ease.InOutQuad)).SetLoops(-1, LoopType.Yoyo);
			CameraManager cameraManager = SingletonManager.Get<CameraManager>();
			cameraTransform_ = cameraManager.Transform;
		}

		public void Update(float distance)
		{
			if (!enabled)
			{
				distance = 0f;
			}
			cameraShakingPower_ = Mathf.Lerp(cameraShakingPower_, distance * 0.2f, 1f - smoothness_);
		}

		private void HeadUpdate(float value)
		{
			cameraShaking_ = value;
		}

		internal void Reset()
		{
			HeadUpdate(0f);
		}

		internal void Apply()
		{
			if (enabled && cameraTransform_ != null)
			{
				cameraTransform_.localPosition = new Vector3(0f, cameraHeight_ + cameraShaking_ * cameraShakingPower_, 0f);
			}
		}

		public void Dispose()
		{
			playerHeadSequence.Kill();
		}
	}
}
