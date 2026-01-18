using CraftyEngine.Infrastructure;
using CraftyVoxelEngine;
using UnityEngine;

namespace Effects
{
	public class FlareFxController : Singleton
	{
		private MapFxModel model_;

		private UnityEvent unityEvent_;

		private CameraManager cameraManager_;

		private VoxelEngine voxelEngine_;

		private void Update()
		{
			if (!(model_.CurrentFlareBatch == null) && !(model_.CurrentFlare == null) && voxelEngine_.anyChunkRendered)
			{
				Vector3 direction = cameraManager_.PlayerCamera.transform.position - model_.CurrentFlare.thisTransform.position;
				float limit = Vector3.Distance(cameraManager_.PlayerCamera.transform.position, model_.CurrentFlare.thisTransform.position);
				VoxelRaycastHit voxelRaycastHit = voxelEngine_.Manager.RayCast(model_.CurrentFlare.thisTransform.position, direction, limit, true);
				model_.CurrentFlareBatch.UpdateVisibility(voxelRaycastHit.success);
			}
		}

		public override void Init()
		{
			GetSingleton<MapFxModel>(out model_);
			GetSingleton<UnityEvent>(out unityEvent_);
			SingletonManager.Get<CameraManager>(out cameraManager_);
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
		}

		public void Load()
		{
			unityEvent_.Subscribe(UnityEventType.FixedUpdate, Update);
		}

		public void Unload()
		{
			unityEvent_.Unsubscribe(UnityEventType.FixedUpdate, Update);
		}
	}
}
