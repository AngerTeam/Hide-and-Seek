using System;
using CraftyEngine.Infrastructure;
using CraftyVoxelEngine;
using SplashesModule;
using UnityEngine;

namespace VoxelInventoryModule
{
	public class VoxelEngineTasksObserver : IDisposable
	{
		private VoxelEngine voxelEngine_;

		private float criticalMoment_;

		private UnityEvent unityEvent_;

		public void Start()
		{
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			voxelEngine_.voxelEvents.OutOfRenderingTasks += HandleOutOfTasks;
			criticalMoment_ = Time.unscaledTime + 5f;
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			unityEvent_.Subscribe(UnityEventType.Update, Update);
		}

		private void Update()
		{
			if (Time.unscaledTime > criticalMoment_)
			{
				Log.Info("VoxelEngineTasksObserver :: close by critical delay");
				Dispose();
			}
		}

		private void HandleOutOfTasks(MessageOutOfRenderingTasks obj)
		{
			Log.Info("VoxelEngineTasksObserver :: close by tasks");
			Dispose();
		}

		public void Dispose()
		{
			SingletonManager.Get<SplashScreenManager>().HideScreen();
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			voxelEngine_.voxelEvents.OutOfRenderingTasks -= HandleOutOfTasks;
		}
	}
}
