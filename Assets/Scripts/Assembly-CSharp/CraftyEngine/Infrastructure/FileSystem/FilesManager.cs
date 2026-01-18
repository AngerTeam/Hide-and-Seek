using System;
using System.Collections.Generic;
using System.IO;
using System.Threading;
using CraftyEngine.Content;
using UnityEngine;

namespace CraftyEngine.Infrastructure.FileSystem
{
	public class FilesManager : Singleton
	{
		public string defaultHosting;

		public OfflineContentSettings offlineContentSettings;

		private string cacheFolder_;

		private QueueManager queueManager_;

		private Dictionary<string, FileHolder> files_;

		private LegacyPermanentFilesManager legacyPermanentFilesManager_;

		public static FilesManager Current
		{
			get
			{
				return SingletonManager.Get<FilesManager>(2);
			}
		}

		public override void Init()
		{
			GetSingleton<QueueManager>(out queueManager_);
			files_ = new Dictionary<string, FileHolder>();
			if (Layer == 2)
			{
				SingletonManager.Get<LegacyPermanentFilesManager>(out legacyPermanentFilesManager_);
				legacyPermanentFilesManager_.TransferNonPermanentFiles(files_);
				foreach (FileHolder value in files_.Values)
				{
					if (value.fileGetter.State == LoadState.Idle)
					{
						queueManager_.AddTask(value.fileGetter);
					}
					else if (value.fileGetter.State == LoadState.Stopped)
					{
						value.fileGetter.ReSubscribe();
					}
				}
			}
			string path;
			if (!CompileConstants.EDITOR)
			{
				path = ((!CompileConstants.MOBILE) ? Application.dataPath : Application.persistentDataPath);
			}
			else
			{
				path = Application.dataPath;
				path = Directory.GetParent(path).FullName;
			}
			Log.Info("[FilesManager]: streaming assets folder: {0}", Application.streamingAssetsPath);
			offlineContentSettings = OfflineContentSettings.Get();
			cacheFolder_ = Path.Combine(path, "cache");
			if (!Directory.Exists(cacheFolder_))
			{
				Directory.CreateDirectory(cacheFolder_);
			}
			Log.Info("[FilesManager]: cache folder {0}", cacheFolder_);
		}

		public FileHolder AddLoadAmfObjectTask(string fileUrl, TaskQueue queue = null, bool useDefaultHosting = true, bool useCache = true)
		{
			return AddLoadTask(fileUrl, FileType.AmfObject, queue, useDefaultHosting, useCache);
		}

		public FileHolder AddLoadAmfArrayTask(string fileUrl, TaskQueue queue = null, bool useDefaultHosting = true, bool useCache = true)
		{
			return AddLoadTask(fileUrl, FileType.AmfArray, queue, useDefaultHosting, useCache);
		}

		public FileHolder AddLoadTextTask(string fileUrl, TaskQueue queue = null, bool useDefaultHosting = true, bool useCache = true, bool forceRemote = false)
		{
			return AddLoadTask(fileUrl, FileType.Text, queue, useDefaultHosting, useCache, forceRemote);
		}

		public FileHolder AddLoadBundleTask(string fileUrl, Action<FileHolder> callback)
		{
			return AddLoadTask(fileUrl, FileType.UncompressedBundle, null, true, true, false, null, false, null, callback);
		}

		public FileHolder AddLoadBundleTask(string fileUrl, Action callback)
		{
			return AddLoadTask(fileUrl, FileType.UncompressedBundle, null, true, true, false, null, false, callback);
		}

		public FileHolder AddLoadBundleTask(string fileUrl, TaskQueue queue = null, bool useDefaultHosting = true, bool useCache = true)
		{
			return AddLoadTask(fileUrl, FileType.UncompressedBundle, queue, useDefaultHosting, useCache);
		}

		public FileHolder AddLoadAudioTask(string fileUrl, TaskQueue queue = null, bool useDefaultHosting = true, bool useCache = true)
		{
			return AddLoadTask(fileUrl, FileType.Audio, queue, useDefaultHosting, useCache);
		}

		public FileHolder AddLoadTask(string fileUrl, FileType fileType, TaskQueue queue = null, bool useDefaultHosting = true, bool useCache = true, bool forceRemote = false, WWWForm form = null, bool saveBytes = false, Action parameterlessCallback = null, Action<FileHolder> callback = null)
		{
			if (string.IsNullOrEmpty(fileUrl))
			{
				throw new ArgumentNullException("fileUrl");
			}
			if (files_ == null)
			{
				return null;
			}
			FileHolder result = null;
			bool flag = false;
			if (!forceRemote)
			{
				result = GetFromMemory(fileUrl);
				if (result == null)
				{
					result = GetFromStreamingAssets(fileUrl, fileType, queue, saveBytes);
				}
				else
				{
					flag = true;
				}
				if (result == null && useCache && useDefaultHosting)
				{
					string text = Path.Combine(cacheFolder_, fileUrl);
					if (File.Exists(text))
					{
						result = GetLocalFile(fileUrl, fileType, text, queue, saveBytes);
					}
				}
			}
			if (result == null)
			{
				string remoteUrl = fileUrl;
				if (useDefaultHosting)
				{
					remoteUrl = defaultHosting + fileUrl;
				}
				result = GetRemoteFile(fileUrl, fileType, remoteUrl, queue, useCache, true, form, saveBytes);
			}
			if (Extended.log)
			{
				Log.Info((!flag) ? "[FilesManager]: Add load task {0} in layer {1}" : "[FilesManager]: Get from memory {0} in layer {1}", fileUrl, Layer);
			}
			result.fileGetter.originalUrl = fileUrl;
			if (callback != null)
			{
				queueManager_.AddTask(delegate
				{
					callback(result);
				});
			}
			if (parameterlessCallback != null)
			{
				queueManager_.AddTask(parameterlessCallback);
			}
			return result;
		}

		private FileHolder GetFromStreamingAssets(string fileUrl, FileType fileType, TaskQueue queue, bool saveBytes)
		{
			if (offlineContentSettings != null)
			{
				string[] paths = offlineContentSettings.paths;
				foreach (string text in paths)
				{
					if (!(text == fileUrl))
					{
						continue;
					}
					string text2 = Path.Combine(Application.streamingAssetsPath, fileUrl);
					if (CompileConstants.ANDROID && !CompileConstants.EDITOR)
					{
						bool saveBytes2 = saveBytes;
						FileHolder remoteFile = GetRemoteFile(fileUrl, fileType, text2, queue, false, true, null, saveBytes2);
						if (remoteFile != null)
						{
							return remoteFile;
						}
					}
					else if (File.Exists(text2))
					{
						return GetLocalFile(fileUrl, fileType, text2, queue, saveBytes);
					}
				}
			}
			return null;
		}

		private FileHolder GetFromMemory(string fileUrl)
		{
			if (files_.ContainsKey(fileUrl))
			{
				return files_[fileUrl];
			}
			if (legacyPermanentFilesManager_ != null && legacyPermanentFilesManager_.files.ContainsKey(fileUrl))
			{
				return legacyPermanentFilesManager_.files[fileUrl];
			}
			if (CompileConstants.EDITOR && fileUrl.Contains("#"))
			{
				EditorContentInfiltrationController singlton;
				SingletonManager.Get<EditorContentInfiltrationController>(out singlton);
				UnityEngine.Object obj;
				string meta;
				if (singlton.TryGetUnityObject(fileUrl, out obj, out meta))
				{
					FileHolder fileHolder = new FileHolder(FileType.UncompressedBundle);
					fileHolder.bundle = obj;
					fileHolder.meta = meta;
					fileHolder.fileGetter = new EditorLoadFileTask(-1);
					files_[fileUrl] = fileHolder;
					return fileHolder;
				}
			}
			return null;
		}

		private FileHolder GetLocalFile(string fileUrl, FileType fileType, string filename, TaskQueue queue = null, bool saveBytes = false)
		{
			LoadFileLocalTask loadFileLocalTask = new LoadFileLocalTask(filename, fileType, Layer);
			loadFileLocalTask.File.saveBytes = saveBytes;
			queueManager_.AddTask(loadFileLocalTask, queue);
			files_.Add(fileUrl, loadFileLocalTask.File);
			return loadFileLocalTask.File;
		}

		private FileHolder GetRemoteFile(string fileUrl, FileType fileType, string remoteUrl, TaskQueue queue = null, bool useCache = true, bool saveInMemory = true, WWWForm form = null, bool saveBytes = false)
		{
			LoadFileTask loadFileTask = InitLoadFileTask(remoteUrl, fileType, queue, useCache, form, saveBytes);
			if (loadFileTask != null)
			{
				if (saveInMemory)
				{
					files_.Add(fileUrl, loadFileTask.File);
				}
				return loadFileTask.File;
			}
			return null;
		}

		public virtual LoadFileTask InitLoadFileTask(string fileUrl, FileType fileType, TaskQueue queue, bool useCache = true, WWWForm form = null, bool saveBytes = false)
		{
			LoadFileTask loadFileTask = new LoadFileWWWTask(fileUrl, fileType, true, Layer, useCache, form);
			loadFileTask.File.saveBytes = saveBytes;
			if (useCache)
			{
				loadFileTask.Completed += SaveFileToCache;
			}
			queueManager_.AddTask(loadFileTask, queue);
			return loadFileTask;
		}

		private void SaveFileToCache(object sender, EventArgs e)
		{
			LoadFileWWWTask task = (LoadFileWWWTask)sender;
			if (!task.Address.Contains(defaultHosting))
			{
				return;
			}
			string filename = task.Address.Replace(defaultHosting, string.Empty);
			filename = Path.Combine(cacheFolder_, filename);
			if (task.File.bytesForCache == null || task.File.bytesForCache.Length <= 0)
			{
				return;
			}
			if (Extended.log)
			{
				Log.Info("[FilesManager]: Save to cache {0}", filename);
			}
			ThreadPool.QueueUserWorkItem(delegate
			{
				try
				{
					Directory.CreateDirectory(Path.GetDirectoryName(filename));
					File.WriteAllBytes(filename, task.File.bytesForCache);
				}
				catch (Exception exc)
				{
					Log.Exception(exc);
				}
			});
		}

		public override void Dispose()
		{
			if (files_ == null)
			{
				return;
			}
			foreach (FileHolder value in files_.Values)
			{
				if (legacyPermanentFilesManager_ != null && value.fileGetter.State == LoadState.Loading)
				{
					if (legacyPermanentFilesManager_.files.ContainsKey(value.fileGetter.originalUrl))
					{
						Log.Error("[FilesManager]: permanentFilesManager already contains {0}", value.fileGetter.originalUrl);
						continue;
					}
					legacyPermanentFilesManager_.files.Add(value.fileGetter.originalUrl, value);
					if (Extended.log)
					{
						Log.Info("[FilesManager]: Transfer {0} to permanentFilesManager", value.fileGetter.originalUrl);
					}
				}
				else
				{
					if (Extended.log)
					{
						Log.Info("[FilesManager]: Unload {0}", value.fileGetter.originalUrl);
					}
					value.Dispose();
				}
			}
			files_.Clear();
			files_ = null;
		}

		public void Unload(FileHolder file)
		{
			file.fileGetter.UnsubscribeAll();
			if (files_.ContainsKey(file.fileGetter.originalUrl))
			{
				if (Extended.log)
				{
					Log.Info("[FilesManager]: Unload {0}", file.fileGetter.originalUrl);
				}
				files_.Remove(file.fileGetter.originalUrl);
			}
			else
			{
				Log.Error("[FilesManager]: Unable to unload {0}", file.fileGetter.originalUrl);
			}
			if (file.loadedAssetBundle != null)
			{
				file.loadedAssetBundle.Unload(true);
				file.loadedAssetBundle = null;
			}
			file.loadedTexture = null;
			file.fileGetter.Unload();
		}
	}
}
