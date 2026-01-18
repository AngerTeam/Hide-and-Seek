using CraftyEngine.Infrastructure;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class WaitForVoxelTreadTask : AsynchronousTask
	{
		private VoxelCore core_;

		private UnityEventComponent unityEvent_;

		public WaitForVoxelTreadTask(VoxelCore core)
		{
			core_ = core;
		}

		public override void Start()
		{
			GameObject gameObject = new GameObject();
			if (Application.isPlaying)
			{
				Object.DontDestroyOnLoad(gameObject);
			}
			unityEvent_ = gameObject.AddComponent<UnityEventComponent>();
			unityEvent_.NullEvent += TestCoreAndDestroy;
		}

		public void TestCoreAndDestroy(UnityEventType type)
		{
			if (core_.isFinished)
			{
				core_.Dispose();
				Object.Destroy(unityEvent_.gameObject);
				Complete();
			}
		}
	}
}
