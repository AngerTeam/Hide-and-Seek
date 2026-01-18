using System;
using CraftyEngine.Content;
using CraftyEngine.Infrastructure;
using Extensions;

namespace MyPlayerInput
{
	public class MyPlayerInputModel : Singleton
	{
		public bool clipping;

		public bool flight;

		private bool jumping_;

		public bool movingUp;

		private bool enabledByUi_;

		private bool enabledByGameState_;

		private bool enabledByCameraMode_;

		private bool enabledByPlayerState_;

		public float speedBoost;

		public float speedRatio;

		public float speed;

		public float airMoveRatio;

		public float autoJumpDelay;

		public float autoJumpResetDelay;

		public float criticalHeight;

		public float eyesHeight;

		public float gravity;

		public float height;

		public float jumpHeight;

		public float maxFallSpeed;

		public float moveSpeed;

		public float flightSpeed;

		public float radius;

		public float respawnHeight;

		public float soundFallMinimumHeight;

		public float soundStepDistance;

		public bool jumping
		{
			get
			{
				return jumping_;
			}
			set
			{
				if (jumping_ != value)
				{
					jumping_ = value;
					if (jumping)
					{
						this.Jumped.SafeInvoke();
					}
				}
			}
		}

		public bool EnabledByUi
		{
			get
			{
				return enabledByUi_;
			}
			set
			{
				enabledByUi_ = value;
				Refresh();
			}
		}

		public bool EnabledByGameState
		{
			get
			{
				return enabledByGameState_;
			}
			set
			{
				enabledByGameState_ = value;
				Refresh();
			}
		}

		public bool EnabledByCameraMode
		{
			get
			{
				return enabledByCameraMode_;
			}
			set
			{
				enabledByCameraMode_ = value;
				Refresh();
			}
		}

		public bool EnabledByPlayerState
		{
			get
			{
				return enabledByPlayerState_;
			}
			set
			{
				enabledByPlayerState_ = value;
				Refresh();
			}
		}

		public bool jumpEnabled { get; private set; }

		public bool moveEnabled { get; private set; }

		public bool rotateEnabled { get; private set; }

		public event Action Jumped;

		public MyPlayerInputModel()
		{
			clipping = true;
			Reset();
		}

		private void Refresh()
		{
			bool flag2 = (jumpEnabled = EnabledByUi && EnabledByGameState && EnabledByPlayerState && EnabledByCameraMode);
			moveEnabled = flag2;
			rotateEnabled = EnabledByUi && EnabledByGameState && EnabledByPlayerState;
		}

		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<MyPlayerInputContentMap>();
			InputModel inputModel = SingletonManager.Get<InputModel>();
			inputModel.clickDurationTreshold = MyPlayerInputContentMap.PlayerSettings.clickTimeTreshold;
			inputModel.clickDistanceTreshold = MyPlayerInputContentMap.PlayerSettings.clickDistanceTreshold;
			gravity = MyPlayerInputContentMap.PlayerSettings.fallSpeed;
			maxFallSpeed = MyPlayerInputContentMap.PlayerSettings.fallSpeedMax;
			height = MyPlayerInputContentMap.PlayerSettings.bodyHeight;
			radius = MyPlayerInputContentMap.PlayerSettings.bodyRadius;
			moveSpeed = MyPlayerInputContentMap.PlayerSettings.moveSpeed;
			flightSpeed = MyPlayerInputContentMap.PlayerSettings.flightSpeed;
			eyesHeight = MyPlayerInputContentMap.PlayerSettings.cameraHeight;
			jumpHeight = MyPlayerInputContentMap.PlayerSettings.jumpHeight;
			airMoveRatio = MyPlayerInputContentMap.PlayerSettings.inAirMoveRatio;
			respawnHeight = 0f;
			autoJumpDelay = MyPlayerInputContentMap.PlayerSettings.autoJumpDelay;
			autoJumpResetDelay = MyPlayerInputContentMap.PlayerSettings.autoJumpResetDelay;
			criticalHeight = MyPlayerInputContentMap.PlayerSettings.criticalFallHeight;
			soundFallMinimumHeight = MyPlayerInputContentMap.PlayerSettings.landingSoundMinimalHeight;
			soundStepDistance = MyPlayerInputContentMap.PlayerSettings.stepDistance;
		}

		public void Reset()
		{
			enabledByGameState_ = true;
			enabledByPlayerState_ = true;
			enabledByUi_ = true;
			enabledByCameraMode_ = true;
			Refresh();
		}
	}
}
