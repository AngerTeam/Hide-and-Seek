using System;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using UnityEngine;

namespace CraftyEngine.Content
{
	public class ContentLoaderController
	{
		private FilesManager filesManager_;

		private ContentLoaderModel model_;

		public ContentLoaderController()
		{
			SingletonManager.Get<ContentLoaderModel>(out model_);
			SingletonManager.Get<FilesManager>(out filesManager_);
			QueueManager singlton;
			SingletonManager.Get<QueueManager>(out singlton);
			model_.queue = singlton.AddUnityThreadQueue();
			PersistanceUserSettings persistanceUserSettings = PersistanceManager.Get<PersistanceUserSettings>();
			if (string.IsNullOrEmpty(persistanceUserSettings.lang))
			{
				persistanceUserSettings.lang = LangMap.lang;
			}
			model_.lang = persistanceUserSettings.lang;
		}

		public void CheckVersion()
		{
			ContentVersionInfo contentVersionInfo = null;
			try
			{
				contentVersionInfo = JsonUtility.FromJson<ContentVersionInfo>(model_.versionFile.loadedText);
				Log.Info("VersionInfo {0}", (contentVersionInfo != null) ? JsonUtility.ToJson(contentVersionInfo, true) : model_.versionFile.loadedText);
				Log.Info("Current version {0}", DataStorage.version);
			}
			catch (Exception context)
			{
				Exc.Report(3302, context);
				return;
			}
			if (contentVersionInfo != null)
			{
				model_.deplyVersion = contentVersionInfo.deploy;
				if (contentVersionInfo.bundle_builds != null)
				{
					Log.Info("Test versions\nPlatform {0}\nBundle Identifier {1}", CompileConstants.PLATFORM, DataStorage.bundleIdentifier);
					ContentBundleInfo[] bundle_builds = contentVersionInfo.bundle_builds;
					foreach (ContentBundleInfo contentBundleInfo in bundle_builds)
					{
						Log.Info("Test version {0}, {1}, {2}", contentBundleInfo.bid, contentBundleInfo.build, contentBundleInfo.build_min);
						if (contentBundleInfo.pf == CompileConstants.PLATFORM && contentBundleInfo.bid == DataStorage.bundleIdentifier)
						{
							model_.rateUrlPath = contentBundleInfo.url;
							if (!string.IsNullOrEmpty(contentBundleInfo.build_min) && !VersionUtil.Compare(DataStorage.version, contentBundleInfo.build_min))
							{
								model_.newVersionUrl = contentBundleInfo.url;
								model_.newVersionDetected = true;
							}
							break;
						}
					}
				}
				model_.versionInfo = contentVersionInfo;
			}
			else
			{
				Exc.Report(3302);
			}
		}

		public void LoadDeploy()
		{
			Log.Info("Content Version: {0}", model_.deplyVersion);
			LogReporterModel.info["deploy_version"] = model_.deplyVersion;
			string settingsUrl = VersionUtil.GetSettingsUrl(model_.deplyVersion, model_.lang);
			model_.deployFile = filesManager_.AddLoadTask(settingsUrl, FileType.AmfArray, model_.queue, true, true, false, null, true);
		}

		public void LoadVersion()
		{
			string text = DateTime.Now.Ticks.ToString();
			model_.versionFile = filesManager_.AddLoadTask("versions.info?t=" + text, FileType.Text, model_.queue, true, false, true);
			model_.versionFile.fileGetter.silent = true;
		}

		public void ReportSuccess()
		{
			model_.associativeElements = model_.deployFile.loadedAmfArray.AssociativeElements;
			model_.ReportLoaded();
		}
	}
}
