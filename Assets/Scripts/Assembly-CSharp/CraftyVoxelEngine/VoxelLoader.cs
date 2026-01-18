using System;
using System.Collections.Generic;
using CraftyBundles.Content;
using CraftyEngine.Content;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.FileSystem;
using CraftyVoxelEngine.Content;
using Extensions;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class VoxelLoader : PermanentSingleton, IProgressable
	{
		public Material solidMaterial;

		public Material transMaterial;

		private FileHolder bundleFile_;

		private FilesManager filesManager_;

		private ProgressUtility progressUtility_;

		private TaskQueue queue_;

		public Texture2D Atlas { get; set; }

		public byte[] AtlasRawJson { get; set; }

		public VoxelAtlasMetaData AtlasJson2 { get; set; }

		public byte[] ContentRawAmf { get; private set; }

		public List<VoxelModelHolder> Models { get; private set; }

		public float Progress
		{
			get
			{
				return (progressUtility_ != null) ? progressUtility_.Progress : 0f;
			}
		}

		public float Weight { get; set; }

		public event Action<float> Progressed;

		public event Action Loaded;

		public event Action MaterialAttributesChanged;

		public void SetMaterialParameters(float normal, Color sky, Color ambient)
		{
			solidMaterial.SetFloat("_NormalPower", normal);
			solidMaterial.SetColor("_SkyLight", sky);
			solidMaterial.SetColor("_AmbientLight", ambient);
			transMaterial.SetFloat("_NormalPower", normal);
			transMaterial.SetColor("_SkyLight", sky);
			transMaterial.SetColor("_AmbientLight", ambient);
			this.MaterialAttributesChanged.SafeInvoke();
		}

		public override void Init()
		{
			progressUtility_ = new ProgressUtility(Layer);
			Models = new List<VoxelModelHolder>();
			Weight = 10f;
		}

		public void LoadMap(string mapFileUrl, int layer, bool useDefaultHosting = true, bool useCache = true)
		{
			Log.CSVE("VoxelEngine.LoadMap, mapFileURL: {0}, useCache:{1}", mapFileUrl, useCache);
			FilesManager singlton;
			SingletonManager.Get<FilesManager>(out singlton, layer);
			FileHolder mapDataFile = singlton.AddLoadTask(mapFileUrl, FileType.Bytes, null, useDefaultHosting, useCache);
			QueueManager singlton2;
			SingletonManager.Get<QueueManager>(out singlton2, layer);
			singlton2.AddTask(new AssignMapFileTask(mapDataFile));
		}

		public override void OnDataLoaded()
		{
			ContentLoaderModel singleton;
			GetSingleton<ContentLoaderModel>(out singleton);
			GetSingleton<FilesManager>(out filesManager_);
			QueueManager singleton2;
			GetSingleton<QueueManager>(out singleton2);
			queue_ = singleton2.AddUnityThreadQueue();
			queue_.allowSync = false;
			ContentRawAmf = singleton.deployFile.loadedBytes;
			LoadModels();
			LoadAtlas();
			singleton2.AddTask(SaveAtlas, queue_);
			singleton2.AddTask(new AssignContentTask(), queue_);
			singleton2.AddTask(this.Loaded.SafeInvoke, queue_);
		}

		private void LoadAtlas()
		{
			string fullBundlePath = BundlesContentMap.Atlases[6].GetFullBundlePath();
			bundleFile_ = filesManager_.AddLoadBundleTask(fullBundlePath, queue_);
			bundleFile_.fileGetter.Weight = 5f;
			progressUtility_.AddTask(bundleFile_.fileGetter);
		}

		private void LoadModels()
		{
			foreach (VoxelModelsEntries value in VoxelContentMap.VoxelModels.Values)
			{
				if (!string.IsNullOrEmpty(value.filename))
				{
					VoxelModelHolder item = default(VoxelModelHolder);
					string fullnamePath = value.GetFullnamePath();
					item.holder = filesManager_.AddLoadTextTask(fullnamePath, queue_);
					item.Entry = value;
					item.id = (ushort)value.id;
					Models.Add(item);
					progressUtility_.AddTask(item.holder.fileGetter);
				}
			}
		}

		private void SaveAtlas()
		{
			TextAsset textAsset = bundleFile_.loadedAssetBundle.LoadAsset<TextAsset>("meta");
			AtlasRawJson = textAsset.bytes;
			textAsset = bundleFile_.loadedAssetBundle.LoadAsset<TextAsset>("meta2");
			if (textAsset != null)
			{
				AtlasJson2 = JsonUtility.FromJson<VoxelAtlasMetaData>(textAsset.text);
			}
			Atlas = bundleFile_.loadedAssetBundle.LoadAsset<Texture2D>("atlas");
		}
	}
}
