using CraftyEngine.Content;

namespace MyPlayerInput
{
	public class PlayerSettingsEntries : ContentItem
	{
		public float autoJumpDelay = 0.2f;

		public float autoJumpResetDelay = 2.5f;

		public float bodyHeight = 1.8f;

		public float bodyRadius = 0.4f;

		public float cameraHeight = 1.65f;

		public int clickDistanceTreshold = 25;

		public float clickTimeTreshold = 0.25f;

		public int criticalFallHeight = 8;

		public float fallSpeed = 50f;

		public float fallSpeedMax = 70f;

		public float inAirMoveRatio = 1f;

		public float jumpHeight = 1.05f;

		public float moveSpeed = 5.5f;

		public float landingSoundMinimalHeight = 0.6f;

		public float stepDistance = 1.8f;

		public float flightSpeed = 4f;

		public int touchSensitivity = 70;

		public float tpsCameraDistance = 3.5f;

		public string tpsCameraTargetOffset = "1;0.3;0";

		public float aimingSensitivityMultiplier = 0.5f;

		public float tpsCameraTransitDuration = 0.7f;

		public float tpsCameraRunAddDistance = 1f;

		public float tpsCameraActionDistanceRatio = 0.5f;

		public float tpsStrafeWithoutActionDuration = 2f;

		public float tpsHeadMaxHorizontalAngle = 45f;

		public float autoAimingMaxAngle = 15f;

		public float autoAimingAngleSpeed = 30f;

		public int moveSpeedPower = 1;

		public float autoShootDelay = 0.2f;

		public int allowCameraChange = 1;

		public float tpsCameraHorizontalBackSpeed = 0.7f;

		public int defaultStepSoundId = 9;

		public int useAnimationEvent = 1;

		public int allowAutoAiming = 1;

		public int allowAlignTpsCamera = 1;

		public float tpsLegsRotationSpeed = 360f;

		public float tpsTorsoRotationSpeed = 360f;

		public float recoilDecSpeed = 30f;

		public float recoilDecPause = 0.2f;

		public int recoilResetOnInput = 1;

		public float scatterRunningIncSpeed = 45f;

		public override void Deserialize()
		{
			autoJumpDelay = TryGetFloat(MyPlayerInputContentKeys.autoJumpDelay, 0.2f);
			autoJumpResetDelay = TryGetFloat(MyPlayerInputContentKeys.autoJumpResetDelay, 2.5f);
			bodyHeight = TryGetFloat(MyPlayerInputContentKeys.bodyHeight, 1.8f);
			bodyRadius = TryGetFloat(MyPlayerInputContentKeys.bodyRadius, 0.4f);
			cameraHeight = TryGetFloat(MyPlayerInputContentKeys.cameraHeight, 1.65f);
			clickDistanceTreshold = TryGetInt(MyPlayerInputContentKeys.clickDistanceTreshold, 25);
			clickTimeTreshold = TryGetFloat(MyPlayerInputContentKeys.clickTimeTreshold, 0.25f);
			criticalFallHeight = TryGetInt(MyPlayerInputContentKeys.criticalFallHeight, 8);
			fallSpeed = TryGetFloat(MyPlayerInputContentKeys.fallSpeed, 50f);
			fallSpeedMax = TryGetFloat(MyPlayerInputContentKeys.fallSpeedMax, 70f);
			inAirMoveRatio = TryGetFloat(MyPlayerInputContentKeys.inAirMoveRatio, 1f);
			jumpHeight = TryGetFloat(MyPlayerInputContentKeys.jumpHeight, 1.05f);
			moveSpeed = TryGetFloat(MyPlayerInputContentKeys.moveSpeed, 5.5f);
			landingSoundMinimalHeight = TryGetFloat(MyPlayerInputContentKeys.landingSoundMinimalHeight, 0.6f);
			stepDistance = TryGetFloat(MyPlayerInputContentKeys.stepDistance, 1.8f);
			flightSpeed = TryGetFloat(MyPlayerInputContentKeys.flightSpeed, 4f);
			touchSensitivity = TryGetInt(MyPlayerInputContentKeys.touchSensitivity, 70);
			tpsCameraDistance = TryGetFloat(MyPlayerInputContentKeys.tpsCameraDistance, 3.5f);
			tpsCameraTargetOffset = TryGetString(MyPlayerInputContentKeys.tpsCameraTargetOffset, "1;0.3;0");
			aimingSensitivityMultiplier = TryGetFloat(MyPlayerInputContentKeys.aimingSensitivityMultiplier, 0.5f);
			tpsCameraTransitDuration = TryGetFloat(MyPlayerInputContentKeys.tpsCameraTransitDuration, 0.7f);
			tpsCameraRunAddDistance = TryGetFloat(MyPlayerInputContentKeys.tpsCameraRunAddDistance, 1f);
			tpsCameraActionDistanceRatio = TryGetFloat(MyPlayerInputContentKeys.tpsCameraActionDistanceRatio, 0.5f);
			tpsStrafeWithoutActionDuration = TryGetFloat(MyPlayerInputContentKeys.tpsStrafeWithoutActionDuration, 2f);
			tpsHeadMaxHorizontalAngle = TryGetFloat(MyPlayerInputContentKeys.tpsHeadMaxHorizontalAngle, 45f);
			autoAimingMaxAngle = TryGetFloat(MyPlayerInputContentKeys.autoAimingMaxAngle, 15f);
			autoAimingAngleSpeed = TryGetFloat(MyPlayerInputContentKeys.autoAimingAngleSpeed, 30f);
			moveSpeedPower = TryGetInt(MyPlayerInputContentKeys.moveSpeedPower, 1);
			autoShootDelay = TryGetFloat(MyPlayerInputContentKeys.autoShootDelay, 0.2f);
			allowCameraChange = TryGetInt(MyPlayerInputContentKeys.allowCameraChange, 1);
			tpsCameraHorizontalBackSpeed = TryGetFloat(MyPlayerInputContentKeys.tpsCameraHorizontalBackSpeed, 0.7f);
			defaultStepSoundId = TryGetInt(MyPlayerInputContentKeys.defaultStepSoundId, 9);
			useAnimationEvent = TryGetInt(MyPlayerInputContentKeys.useAnimationEvent, 1);
			allowAutoAiming = TryGetInt(MyPlayerInputContentKeys.allowAutoAiming, 1);
			allowAlignTpsCamera = TryGetInt(MyPlayerInputContentKeys.allowAlignTpsCamera, 1);
			tpsLegsRotationSpeed = TryGetFloat(MyPlayerInputContentKeys.tpsLegsRotationSpeed, 360f);
			tpsTorsoRotationSpeed = TryGetFloat(MyPlayerInputContentKeys.tpsTorsoRotationSpeed, 360f);
			recoilDecSpeed = TryGetFloat(MyPlayerInputContentKeys.recoilDecSpeed, 30f);
			recoilDecPause = TryGetFloat(MyPlayerInputContentKeys.recoilDecPause, 0.2f);
			recoilResetOnInput = TryGetInt(MyPlayerInputContentKeys.recoilResetOnInput, 1);
			scatterRunningIncSpeed = TryGetFloat(MyPlayerInputContentKeys.scatterRunningIncSpeed, 45f);
			base.Deserialize();
		}
	}
}
