using System;
using CraftyEngine.Infrastructure;
using UnityEngine;

namespace PlayerCameraModule
{
	public class CameraInputController : IDisposable
	{
		private const float epsilon = 1E-05f;

		private readonly PlayerCamera camera_;

		private readonly InputManager inputManager_;

		private readonly PlayerCameraInputModel cameraInputModel_;

		private Vector2 localAngles_;

		private Vector2 localAnglesSmooth_;

		private Vector2 localAnglesVelocity_;

		private InputInstance rotateInputInstance_;

		private bool anyInput_;

		private bool lastAnyInput_;

		private bool lastAutoaiming_;

		private Vector3 fixedAutoaimingTarget_;

		private Vector3 autoaimingSmoothVelocity_;

		private float appliedRecoil;

		public CameraInputController(PlayerCamera camera, PlayerCameraInputModel cameraInputModel)
		{
			camera_ = camera;
			cameraInputModel_ = cameraInputModel;
			cameraInputModel_.EnableChanged += HandleCameraInputEnableChanged;
			SingletonManager.Get<InputManager>(out inputManager_);
			inputManager_.PointerDown += HandlePointerDown;
			SnapLocalAngles();
		}

		public void Dispose()
		{
			inputManager_.PointerDown -= HandlePointerDown;
		}

		public void Update()
		{
			if (!cameraInputModel_.Enabled)
			{
				return;
			}
			cameraInputModel_.inputRotationControl = false;
			anyInput_ = UpdateInput();
			appliedRecoil = 0f;
			if (cameraInputModel_.recoilOffset > 1E-05f)
			{
				float y = localAngles_.y;
				localAngles_.y = ClampAngle(localAngles_.y - cameraInputModel_.recoilOffset, cameraInputModel_.verticalMinAngle, cameraInputModel_.verticalMaxAngle);
				appliedRecoil = localAngles_.y - y;
				if (cameraInputModel_.recoilResetOnInput && anyInput_)
				{
					cameraInputModel_.recoilOffset = 0f;
					appliedRecoil = 0f;
				}
			}
			float num = Quaternion.Angle(Quaternion.Euler(localAnglesSmooth_.y, localAnglesSmooth_.x, 0f), Quaternion.Euler(localAngles_.y, localAngles_.x, 0f));
			if (anyInput_ || num > 0.1f || cameraInputModel_.recoilOffset > 1E-05f)
			{
				localAngles_.y = ClampAngle(localAngles_.y, cameraInputModel_.verticalMinAngle, cameraInputModel_.verticalMaxAngle);
				float num2 = 0.005f;
				float maxSmoothAngleDiff = cameraInputModel_.maxSmoothAngleDiff;
				float num3 = Mathf.Lerp(0f, cameraInputModel_.smoothRotation, (!(num >= maxSmoothAngleDiff)) ? (1f - num / maxSmoothAngleDiff) : 0f);
				float num4 = Mathf.Lerp(0f, cameraInputModel_.smoothRotation, (!(num >= maxSmoothAngleDiff)) ? (1f - num / maxSmoothAngleDiff) : 0f);
				localAnglesSmooth_.x = Mathf.SmoothDamp(localAnglesSmooth_.x, localAngles_.x, ref localAnglesVelocity_.x, num3 * num2);
				localAnglesSmooth_.y = Mathf.SmoothDamp(localAnglesSmooth_.y, localAngles_.y, ref localAnglesVelocity_.y, num4 * num2);
				Quaternion rotationAroundTarget = Quaternion.Euler(localAnglesSmooth_.y, localAnglesSmooth_.x, 0f);
				camera_.SetRotationAroundTarget(rotationAroundTarget);
				cameraInputModel_.inputRotationControl = true;
			}
			else
			{
				SnapLocalAngles();
			}
		}

		public void LateUpdate()
		{
			if (cameraInputModel_.Enabled)
			{
				if (!lastAnyInput_ && cameraInputModel_.autoAimEnabled && cameraInputModel_.autoAimTarget.HasValue)
				{
					Autoaiming(cameraInputModel_.autoAimTarget.Value);
					lastAutoaiming_ = true;
				}
				else
				{
					lastAutoaiming_ = false;
				}
				localAngles_.y -= appliedRecoil;
			}
		}

		public void Reset()
		{
			SnapLocalAngles();
		}

		private bool UpdateInput()
		{
			bool flag = false;
			if (rotateInputInstance_ != null)
			{
				if (!rotateInputInstance_.Pressed)
				{
					rotateInputInstance_ = null;
				}
			}
			else if (inputManager_.Model.CurrentInstance != null && inputManager_.Model.CurrentInstance.type == MobileInputType.Rotate)
			{
				rotateInputInstance_ = inputManager_.Model.CurrentInstance;
			}
			if (rotateInputInstance_ == null)
			{
				lastAnyInput_ = false;
			}
			Vector2 rotate = inputManager_.GetRotate();
			float num = cameraInputModel_.sensitivity * cameraInputModel_.sensitivityMultiplier;
			if (Mathf.Abs(rotate.x) > 0f)
			{
				RotateLeftRight(rotate.x * num);
				flag = true;
			}
			if (Mathf.Abs(rotate.y) > 0f)
			{
				RotateUpDown(rotate.y * num);
				flag = true;
			}
			if (flag)
			{
				lastAnyInput_ = true;
			}
			return flag;
		}

		private void RotateLeftRight(float delta)
		{
			int num = ((!cameraInputModel_.inverseRotation) ? 1 : (-1));
			localAngles_.x += delta * (float)num;
		}

		private void RotateUpDown(float delta)
		{
			int num = ((!cameraInputModel_.inverseRotation) ? 1 : (-1));
			localAngles_.y -= delta * (float)num;
		}

		protected void Autoaiming(Vector3 aimTarget)
		{
			Vector3 vector = aimTarget - camera_.TargetWithOffset;
			if (!lastAutoaiming_)
			{
				fixedAutoaimingTarget_ = camera_.Transform.position + camera_.Transform.forward * (vector.magnitude + camera_.Distance);
			}
			else if (cameraInputModel_.autoAimAngleSpeed > 0f)
			{
				fixedAutoaimingTarget_ = Vector3.SmoothDamp(fixedAutoaimingTarget_, aimTarget, ref autoaimingSmoothVelocity_, 5f / cameraInputModel_.autoAimAngleSpeed);
			}
			else
			{
				fixedAutoaimingTarget_ = aimTarget;
			}
			vector = fixedAutoaimingTarget_ - camera_.TargetWithOffset;
			Quaternion rotationAroundTarget = Quaternion.LookRotation(vector);
			camera_.SetRotationAroundTarget(rotationAroundTarget);
			SnapLocalAngles();
			cameraInputModel_.inputRotationControl = true;
		}

		private void SnapLocalAngles()
		{
			Vector3 eulerAngles = camera_.Transform.eulerAngles;
			localAngles_ = (localAnglesSmooth_ = new Vector2(eulerAngles.y, eulerAngles.x));
		}

		private void HandleCameraInputEnableChanged(bool enabled)
		{
			if (enabled)
			{
				SnapLocalAngles();
			}
			else
			{
				cameraInputModel_.inputRotationControl = false;
			}
		}

		private void HandlePointerDown(object sender, InputEventArgs args)
		{
			if (args.touch.type == MobileInputType.Rotate)
			{
				rotateInputInstance_ = args.touch;
			}
		}

		private static float ClampAngle(float angle, float min, float max)
		{
			float num = angle;
			if (num > 180f)
			{
				num -= 360f;
			}
			num = Mathf.Clamp(num, min, max);
			if (angle > 180f)
			{
				num += 360f;
			}
			return num;
		}
	}
}
