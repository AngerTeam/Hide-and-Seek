using System;
using CraftyEngine.States;
using Extensions;
using UnityEngine;

namespace PlayerCameraModule
{
	public class PlayerCameraStatesController : IDisposable
	{
		private readonly PlayerCamera camera_;

		private readonly StateMachine stateMachine_;

		private CameraMode cameraMode_;

		private readonly PlayerCameraInputModel cameraInputModel_;

		private bool thirdPersonMode_;

		public CameraMode Mode
		{
			get
			{
				return cameraMode_;
			}
			private set
			{
				if (cameraMode_ != value)
				{
					cameraMode_ = value;
					this.CameraModeChanged.SafeInvoke(cameraMode_);
				}
			}
		}

		public FirstPersonCameraState StateFirstPerson { get; private set; }

		public ThirdPersonCameraState StateThirdPerson { get; private set; }

		public AimingCameraState StateAiming { get; private set; }

		public CinematicCameraState StateCinematic { get; private set; }

		public StaticCameraState StateStatic { get; private set; }

		public event Action<CameraMode> CameraModeChanged;

		public PlayerCameraStatesController(PlayerCamera camera, PlayerCameraInputModel cameraInputModel)
		{
			camera_ = camera;
			cameraInputModel_ = cameraInputModel;
			StateFirstPerson = new FirstPersonCameraState(camera_, cameraInputModel);
			StateThirdPerson = new ThirdPersonCameraState(camera_, cameraInputModel);
			StateAiming = new AimingCameraState(camera_, cameraInputModel);
			StateCinematic = new CinematicCameraState(camera_, cameraInputModel);
			StateStatic = new StaticCameraState(camera_, cameraInputModel);
			StateFirstPerson.Entered += delegate
			{
				Mode = CameraMode.FirstPerson;
				thirdPersonMode_ = false;
			};
			StateThirdPerson.Entered += delegate
			{
				Mode = CameraMode.ThirdPerson;
				thirdPersonMode_ = true;
			};
			StateAiming.Entered += delegate
			{
				Mode = CameraMode.Aiming;
			};
			StateCinematic.Entered += delegate
			{
				Mode = CameraMode.Cinematic;
			};
			StateStatic.Entered += delegate
			{
				Mode = CameraMode.Static;
			};
			State initialState = new State("Empty");
			stateMachine_ = new StateMachine(initialState, "PlayerCameraStateMachine");
		}

		public void Update()
		{
			if (stateMachine_ != null)
			{
				stateMachine_.Update();
				CameraState cameraState = stateMachine_.CurrentState as CameraState;
				if (cameraState != null)
				{
					cameraState.Update();
				}
			}
		}

		public void Reset()
		{
			CameraState cameraState = stateMachine_.CurrentState as CameraState;
			if (cameraState != null)
			{
				cameraState.Reset();
			}
		}

		public void SwitchToPersonMode(bool immediate = false)
		{
			if (thirdPersonMode_)
			{
				SwitchThirdPersonState(immediate);
			}
			else
			{
				SwitchFirstPersonState(immediate);
			}
		}

		public void TogglePersonMode()
		{
			thirdPersonMode_ = !thirdPersonMode_;
			if (cameraMode_ == CameraMode.FirstPerson || cameraMode_ == CameraMode.ThirdPerson)
			{
				SwitchToPersonMode();
			}
		}

		public void SwitchFirstPersonState(bool immediate = false)
		{
			if (immediate)
			{
				stateMachine_.GoTo(StateFirstPerson);
				return;
			}
			TransitionalCameraState transitionalCameraState = new TransitionalCameraState(camera_, cameraInputModel_);
			transitionalCameraState.Target = StateFirstPerson.Target;
			transitionalCameraState.AddTransaction(StateFirstPerson);
			stateMachine_.GoTo(transitionalCameraState);
		}

		public void SwitchThirdPersonState(bool immediate = false)
		{
			if (immediate)
			{
				camera_.SetTarget(StateFirstPerson.Target.position);
				camera_.SetTargetOffset(StateThirdPerson.TargetOffset);
				camera_.Distance = StateThirdPerson.MaxDistance;
				stateMachine_.GoTo(StateThirdPerson);
				return;
			}
			TransitionalCameraState transitionalCameraState = new TransitionalCameraState(camera_, cameraInputModel_);
			transitionalCameraState.Target = StateFirstPerson.Target;
			transitionalCameraState.Distance = StateThirdPerson.MaxDistance;
			transitionalCameraState.TargetOffset = StateThirdPerson.TargetOffset;
			transitionalCameraState.ObstacleSensor = StateThirdPerson.ObstacleSensor;
			transitionalCameraState.AddTransaction(StateThirdPerson);
			transitionalCameraState.Entered += delegate
			{
				Mode = CameraMode.ThirdPerson;
				thirdPersonMode_ = true;
			};
			stateMachine_.GoTo(transitionalCameraState);
		}

		public void SwitchAimingState(float fovMultiplier)
		{
			StateAiming.FovMultiplier = fovMultiplier;
			stateMachine_.GoTo(StateAiming);
		}

		public void SwitchCinematicState(Vector3 position)
		{
			StateCinematic.TargetPosition = position;
			TransitionalCameraState transitionalCameraState = new TransitionalCameraState(camera_, cameraInputModel_);
			transitionalCameraState.IsTweenTargetPosition = true;
			transitionalCameraState.TargetPosition = StateCinematic.TargetPosition;
			transitionalCameraState.Distance = StateCinematic.Distance;
			transitionalCameraState.Duration = 1f;
			transitionalCameraState.AddTransaction(StateCinematic);
			stateMachine_.GoTo(transitionalCameraState);
		}

		public void SwitchStaticState(Vector3 position, Quaternion rotation)
		{
			StateStatic.CameraPosition = position;
			StateStatic.CameraRotation = rotation;
			stateMachine_.GoTo(StateStatic);
		}

		public void Dispose()
		{
			if (stateMachine_ != null)
			{
				stateMachine_.Dispose();
			}
		}
	}
}
