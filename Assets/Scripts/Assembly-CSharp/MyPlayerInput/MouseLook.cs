using System;
using CraftyEngine.Infrastructure;
using UnityEngine;

namespace MyPlayerInput
{
	public class MouseLook
	{
		private const float REACT_TIME = 0.25f;

		public bool clampVerticalRotation = true;

		public float maximumX = 89.9f;

		public float minimumX = -89.9f;

		private float maxSmoothOffset = 20f;

		private float mouseSmoothFactor = 0.64f;

		public float sensitivityX = ((!CompileConstants.MOBILE) ? 2f : 40f);

		public float sensitivityY = ((!CompileConstants.MOBILE) ? 2f : 40f);

		public float smoothTime = 5f;

		public float sensitivityMultiplier = 1f;

		public bool isSmoothLookEnabled;

		private float lastSmoothTime_;

		private float minSmoothOffset_ = 0.1f;

		private Vector2 prevRotate_ = Vector3.zero;

		private Transform camera_;

		private Transform character_;

		private Quaternion cameraTargetRot_;

		private Quaternion characterTargetRot_;

		private InputManager inputManager_;

		public MouseLook(Transform character, Transform camera, int layer)
		{
			Init(character, camera);
			SingletonManager.TryGet<InputManager>(out inputManager_, layer);
		}

		public void Init(Transform character, Transform camera)
		{
			character_ = character;
			camera_ = camera;
			characterTargetRot_ = character.localRotation;
			cameraTargetRot_ = camera.localRotation;
		}

		public void Reset(Vector3 rotation)
		{
			cameraTargetRot_ = Quaternion.Euler(new Vector3(rotation.x, 0f, 0f));
			characterTargetRot_ = Quaternion.Euler(new Vector3(0f, rotation.y, 0f));
			character_.localRotation = characterTargetRot_;
			camera_.localRotation = cameraTargetRot_;
		}

		private Quaternion ClampRotationAroundXAxis(Quaternion q)
		{
			q.x /= q.w;
			q.y /= q.w;
			q.z /= q.w;
			q.w = 1f;
			float value = 114.59156f * Mathf.Atan(q.x);
			value = Mathf.Clamp(value, minimumX, maximumX);
			q.x = Mathf.Tan((float)Math.PI / 360f * value);
			return q;
		}

		public void Update()
		{
			Vector2 rotate = inputManager_.GetRotate();
			rotate = new Vector2(rotate.y * sensitivityX * sensitivityMultiplier, rotate.x * sensitivityY * sensitivityMultiplier);
			Vector2 smoothMouseRotation = GetSmoothMouseRotation(rotate);
			characterTargetRot_ *= Quaternion.Euler(0f, smoothMouseRotation.y, 0f);
			cameraTargetRot_ *= Quaternion.Euler(0f - smoothMouseRotation.x, 0f, 0f);
			if (clampVerticalRotation)
			{
				cameraTargetRot_ = ClampRotationAroundXAxis(cameraTargetRot_);
			}
			character_.localRotation = characterTargetRot_;
			camera_.localRotation = cameraTargetRot_;
			prevRotate_ = smoothMouseRotation;
		}

		public Vector2 GetSmoothMouseRotation(Vector2 currentRotation)
		{
			if (!isSmoothLookEnabled || Time.time - lastSmoothTime_ <= 0.25f)
			{
				return currentRotation;
			}
			Vector2 vector = currentRotation;
			float num = Vector3.SqrMagnitude(currentRotation - prevRotate_);
			if (num < maxSmoothOffset && num > minSmoothOffset_)
			{
				vector = Vector3.Lerp(prevRotate_, vector, mouseSmoothFactor);
			}
			else if (num >= maxSmoothOffset)
			{
				lastSmoothTime_ = Time.time;
			}
			return vector;
		}
	}
}
