using CraftyEngine.Infrastructure;
using PlayerCameraModule;
using UnityEngine;

namespace MyPlayerInput
{
	public abstract class PersonInputController
	{
		private bool? enabled_;

		protected readonly PlayerCameraManager cameraManager_;

		protected readonly InputManager inputManager_;

		protected readonly BodySmoothTransformController bodySmoothTransformController_;

		public bool Enabled
		{
			get
			{
				return enabled_.HasValue && enabled_.Value;
			}
			set
			{
				if (!enabled_.HasValue || enabled_.Value != value)
				{
					enabled_ = value;
					if (enabled_.Value)
					{
						OnEnable();
					}
				}
			}
		}

		public PersonInputController(BodySmoothTransformController bodySmoothTransformController)
		{
			bodySmoothTransformController_ = bodySmoothTransformController;
			SingletonManager.TryGet<PlayerCameraManager>(out cameraManager_);
			SingletonManager.TryGet<InputManager>(out inputManager_);
		}

		public virtual void Update()
		{
		}

		public virtual void FixedUpdate()
		{
		}

		public virtual void Reset()
		{
		}

		public virtual void UpdateInteractiveAction(bool hasAction)
		{
		}

		public virtual Vector3 TransformMoveDirection(Vector3 moveDirection)
		{
			if (moveDirection != Vector3.zero)
			{
				moveDirection = cameraManager_.Transform.TransformDirection(moveDirection);
			}
			return moveDirection;
		}

		public virtual void ResetTransform(Vector3 position, Vector3 rotation)
		{
			bodySmoothTransformController_.Reset(position, rotation);
		}

		protected virtual void OnEnable()
		{
			AlignRotationWithCamera();
		}

		protected virtual void AlignRotationWithCamera()
		{
			bodySmoothTransformController_.SetRotation(cameraManager_.Transform.eulerAngles);
		}
	}
}
