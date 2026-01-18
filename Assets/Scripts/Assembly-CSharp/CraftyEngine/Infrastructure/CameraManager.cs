using CraftyEngine.Utils;
using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class CameraManager : PermanentSingleton
	{
		protected GameObject cameraGameObject_;

		private GameObject backgroundCameraGameObject_;

		private VoteCounter voteCounter_;

		public Transform Transform
		{
			get
			{
				return PlayerCamera.transform;
			}
		}

		public virtual Camera PlayerCamera { get; protected set; }

		public virtual float TargetDistance
		{
			get
			{
				return 0f;
			}
		}

		public override void Init()
		{
			backgroundCameraGameObject_ = AddCamera("background camera", true);
			voteCounter_ = new VoteCounter
			{
				mainAnchor = false
			};
		}

		public override void OnDataLoaded()
		{
			if (PlayerCamera == null)
			{
				cameraGameObject_ = AddCamera("PlayerCamera camera", false);
				PlayerCamera = cameraGameObject_.GetComponent<Camera>();
			}
		}

		public override void OnReset()
		{
			SetVisiblePlease(this, true);
		}

		public void SetVisiblePlease(object applicant, bool visible)
		{
			Toggle(voteCounter_.SetEnable(applicant, visible));
		}

		protected virtual void Toggle(bool enabled)
		{
		}

		private GameObject AddCamera(string titile, bool background)
		{
			GameObject gameObject;
			if (background)
			{
				PrefabsManager prefabsManager = SingletonManager.Get<PrefabsManager>();
				prefabsManager.Load("PlayerCamera");
				Camera camera = prefabsManager.Instantiate<Camera>("BackgroundCamera");
				gameObject = camera.gameObject;
				camera.depth = 1f;
			}
			else
			{
				gameObject = new GameObject(titile);
				Object.DontDestroyOnLoad(gameObject);
			}
			return gameObject;
		}

		public override void Dispose()
		{
			if (PlayerCamera != null)
			{
				Object.Destroy(PlayerCamera.gameObject);
			}
			if (cameraGameObject_ != null)
			{
				Object.Destroy(cameraGameObject_);
			}
			Object.Destroy(backgroundCameraGameObject_);
		}

		public bool CanSeePoint(Vector3 point)
		{
			Vector3 point2 = PlayerCamera.WorldToViewportPoint(point);
			return point2.z > 0f && new Rect(0f, 0f, 1f, 1f).Contains(point2);
		}
	}
}
