using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;

namespace CraftyEngine.Content
{
	[Serializable]
	public class ContentLoaderModel : Singleton
	{
		public IDictionary<string, object> associativeElements;

		public FileHolder deployFile;

		public string deplyVersion;

		public string lang;

		public bool newVersionDetected;

		public string newVersionUrl;

		public UnityThreadQueue queue;

		public FileHolder versionFile;

		public ContentVersionInfo versionInfo;

		public string rateUrlPath;

		public bool working;

		public bool DeployLoaded
		{
			get
			{
				return Check(deployFile);
			}
		}

		public bool VersionLoaded
		{
			get
			{
				return Check(versionFile);
			}
		}

		public event Action Loaded;

		public event Action NewVersionDetected;

		public void Load()
		{
			working = true;
		}

		public void ReportLoaded()
		{
			working = false;
			Log.Info("Content loaded");
			if (this.Loaded == null)
			{
				Log.Error("Unable to handle content loaded event!");
			}
			else
			{
				this.Loaded();
			}
		}

		public void ReportNewVersion()
		{
			Log.Info("New version detected");
			if (this.NewVersionDetected == null)
			{
				Log.Error("Unable to handle new version detected event!");
			}
			else
			{
				this.NewVersionDetected();
			}
		}

		private bool Check(FileHolder fileHolder)
		{
			return fileHolder != null && fileHolder.fileGetter.State == LoadState.Loaded;
		}
	}
}
