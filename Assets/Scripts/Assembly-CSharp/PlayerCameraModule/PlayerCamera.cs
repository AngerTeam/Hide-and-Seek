using UnityEngine;

namespace PlayerCameraModule
{
	public class PlayerCamera
	{
		private readonly Camera unityCamera_;

		private Vector3 target_;

		private Vector3 targetOffset_;

		private Vector3 targetWithOffset_;

		private float fov_;

		private float fovMultiplier_;

		public bool Enabled
		{
			get
			{
				return unityCamera_.enabled;
			}
			set
			{
				unityCamera_.enabled = value;
			}
		}

		public Transform Transform { get; private set; }

		public Camera UnityCamera
		{
			get
			{
				return unityCamera_;
			}
		}

		public Vector3 Target
		{
			get
			{
				return target_;
			}
		}

		public Vector3 TargetOffset
		{
			get
			{
				return targetOffset_;
			}
		}

		public Vector3 TargetWithOffset
		{
			get
			{
				return targetWithOffset_;
			}
		}

		public Vector3 Position
		{
			get
			{
				return Transform.position;
			}
			set
			{
				Transform.position = value;
				Transform.LookAt(targetWithOffset_);
			}
		}

		public float Fov
		{
			get
			{
				return fov_;
			}
			set
			{
				fov_ = value;
				UpdateFov();
			}
		}

		public float FovMultiplier
		{
			get
			{
				return fovMultiplier_;
			}
			set
			{
				fovMultiplier_ = value;
				UpdateFov();
			}
		}

		public float Distance
		{
			get
			{
				return (Transform.position - targetWithOffset_).magnitude;
			}
			set
			{
				Transform.position = targetWithOffset_ - Transform.forward * value;
			}
		}

		public PlayerCamera(Camera unityCamera)
		{
			unityCamera_ = unityCamera;
			Transform = unityCamera.transform;
			fov_ = unityCamera.fieldOfView;
			fovMultiplier_ = 1f;
		}

		public void SetTarget(Vector3 target, bool keepDistance = true)
		{
			float distance = Distance;
			target_ = target;
			targetWithOffset_ = CameraUtils.CalcTargetWithOffset(Transform, target_, targetOffset_);
			if (keepDistance)
			{
				Distance = distance;
			}
			else
			{
				Transform.LookAt(targetWithOffset_);
			}
		}

		public void SetTargetOffset(Vector3 targetOffset, bool keepDistance = true)
		{
			float distance = Distance;
			targetOffset_ = targetOffset;
			targetWithOffset_ = CameraUtils.CalcTargetWithOffset(Transform, target_, targetOffset_);
			if (keepDistance)
			{
				Distance = distance;
			}
			else
			{
				Transform.LookAt(targetWithOffset_);
			}
		}

		public void SetRotationAroundTarget(Quaternion rotation)
		{
			Transform.rotation = rotation;
			Transform.position = rotation * new Vector3(0f, 0f, 0f - Distance) + targetWithOffset_;
		}

		private void UpdateFov()
		{
			unityCamera_.fieldOfView = fov_ * fovMultiplier_;
		}
	}
}
