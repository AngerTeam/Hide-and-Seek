using System;
using Extensions;
using UnityEngine;

namespace PlayerCameraModule
{
	public class PlayerCameraInputModel
	{
		private bool enabledByPlayer_;

		private bool enabledByState_;

		public float inputSensitivityMultiplier = 1f;

		public float sensitivityMultiplier = 1f;

		public float verticalMinAngle = -89.9f;

		public float verticalMaxAngle = 89.9f;

		public float sensitivity = ((!CompileConstants.MOBILE) ? 2f : 40f);

		public bool inverseRotation;

		public float smoothRotation = 5f;

		public float autoAimMaxAngle = 15f;

		public float autoAimAngleSpeed = 30f;

		public float maxSmoothAngleDiff = 15f;

		public Vector3? autoAimTarget;

		public bool autoAimEnabled;

		public bool inputRotationControl;

		public float recoilOffset;

		public bool recoilResetOnInput;

		public bool Enabled
		{
			get
			{
				return enabledByPlayer_ && enabledByState_;
			}
		}

		public bool EnabledByPlayer
		{
			get
			{
				return enabledByPlayer_;
			}
			set
			{
				if (enabledByPlayer_ != value)
				{
					bool enabled = Enabled;
					enabledByPlayer_ = value;
					if (enabled != Enabled)
					{
						this.EnableChanged.SafeInvoke(Enabled);
					}
				}
			}
		}

		public bool EnabledByState
		{
			get
			{
				return enabledByState_;
			}
			set
			{
				if (enabledByState_ != value)
				{
					bool enabled = Enabled;
					enabledByState_ = value;
					if (enabled != Enabled)
					{
						this.EnableChanged.SafeInvoke(Enabled);
					}
				}
			}
		}

		public event Action<bool> EnableChanged;
	}
}
