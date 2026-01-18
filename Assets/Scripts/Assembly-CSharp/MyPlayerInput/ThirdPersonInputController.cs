using UnityEngine;

namespace MyPlayerInput
{
	public class ThirdPersonInputController : PersonInputController
	{
		private const float bodySmoothTransformAfterMoveInterval_ = 2f;

		private readonly PersistanceUserSettings userSettings_;

		private readonly MyPlayerInputModel inputModel_;

		private float lastInteractiveActionMoment_;

		private bool strafe_;

		private bool run_;

		private bool lastInteractiveAction_;

		public ThirdPersonInputController(BodySmoothTransformController bodySmoothTransformController)
			: base(bodySmoothTransformController)
		{
			PersistanceManager.Get<PersistanceUserSettings>(out userSettings_);
			SingletonManager.TryGet<MyPlayerInputModel>(out inputModel_);
		}

		public override void Update()
		{
			if (!lastInteractiveAction_ && Time.time > lastInteractiveActionMoment_ + MyPlayerInputContentMap.PlayerSettings.tpsStrafeWithoutActionDuration)
			{
				strafe_ = false;
			}
			float num = (strafe_ ? (cameraManager_.StatesController.StateThirdPerson.MaxDistance * MyPlayerInputContentMap.PlayerSettings.tpsCameraActionDistanceRatio) : cameraManager_.StatesController.StateThirdPerson.MaxDistance);
			if (lastInteractiveAction_)
			{
				AlignRotationWithCamera();
			}
			if (run_)
			{
				bodySmoothTransformController_.TorsoYawRotation = cameraManager_.Transform.eulerAngles.x;
				num += MyPlayerInputContentMap.PlayerSettings.tpsCameraRunAddDistance;
			}
			else
			{
				bodySmoothTransformController_.TorsoYawRotation = 0f;
			}
			cameraManager_.StatesController.StateThirdPerson.Distance = num;
			if (userSettings_.autoAlignTpsCamera && run_ && !strafe_ && !cameraManager_.InputModel.inputRotationControl && !inputModel_.flight)
			{
				Vector3 eulerAngles = cameraManager_.Camera.Transform.eulerAngles;
				eulerAngles.x = Mathf.LerpAngle(eulerAngles.x, 0f, Time.deltaTime * MyPlayerInputContentMap.PlayerSettings.tpsCameraHorizontalBackSpeed);
				cameraManager_.Camera.SetRotationAroundTarget(Quaternion.Euler(eulerAngles));
			}
			bodySmoothTransformController_.Update();
		}

		public override void Reset()
		{
			run_ = false;
			lastInteractiveAction_ = false;
			lastInteractiveActionMoment_ = 0f;
			strafe_ = false;
			AlignRotationWithCamera();
			bodySmoothTransformController_.TorsoYawRotation = 0f;
		}

		public override void UpdateInteractiveAction(bool hasAction)
		{
			if (hasAction)
			{
				strafe_ = true;
				AlignRotationWithCamera();
			}
			else if (lastInteractiveAction_)
			{
				lastInteractiveActionMoment_ = Time.time;
			}
			lastInteractiveAction_ = hasAction;
		}

		public override Vector3 TransformMoveDirection(Vector3 moveDirection)
		{
			if (moveDirection != Vector3.zero)
			{
				run_ = true;
				Quaternion quaternion = Quaternion.Euler(0f, cameraManager_.Transform.eulerAngles.y, 0f);
				Vector3 vector = (quaternion * moveDirection).normalized * moveDirection.magnitude;
				bodySmoothTransformController_.LegsPitchRotation = ((!strafe_) ? Quaternion.LookRotation(vector).eulerAngles.y : cameraManager_.Transform.eulerAngles.y);
				return vector;
			}
			run_ = false;
			return moveDirection;
		}

		protected override void OnEnable()
		{
			base.OnEnable();
			Reset();
		}
	}
}
