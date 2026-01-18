using System;
using System.IO;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using CraftyVoxelEngine.Editor;
using Extensions;

namespace CraftyVoxelEngine
{
	public class VoxelFilesManager
	{
		public readonly string mapExtension = "mcm";

		public readonly string boxExtension = "mcb";

		public string basePath;

		public string boxesPath;

		public string mapsPath;

		public string boxesFolder = "VoxelBoxes";

		public string mapsFolder = "VoxelMaps";

		public string lastMapName = "NewMap.mcm";

		public string lastBoxName = "NewBox.mcb";

		private VoxelEditorLoadSaveWindow loadSaveWindow_;

		private VoxelEngine voxelEngine_;

		private VoxelEditorModel model_;

		private UnityTimer autosaveTimer_;

		public VoxelBoxHolder holder;

		public event Action<string> MapLoaded;

		public event Action<string> MapSaved;

		public event Action<string> BoxLoaded;

		public event Action<string> BoxSaved;

		public event Action BeginSaving;

		public VoxelFilesManager()
		{
			SingletonManager.Get<VoxelEditorModel>(out model_);
			basePath = PersistanceManager.filesDirectory;
			mapsPath = Path.Combine(basePath, mapsFolder);
			boxesPath = Path.Combine(basePath, boxesFolder);
			Directory.CreateDirectory(mapsPath);
			Directory.CreateDirectory(boxesPath);
			loadSaveWindow_ = new VoxelEditorLoadSaveWindow();
			loadSaveWindow_.Hide();
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
		}

		public void StartAutosave()
		{
			UnityTimerManager singlton;
			SingletonManager.Get<UnityTimerManager>(out singlton);
			autosaveTimer_ = singlton.SetTimer(model_.autosaveDelay);
			autosaveTimer_.repeat = true;
			autosaveTimer_.Completeted += Autosave;
		}

		public void StopAutosave()
		{
			autosaveTimer_.Stop();
		}

		private void Autosave()
		{
			SaveMap(null, true);
		}

		public void LoadMapDialog()
		{
			LoadFileDialog(mapsPath, LoadMap);
		}

		public void SaveMapDialog()
		{
			SaveFileDialog(mapsPath, SaveMap, lastMapName);
		}

		public void LoadBoxDialog(VoxelBoxHolder boxHolder)
		{
			holder = boxHolder;
			LoadFileDialog(boxesPath, LoadVoxelBox);
		}

		public void SaveBoxDialog(VoxelBoxHolder boxHolder)
		{
			holder = boxHolder;
			SaveFileDialog(boxesPath, SaveVoxelBox, "NewBox.mcb");
		}

		public void LoadFileDialog(string path, Action<string> action)
		{
			string[] files = Directory.GetFiles(path);
			if (files.Length > 0)
			{
				loadSaveWindow_.SetItems(files);
				loadSaveWindow_.load -= action;
				loadSaveWindow_.load += action;
				loadSaveWindow_.ShowLoad();
			}
			else
			{
				loadSaveWindow_.ShowInfo("No files founded, check folder:\n" + path);
			}
		}

		public void SaveFileDialog(string path, Action<string> action, string name = "NewFile")
		{
			loadSaveWindow_.save -= action;
			loadSaveWindow_.save += action;
			loadSaveWindow_.ShowSave(name);
		}

		public void LoadMap(string mapPath)
		{
			LoadMap(mapPath, true);
		}

		public void LoadMap(string mapPath, bool useCache)
		{
			Log.Info("LoadMap(\"{0}\")", mapPath);
			loadSaveWindow_.load -= LoadMap;
			VoxelLoader singlton;
			SingletonManager.Get<VoxelLoader>(out singlton);
			VoxelLoader voxelLoader = singlton;
			bool useCache2 = useCache;
			voxelLoader.LoadMap(mapPath, 2, true, useCache2);
			lastMapName = Path.GetFileName(mapPath);
			QueueManager singlton2;
			SingletonManager.Get<QueueManager>(out singlton2, 2);
			if (this.MapLoaded != null)
			{
				singlton2.AddTask(delegate
				{
					this.MapLoaded(mapPath);
				});
			}
		}

		public void SaveMap(string mapName = null)
		{
			SaveMap(mapName, false);
		}

		public void SaveMap(string mapName, bool autosave)
		{
			this.BeginSaving.SafeInvoke();
			loadSaveWindow_.save -= SaveMap;
			bool flag = false;
			if (string.IsNullOrEmpty(mapName))
			{
				flag = true;
				mapName = ContentStandart.GetTimeStamp();
			}
			else
			{
				lastMapName = mapName;
			}
			mapName = ValidExtensiom(mapName, mapExtension);
			string text = Path.Combine((!flag) ? mapsPath : basePath, mapName);
			Log.Info("SaveMap(\"{0}\")", text);
			voxelEngine_.Manager.SetSavePath(text, text.Length);
			Log.Info("MapSaved.SafeInvoke(\"{0}\")", mapName);
			voxelEngine_.voxelActions.SaveMapToFile(delegate
			{
				this.MapSaved.SafeInvoke(mapName);
			});
		}

		public void LoadVoxelBox(string filename)
		{
			loadSaveWindow_.load -= LoadVoxelBox;
			filename = Path.Combine(boxesPath, filename);
			try
			{
				byte[] data = File.ReadAllBytes(filename);
				holder.Deserialize(data);
			}
			catch
			{
			}
			this.BoxLoaded.SafeInvoke(filename);
		}

		public void SaveVoxelBox(string filename)
		{
			this.BeginSaving.SafeInvoke();
			loadSaveWindow_.save -= SaveVoxelBox;
			filename = ValidExtensiom(filename, boxExtension);
			lastBoxName = filename;
			filename = Path.Combine(boxesPath, filename);
			try
			{
				byte[] bytes = holder.Serialize();
				File.WriteAllBytes(filename, bytes);
			}
			catch
			{
			}
			this.BoxSaved.SafeInvoke(filename);
		}

		private string ValidExtensiom(string name, string extension)
		{
			if (!name.EndsWith(extension))
			{
				name = string.Format("{0}.{1}", name, extension);
			}
			return name;
		}
	}
}
