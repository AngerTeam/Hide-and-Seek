using System;
using CraftyEngine.Infrastructure;
using DG.Tweening;
using DG.Tweening.Core;
using UnityEngine;

namespace HomeLobby
{
	public class LobbyCameraShaker : IDisposable
	{
		public Vector3 amplitudeMax;

		public float durationMax;

		private Transform cameraTransform_;

		private Vector3 center_;

		private bool desposed_;

		private Vector3 lookAt_;

		private Vector3 position_;

		private Tweener[] tweeners_;

		public void Dispose()
		{
			desposed_ = true;
			for (int i = 0; i < tweeners_.Length; i++)
			{
				if (tweeners_[i] != null)
				{
					tweeners_[i].Kill();
				}
			}
		}

		public void PlaceCameraCenter(Vector3 playerPosition, Vector3 amplitude, float duration = 10f)
		{
			amplitudeMax = amplitude;
			durationMax = duration;
			PrefabsManager prefabsManager = SingletonManager.Get<PrefabsManager>();
			prefabsManager.Load("HNSLobbyModulePrefabsHolder");
			Camera prefab = prefabsManager.GetPrefab<Camera>("LobbyCameraPosition");
			CameraManager cameraManager = SingletonManager.Get<CameraManager>();
			cameraTransform_ = cameraManager.Transform;
			cameraTransform_.parent = null;
			cameraTransform_.position = prefab.transform.position;
			cameraTransform_.rotation = prefab.transform.rotation;
			cameraManager.PlayerCamera.fieldOfView = prefab.fieldOfView;
			center_ = prefab.transform.position;
			position_ = center_;
			lookAt_ = playerPosition + Vector3.up * 3f;
			tweeners_ = new Tweener[3];
			StartTweenX();
			StartTweenY();
			StartTweenZ();
			UnityEvent unityEvent = SingletonManager.Get<UnityEvent>(2);
			unityEvent.Subscribe(UnityEventType.Update, Update);
		}

		public void Update()
		{
			cameraTransform_.position = position_;
			cameraTransform_.LookAt(lookAt_);
		}

		private void StartTween(int axis)
		{
			if (desposed_)
			{
				return;
			}
			if (tweeners_[axis] != null)
			{
				tweeners_[axis].Kill();
			}
			float num;
			float num2;
			TweenCallback action;
			DOGetter<float> getter;
			DOSetter<float> setter;
			float num3;
			switch (axis)
			{
			default:
				return;
			case 0:
				num = position_.x;
				num2 = center_.x;
				action = StartTweenX;
				getter = () => position_.x;
				setter = delegate(float v)
				{
					position_.x = v;
				};
				num3 = amplitudeMax.x;
				break;
			case 1:
				num = position_.y;
				num2 = center_.y;
				action = StartTweenY;
				getter = () => position_.y;
				setter = delegate(float v)
				{
					position_.y = v;
				};
				num3 = amplitudeMax.y;
				break;
			case 2:
				num = position_.z;
				num2 = center_.z;
				action = StartTweenZ;
				getter = () => position_.z;
				setter = delegate(float v)
				{
					position_.z = v;
				};
				num3 = amplitudeMax.z;
				break;
			}
			float num4 = num2 + (UnityEngine.Random.value - 0.5f) * num3;
			float num5 = num - num4;
			float num6 = Math.Abs(num5 * durationMax);
			if (num6 < durationMax * 0.1f)
			{
				StartTween(axis);
				return;
			}
			Tweener tweener = DOTween.To(getter, setter, num4, num6);
			tweener.SetEase(Ease.InOutQuad);
			tweener.OnComplete(action);
			tweeners_[axis] = tweener;
		}

		private void StartTweenX()
		{
			StartTween(0);
		}

		private void StartTweenY()
		{
			StartTween(1);
		}

		private void StartTweenZ()
		{
			StartTween(2);
		}
	}
}
