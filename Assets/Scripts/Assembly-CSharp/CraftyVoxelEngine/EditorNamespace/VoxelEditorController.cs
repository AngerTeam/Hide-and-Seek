using System;
using System.Collections.Generic;
using CraftyVoxelEngine.Content;
using Extensions;
using InventoryModule;
using MyPlayerInput;
using PlayerModule.MyPlayer;
using SplashesModule;
using UnityEngine;
using WindowsModule;

namespace CraftyVoxelEngine.Editor
{
	public class VoxelEditorController : IDisposable
	{
		private GameModel game_;

		private VoxelEditorModel model_;

		private VoxelEngine voxelEngine_;

		private DialogWindowManager dialogManager_;

		private VoxelInteraction voxelInteraction_;

		private RaycastManager raycastManager_;

		private MyPlayerInputModel myPlayerInputModel_;

		private LogicVoxelManager logicVoxelManager_;

		public VoxelFilesManager voxelFilesManager;

		public VoxelEditorSpawnsValidator validator;

		private bool exitAfterSave_;

		private bool mapReady_;

		private bool keyReady_;

		public event Action Completed;

		public event Action<int> PippetEvent;

		public void Init()
		{
			SingletonManager.Get<GameModel>(out game_);
			SingletonManager.Get<VoxelEditorModel>(out model_);
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			SingletonManager.Get<VoxelInteraction>(out voxelInteraction_);
			SingletonManager.Get<RaycastManager>(out raycastManager_);
			SingletonManager.Get<MyPlayerInputModel>(out myPlayerInputModel_);
			SingletonManager.Get<LogicVoxelManager>(out logicVoxelManager_);
			logicVoxelManager_.HightestKeyFounded += KeyReady;
			voxelInteraction_.model.isCreativeMode = true;
			voxelInteraction_.model.inputEnabled = false;
			float editorDigCooldown = VoxelContentMap.VoxelSettings.editorDigCooldown;
			voxelInteraction_.input.SetDamage(100000, editorDigCooldown);
			raycastManager_.distance = 30f;
			voxelFilesManager.MapSaved += InvokeMapSavedEvent;
			voxelFilesManager.StartAutosave();
			myPlayerInputModel_.flight = true;
			myPlayerInputModel_.clipping = true;
			mapReady_ = false;
			keyReady_ = false;
		}

		public void Dispose()
		{
			voxelInteraction_.input.SetDefaultDamage();
			myPlayerInputModel_.flight = false;
			myPlayerInputModel_.clipping = true;
			voxelFilesManager.MapSaved -= InvokeMapSavedEvent;
			voxelFilesManager.StopAutosave();
			voxelInteraction_.model.isCreativeMode = false;
		}

		public bool ToggleFlyMode()
		{
			return myPlayerInputModel_.flight = !myPlayerInputModel_.flight;
		}

		public bool ToggleClipMode()
		{
			return myPlayerInputModel_.clipping = !myPlayerInputModel_.clipping;
		}

		public void Pippet()
		{
			Voxel voxel;
			if (!voxelEngine_.core.GetVoxel(voxelInteraction_.model.globalKey, out voxel))
			{
				return;
			}
			int param = 0;
			foreach (KeyValuePair<int, ArtikulsEntries> artikul in InventoryContentMap.Artikuls)
			{
				ArtikulsEntries value = artikul.Value;
				if (value.voxel_id == voxel.Value)
				{
					param = value.id;
					break;
				}
			}
			this.PippetEvent.SafeInvoke(param);
		}

		public void Teleport()
		{
		}

		public void Save()
		{
			voxelFilesManager.SaveMap();
		}

		public void Exit()
		{
			exitAfterSave_ = false;
			SingletonManager.Get<DialogWindowManager>(out dialogManager_);
			dialogManager_.ShowDialogue(validator.GetExitMessage(), SaveEndExit);
		}

		public void SaveEndExit()
		{
			voxelFilesManager.SaveMap(voxelFilesManager.lastMapName);
			exitAfterSave_ = true;
		}

		public void InvokeMapSavedEvent(string file = null)
		{
			if (string.IsNullOrEmpty(file))
			{
				file = voxelFilesManager.lastMapName;
			}
			validator.ValidateSpawns();
			model_.SavedMap = file;
			if (exitAfterSave_)
			{
				this.Completed.SafeInvoke();
			}
		}

		public void InvokeCompleted()
		{
			this.Completed.SafeInvoke();
		}

		public void LoadMap(string path)
		{
			voxelFilesManager.MapLoaded += MapReady;
			voxelFilesManager.LoadMap(path, true);
		}

		public void LoadMap()
		{
			mapReady_ = false;
			keyReady_ = false;
			if (model_.mapPath == null)
			{
				SplashScreenManager splashScreenManager = SingletonManager.Get<SplashScreenManager>();
				splashScreenManager.HideScreen();
				voxelFilesManager.MapLoaded += MapReady;
				voxelFilesManager.LoadMapDialog();
			}
			else
			{
				voxelFilesManager.MapLoaded += MapReady;
				voxelFilesManager.LoadMap(model_.mapPath, model_.useCache);
			}
		}

		private void MapReady(string file)
		{
			voxelFilesManager.MapLoaded -= MapReady;
			mapReady_ = true;
			TryStartGame();
		}

		private void KeyReady(VoxelKey key)
		{
			keyReady_ = true;
			logicVoxelManager_.HightestKeyFounded -= KeyReady;
			VoxelKey key2;
			LogicVoxel lvoxel;
			if (model_.playerPosValid)
			{
				game_.SpawnPosition = model_.playerPosition;
				game_.Spawnrotation = model_.playerRotation;
			}
			else if (logicVoxelManager_.GetRandomVoxel(out key2, out lvoxel))
			{
				game_.SpawnPosition = key2.ToVector() + new Vector3(0.5f, 1.5f, 0.5f);
				game_.Spawnrotation = Vector3.zero;
			}
			else
			{
				game_.SpawnPosition = key.ToVector() + new Vector3(0.5f, 1.5f, 0.5f);
				game_.Spawnrotation = Vector3.zero;
			}
			MyPlayerModuleController singlton;
			SingletonManager.Get<MyPlayerModuleController>(out singlton);
			singlton.ResetPlayerPosition(game_.SpawnPosition, game_.Spawnrotation);
			TryStartGame();
		}

		private void TryStartGame()
		{
			if (mapReady_ && keyReady_)
			{
				game_.levelLoaded = true;
				mapReady_ = false;
				keyReady_ = false;
			}
		}
	}
}
