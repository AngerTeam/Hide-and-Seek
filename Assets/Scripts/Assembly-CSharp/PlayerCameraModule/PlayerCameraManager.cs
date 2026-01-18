using CraftyEngine;
using CraftyEngine.Infrastructure;
using MyPlayerInput;
using UnityEngine;

namespace PlayerCameraModule
{
	public class PlayerCameraManager : CameraManager
	{
		private PlayerCamera camera_;

		private CameraInputController cameraInputController_;

		private PlayerCameraInputModel cameraInputModel_;

		private PlayerCameraStatesController cameraStatesController_;

		private InputManager inputManager_;

		public override Camera PlayerCamera
		{
			get
			{
				return camera_.UnityCamera;
			}
		}

		public PlayerCamera Camera
		{
			get
			{
				return camera_;
			}
		}

		public float FovMultiplier
		{
			get
			{
				return camera_.FovMultiplier;
			}
			set
			{
				camera_.FovMultiplier = value;
			}
		}

		public override float TargetDistance
		{
			get
			{
				return camera_.Distance;
			}
		}

		public PlayerCameraStatesController StatesController
		{
			get
			{
				return cameraStatesController_;
			}
		}

		public PlayerCameraInputModel InputModel
		{
			get
			{
				return cameraInputModel_;
			}
		}

		public PlayerCameraManager()
		{
			AdjustableSettings.Register<VideoSettingsInGameMenu>();
			cameraInputModel_ = new PlayerCameraInputModel();
		}

		public void ResetFov()
		{
			PersistanceUserSettings settings;
			PersistanceManager.Get<PersistanceUserSettings>(out settings);
			SetFov(settings.fieldOfView);
		}

		public override void Init()
		{
			base.Init();
			Debug.Log("PlayerCameraManager::INit");
			SingletonManager.TryGet<InputManager>(out inputManager_);
			inputManager_.Updated += Update;
			InitCamera();
			InitStates();
		}

		public override void Dispose()
		{
			if (cameraStatesController_ != null)
			{
				cameraStatesController_.Dispose();
			}
			inputManager_.Updated -= Update;
			base.Dispose();
		}

		public override void OnDataLoaded()
		{
			if (PlayerCamera != null)
			{
				PlayerCamera.nearClipPlane = 0.03f;
				PlayerCamera.farClipPlane = 1000f;
			}
			else
			{
				base.OnDataLoaded();
			}
			cameraStatesController_.StateThirdPerson.MaxDistance = MyPlayerInputContentMap.PlayerSettings.tpsCameraDistance;
			cameraStatesController_.StateThirdPerson.TargetOffset = Vector3Utils.SafeParse(MyPlayerInputContentMap.PlayerSettings.tpsCameraTargetOffset);
			cameraInputModel_.autoAimMaxAngle = MyPlayerInputContentMap.PlayerSettings.autoAimingMaxAngle;
			cameraInputModel_.autoAimAngleSpeed = MyPlayerInputContentMap.PlayerSettings.autoAimingAngleSpeed;
			cameraInputModel_.recoilResetOnInput = MyPlayerInputContentMap.PlayerSettings.recoilResetOnInput > 0;
		}

		public void SetFov(float fov)
		{
			camera_.Fov = fov;
		}

		public void SetObstacleSensor(ICameraObstacleSensor obstacleSensor)
		{
			cameraStatesController_.StateThirdPerson.ObstacleSensor = obstacleSensor;
		}

		public void Reset(Vector3 rotation)
		{
			camera_.SetRotationAroundTarget(Quaternion.Euler(rotation));
			cameraStatesController_.Reset();
			cameraInputController_.Reset();
		}

		public override void OnReset()
		{
			base.OnReset();
			cameraStatesController_.SwitchStaticState(Vector3.zero, Quaternion.identity);
		}

		protected override void Toggle(bool enabled)
		{
			camera_.Enabled = enabled;
		}

		public void Update()
		{
			if (camera_.Enabled)
			{
				cameraInputController_.Update();
				cameraStatesController_.Update();
				cameraInputController_.LateUpdate();
			}
		}

		private void InitCamera()
		{
			PrefabsManager prefabsManager = SingletonManager.Get<PrefabsManager>();
			prefabsManager.Load("PlayerCamera");
			PersistanceUserSettings settings;
			PersistanceManager.Get<PersistanceUserSettings>(out settings);
			cameraInputModel_.EnabledByState = true;
			cameraInputModel_.EnabledByPlayer = true;
			cameraGameObject_ = prefabsManager.Instantiate("DefaultCamera");
			Object.DontDestroyOnLoad(cameraGameObject_);
			Camera camera = cameraGameObject_.GetComponent<Camera>() ?? cameraGameObject_.AddComponent<Camera>();
			camera.clearFlags = CameraClearFlags.Skybox;
			camera.cullingMask = 2147417567;
			camera.nearClipPlane = 0.03f;
			camera.farClipPlane = 1000f;
			camera.depth = 3f;
			camera.enabled = false;
			camera_ = new PlayerCamera(camera);
			cameraInputController_ = new CameraInputController(camera_, cameraInputModel_);
		}

		private void InitStates()
		{
			cameraStatesController_ = new PlayerCameraStatesController(camera_, cameraInputModel_);
		}
	}
}
