using System;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils.Unity;
using CraftyVoxelEngine;
using Extensions;
using PlayerCameraModule;
using UnityEngine;

namespace MyPlayerInput
{
	public class MyPlayerInputController : IDisposable
	{
		public float distance;

		public UnityEventType mouseEventType;

		public UnityEventType moveEventType;

		public bool Started;

		public bool useUnityRigidbody = true;

		private Vector3 forcePulse;

		private Vector3 currentPosition_;

		private float deltaTime_;

		private Vector3 direction_;

		private float height0_;

		private float height1_;

		private float height2_;

		private Vector3 input3D_;

		private InputManager inputManager_;

		private Vector3 newPosition_;

		private MyPlayerInputModel model_;

		private CameraShaker shaker_;

		private Rigidbody unityRigidbody_;

		private PlayerCameraManager cameraManager_;

		private PersonInputController currentPersonInputController;

		private FirstPersonInputController firstPersonInputController_;

		private ThirdPersonInputController thirdPersonInputController_;

		public Transform EyesTransform { get; private set; }

		public Vector3 Forward
		{
			get
			{
				return (!(GameObject == null)) ? GameObject.transform.forward : Vector3.zero;
			}
		}

		public GameObject GameObject { get; private set; }

		public JumpController JumpController { get; private set; }

		public Vector3 LocalEulerAngles
		{
			get
			{
				return (!(GameObject == null) && !(EyesTransform == null)) ? new Vector3(EyesTransform.localEulerAngles.x, GameObject.transform.localEulerAngles.y, 0f) : Vector3.zero;
			}
		}

		public Vector3 Position
		{
			get
			{
				return (!(GameObject == null)) ? GameObject.transform.position : Vector3.zero;
			}
		}

		private PersonInputController CurrentPersonInputController
		{
			get
			{
				return currentPersonInputController;
			}
			set
			{
				if (currentPersonInputController != value)
				{
					if (currentPersonInputController != null)
					{
						currentPersonInputController.Enabled = false;
					}
					currentPersonInputController = value;
					if (currentPersonInputController != null)
					{
						currentPersonInputController.Enabled = true;
					}
				}
			}
		}

		public SoundLogic SoundLogic { get; private set; }

		public VoxelRigidBody VoxelRigidBody { get; private set; }

		public event Action<Vector3, Vector3> FallToRespawnZone;

		public event Action<Vector3, Vector3> PositionUpdated;

		public MyPlayerInputController()
		{
			SingletonManager.Get<MyPlayerInputModel>(out model_);
			UnityEvent singlton;
			SingletonManager.Get<UnityEvent>(out singlton, 1);
			SingletonManager.Get<InputManager>(out inputManager_);
			SingletonManager.Get<PlayerCameraManager>(out cameraManager_);
			singlton.Subscribe(UnityEventType.Update, UnityUpdate);
			singlton.Subscribe(UnityEventType.FixedUpdate, UnityFixedUpdate);
			Init();
		}

		public void Dispose()
		{
			this.FallToRespawnZone = null;
			this.PositionUpdated = null;
			UnityEngine.Object.Destroy(GameObject);
			if (unityRigidbody_ != null)
			{
				UnityEngine.Object.Destroy(unityRigidbody_.gameObject);
			}
		}

		public void Reset(Vector3 position, Vector3 rotation)
		{
			JumpController.Reset(position);
			if (GameObject != null)
			{
				GameObject.transform.position = position;
				shaker_.Reset();
				GameObject.transform.localEulerAngles = rotation;
				EyesTransform.localEulerAngles = rotation;
				unityRigidbody_.position = GameObject.transform.position;
				unityRigidbody_.transform.position = GameObject.transform.position;
				unityRigidbody_.rotation = GameObject.transform.rotation;
				unityRigidbody_.transform.rotation = GameObject.transform.rotation;
				unityRigidbody_.velocity = Vector3.zero;
				VoxelRigidBody.DropVelocity();
			}
			cameraManager_.Reset(rotation);
			CurrentPersonInputController.Reset();
		}

		public void UpdateInteractiveAction(bool hasAction)
		{
			if (CurrentPersonInputController != null)
			{
				CurrentPersonInputController.UpdateInteractiveAction(hasAction);
			}
		}

		public void ToggleInputMode(bool firstPerson)
		{
			CurrentPersonInputController = ((!firstPerson) ? ((PersonInputController)thirdPersonInputController_) : ((PersonInputController)firstPersonInputController_));
		}

		internal void Start()
		{
			Started = true;
			JumpController.playerGameObject = GameObject;
			GameObject gameObject = new GameObject("Player Unity Physics");
			UnityEngine.Object.DontDestroyOnLoad(gameObject);
			unityRigidbody_ = gameObject.AddComponent<Rigidbody>();
			unityRigidbody_.useGravity = false;
			unityRigidbody_.freezeRotation = true;
			unityRigidbody_.position = GameObject.transform.position;
			GameObjectUtils.SetLayer(unityRigidbody_.gameObject, 10);
			CapsuleCollider capsuleCollider = gameObject.AddComponent<CapsuleCollider>();
			capsuleCollider.height = model_.height;
			capsuleCollider.center = new Vector3(0f, model_.height * 0.5f, 0f);
		}

		private void Init()
		{
			model_.Reset();
			moveEventType = UnityEventType.FixedUpdate;
			mouseEventType = UnityEventType.Update;
			GameObject = new GameObject("MyPlayerInputController");
			UnityEngine.Object.DontDestroyOnLoad(GameObject);
			GameObject gameObject = new GameObject("MyPlayerControllerEyes");
			EyesTransform = gameObject.transform;
			EyesTransform.SetParent(GameObject.transform, false);
			EyesTransform.localPosition = new Vector3(0f, model_.eyesHeight, 0f);
			BodySmoothTransformController bodySmoothTransformController = new BodySmoothTransformController(GameObject.transform, EyesTransform);
			bodySmoothTransformController.LegsPitchRotationSpeed = MyPlayerInputContentMap.PlayerSettings.tpsLegsRotationSpeed;
			bodySmoothTransformController.TorsoYawRotationSpeed = MyPlayerInputContentMap.PlayerSettings.tpsTorsoRotationSpeed;
			BodySmoothTransformController bodySmoothTransformController2 = bodySmoothTransformController;
			firstPersonInputController_ = new FirstPersonInputController(bodySmoothTransformController2);
			thirdPersonInputController_ = new ThirdPersonInputController(bodySmoothTransformController2);
			CurrentPersonInputController = firstPersonInputController_;
			int layer = 1;
			SoundLogic = new SoundLogic(model_.soundFallMinimumHeight, model_.soundStepDistance);
			VoxelRigidBody = new VoxelRigidBody(model_.gravity, model_.maxFallSpeed, model_.height, model_.radius);
			VoxelRigidBody.checkExtraPoins = true;
			VoxelRigidBody.FellOnGround += HandleFellOnGround;
			height0_ = 0f;
			height1_ = model_.height * 0.5f;
			height2_ = model_.height - 0.01f;
			JumpController = new JumpController(model_, VoxelRigidBody, SoundLogic, layer);
			shaker_ = new CameraShaker(model_.eyesHeight);
			shaker_.enabled = false;
		}

		private void CheckSideCollisions(float yoffset, ref Vector3 newPosition)
		{
			newPosition.y += yoffset;
			VoxelRigidBody.CheckSideCollisions(ref newPosition);
			newPosition.y -= yoffset;
		}

		private void HandleFalling()
		{
			if (GameObject.activeInHierarchy && GameObject.transform.position.y < model_.respawnHeight)
			{
				VoxelRigidBody.DropVelocity();
				VoxelRigidBody.AddUpForce(10f);
				this.FallToRespawnZone.SafeInvoke(Position, LocalEulerAngles);
			}
		}

		private void HandleFellOnGround()
		{
			JumpController.HandleFellOnGround();
		}

		public void AddForcePulse(Vector3 pulse)
		{
			forcePulse = pulse;
		}

		private void HandleInput()
		{
			Vector2 move = inputManager_.GetMove();
			input3D_ = new Vector3(move.x, 0f, move.y);
			float num = Mathf.Sqrt(move.x * move.x + move.y * move.y);
			if (num > 1f)
			{
				input3D_ /= num;
			}
			direction_ = input3D_ * model_.moveSpeed * deltaTime_;
			direction_ *= 1f + model_.speedRatio + model_.speedBoost;
			JumpController.Update(move);
		}

		private void HandleMove(float deltaTime)
		{
			if (!(GameObject == null))
			{
				deltaTime_ = deltaTime;
				currentPosition_ = GameObject.transform.position;
				HandleInput();
				if (model_.flight)
				{
					HandleFlight();
				}
				else
				{
					HandleWalk();
				}
				if (model_.clipping)
				{
					HandleVoxelClipping();
				}
				HandleShapeClipping();
				if (VoxelRigidBody.Grounded)
				{
					JumpController.Reset(newPosition_);
					SoundLogic.CheckStep(Vector3.Distance(newPosition_, currentPosition_), newPosition_);
				}
				HandleFalling();
			}
		}

		private void HandleShapeClipping()
		{
			VoxelRigidBody.CheckShapeTrigger(currentPosition_);
			distance = Vector3.Distance(newPosition_, GameObject.transform.position);
			shaker_.Update(distance);
			GameObject.transform.position = newPosition_;
			unityRigidbody_.MovePosition(newPosition_);
			unityRigidbody_.velocity = Vector3.zero;
			model_.speed = ((!(deltaTime_ > 0f)) ? 0f : (distance / deltaTime_));
		}

		private void HandleVoxelClipping()
		{
			if (direction_ != Vector3.zero && VoxelRigidBody.Grounded)
			{
				Vector3 vector = CurrentPersonInputController.TransformMoveDirection(input3D_);
				vector.y = 0f;
				vector = vector.normalized * input3D_.magnitude;
				Vector3 vector2 = GameObject.transform.position + vector;
				Vector3 vector3 = vector2;
				vector3.y += height2_;
				Debug.DrawLine(vector2, vector3, Color.red);
				JumpController.HandleInput(vector2, vector3);
			}
			VoxelRigidBody.CheckHeightCollisions(ref newPosition_);
			CheckSideCollisions(height0_, ref newPosition_);
			CheckSideCollisions(height1_, ref newPosition_);
			CheckSideCollisions(height2_, ref newPosition_);
		}

		private void HandleWalk()
		{
			VoxelRigidBody.CheckGrounded(currentPosition_);
			if (model_.jumping || !VoxelRigidBody.Grounded)
			{
				direction_ *= model_.airMoveRatio;
			}
			CurrentPersonInputController.TransformMoveDirection(direction_);
			Quaternion quaternion = Quaternion.Euler(0f, cameraManager_.Transform.eulerAngles.y, 0f);
			Vector3 vector = (quaternion * direction_).normalized * direction_.magnitude;
			if (forcePulse != Vector3.zero)
			{
				vector += forcePulse;
				forcePulse = Vector3.zero;
			}
			if (useUnityRigidbody)
			{
				if (unityRigidbody_ == null)
				{
					return;
				}
				unityRigidbody_.transform.rotation = GameObject.transform.rotation;
				newPosition_ = unityRigidbody_.transform.position + vector;
			}
			else
			{
				newPosition_ = GameObject.transform.position + vector;
			}
			newPosition_.y += VoxelRigidBody.FallSpeed * deltaTime_;
		}

		private void HandleFlight()
		{
			float num = ((!inputManager_.Model.Shift) ? model_.flightSpeed : (2f * model_.flightSpeed));
			shaker_.enabled = false;
			CurrentPersonInputController.TransformMoveDirection(direction_ * num);
			Vector3 vector = (cameraManager_.Transform.rotation * direction_).normalized * direction_.magnitude * num;
			newPosition_ = GameObject.transform.position + vector;
			if (inputManager_.Model.Space || model_.movingUp)
			{
				newPosition_.y += model_.moveSpeed * deltaTime_ * num;
			}
		}

		private void UnityFixedUpdate()
		{
			if (model_.moveEnabled)
			{
				if (CurrentPersonInputController != null)
				{
					CurrentPersonInputController.FixedUpdate();
				}
				if (moveEventType == UnityEventType.FixedUpdate)
				{
					HandleMove(Time.fixedDeltaTime);
				}
				if (mouseEventType == UnityEventType.FixedUpdate)
				{
					shaker_.Apply();
					this.PositionUpdated.SafeInvoke(Position, LocalEulerAngles);
				}
				VoxelRigidBody.ApplyGravity();
			}
		}

		private void UnityUpdate()
		{
			cameraManager_.InputModel.EnabledByPlayer = model_.rotateEnabled;
			if (model_.moveEnabled)
			{
				if (CurrentPersonInputController != null)
				{
					CurrentPersonInputController.Update();
				}
				if (moveEventType == UnityEventType.Update)
				{
					HandleMove(Time.deltaTime);
				}
				if (mouseEventType == UnityEventType.Update)
				{
					shaker_.Apply();
					this.PositionUpdated.SafeInvoke(Position, LocalEulerAngles);
				}
			}
		}
	}
}
