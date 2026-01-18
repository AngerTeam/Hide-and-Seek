using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using CraftyVoxelEngine.Content;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class VoxelDebugDemon : PermanentSingleton
	{
		private const int SIZE = 15;

		private VoxelEngine voxelEngine_;

		private CameraManager cameraManager_;

		private UnityTimerManager unityTimerManager_;

		public override void OnLogicLoaded()
		{
			DebugButtonsManager debugButtonsManager = SingletonManager.Get<DebugButtonsManager>();
			debugButtonsManager.Add("Voxel Demon", KeyCode.F12, AddDemon);
		}

		public override void Init()
		{
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			SingletonManager.Get<UnityTimerManager>(out unityTimerManager_);
			SingletonManager.Get<CameraManager>(out cameraManager_);
		}

		private void AddDemon()
		{
			UnityTimer unityTimer = unityTimerManager_.SetTimer(0.1f);
			unityTimer.repeat = true;
			unityTimer.Completeted += DoSomethingHorrible;
			voxelEngine_.ViewManager.RenderMeshInFrameLimit += 1f;
		}

		private void DoSomethingHorrible()
		{
			if (!(cameraManager_.PlayerCamera == null))
			{
				VoxelKey voxelKey = new VoxelKey(cameraManager_.Transform.position + new Vector3(Random.Range(-15, 15), Random.Range(-15, 15), Random.Range(-15, 15)));
				Voxel voxel;
				voxelEngine_.core.GetVoxel(voxelKey, out voxel);
				ushort num = (ushort)((voxel.Value == 0) ? ((uint)Random.Range(1, VoxelContentMap.Voxels.Count)) : 0u);
				byte rotation = (byte)((num != 0) ? ((uint)Random.Range(0, 24)) : 0u);
				voxelEngine_.voxelActions.SetVoxel(voxelKey, num, rotation);
			}
		}
	}
}
