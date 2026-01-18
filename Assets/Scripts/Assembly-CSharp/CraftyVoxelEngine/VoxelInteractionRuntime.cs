using System;
using CraftyEngine.Infrastructure;

namespace CraftyVoxelEngine
{
	public class VoxelInteractionRuntime : IDisposable
	{
		private RaycastManager raycastManager_;

		private VoxelInteractionModel model_;

		private VoxelEngine voxelEngine_;

		private UnityEvent unityEvent_;

		public VoxelInteractionRuntime(VoxelInteractionModel model)
		{
			model_ = model;
			SingletonManager.Get<RaycastManager>(out raycastManager_);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			unityEvent_.Subscribe(UnityEventType.Update, UnityUpdate);
		}

		private void UnityUpdate()
		{
			if (raycastManager_ != null)
			{
				VoxelRaycastHit rayHit = raycastManager_.VoxelRayCastWrap(model_.selectedItemDistance);
				model_.rayHit = rayHit;
				if (rayHit.success)
				{
					model_.point = rayHit.Point;
					model_.value = rayHit.value;
					model_.rotation = rayHit.rotation;
					model_.globalKey = rayHit.Full;
					model_.rayHitSuccess = voxelEngine_.GetVoxelData(rayHit.value, out model_.data);
					model_.direction = rayHit.Point - raycastManager_.globalPosition;
					model_.direction.Normalize();
				}
				else
				{
					model_.value = 0;
					model_.rayHitSuccess = false;
				}
			}
		}

		public void Dispose()
		{
			unityEvent_.Unsubscribe(UnityEventType.Update, UnityUpdate);
		}
	}
}
