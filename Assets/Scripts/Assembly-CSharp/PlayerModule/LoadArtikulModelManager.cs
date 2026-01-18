using System;
using ArticulView;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;

namespace PlayerModule
{
	public class LoadArtikulModelManager : Singleton
	{
		private FilesManager filesManager_;

		private QueueManager queueManager_;

		public override void Init()
		{
			GetSingleton<FilesManager>(out filesManager_);
			GetSingleton<QueueManager>(out queueManager_);
		}

		public void GetModel(out FileHolder fileHolder, int modelId, Action callback = null)
		{
			fileHolder = null;
			ArtikulModelsEntries value;
			if (ArticulViewContentMap.ArtikulModels.TryGetValue(modelId, out value))
			{
				fileHolder = filesManager_.AddLoadBundleTask(value.GetFullBundlePath());
			}
			if (callback != null)
			{
				queueManager_.AddTask(callback);
			}
		}
	}
}
