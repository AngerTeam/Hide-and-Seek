using System;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;

namespace Animations
{
	public class AnimationsFileManager : Singleton
	{
		protected FilesManager filesManager;

		protected QueueManager queueManager;

		public override void Init()
		{
			GetSingleton<FilesManager>(out filesManager);
			GetSingleton<QueueManager>(out queueManager);
		}

		public void GetAnimation(out FileHolder fileHolder, int animationId, bool split, Action<FileHolder> callback = null)
		{
			fileHolder = null;
			AnimationsEntries value;
			if (AnimationsContentMap.Animations != null && AnimationsContentMap.Animations.TryGetValue(animationId, out value))
			{
				string fileUrl = ((!split || string.IsNullOrEmpty(value.bundle_split)) ? value.GetFullBundlePath() : value.GetFullBundleSplitPath());
				fileHolder = filesManager.AddLoadBundleTask(fileUrl, callback);
			}
		}
	}
}
