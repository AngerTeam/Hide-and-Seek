using System;
using CraftyEngine.Infrastructure;
using CraftyVoxelEngine;
using Effects;
using PlayerModule.MyPlayer;
using PrimeModule;
using ShopModule;
using SplashesModule;
using UnityEngine;

public class PrimeLoaderController : IDisposable
{
	private GameModel game_;

	private bool keyReady_;

	private LogicVoxelManager logicVoxelManager_;

	private bool mapReady_;

	private PrimeModel model_;

	private ProgressUtility progressUtility_;

	private MapFxController mapFxController_;

	private SplashScreenManager splashScreen_;

	private VoxelEngine voxelEngine_;

	private VoxelLoader voxelLoader_;

	public void Dispose()
	{
		mapFxController_.Dispose();
		progressUtility_.Dispose();
	}

	public void Load()
	{
		SingletonManager.Get<GameModel>(out game_);
		SingletonManager.Get<PrimeModel>(out model_);
		SingletonManager.Get<VoxelLoader>(out voxelLoader_);
		SingletonManager.Get<VoxelEngine>(out voxelEngine_);
		SingletonManager.Get<LogicVoxelManager>(out logicVoxelManager_);
		SingletonManager.Get<SplashScreenManager>(out splashScreen_);
		voxelEngine_.Settings.SetRenderLogicVoxel(false);
		mapReady_ = false;
		keyReady_ = false;
		QueueManager singlton;
		SingletonManager.Get<QueueManager>(out singlton, 2);
		TaskQueue defaultQueue = singlton.DefaultQueue;
		progressUtility_ = new ProgressUtility(2);
		progressUtility_.Progressed += ReportProgressed;
		progressUtility_.AddQueue(defaultQueue);
		logicVoxelManager_.HightestKeyFounded += KeyReady;
		voxelLoader_.LoadMap(model_.mapFile, 2);
		mapFxController_ = new MapFxController();
		mapFxController_.Load(model_.skyboxId, model_.ambientSoundId, model_.useClouds == 1);
		ServerMapSettings rules = model_.GetRules();
		PlayerSkinsManager playerSkinsManager = SingletonManager.Get<PlayerSkinsManager>();
		playerSkinsManager.EnableSkins(NoLockedSkins(rules));
		singlton.AddTask(MapReady);
		progressUtility_.RemoveQueue(defaultQueue);
	}

	public static bool NoLockedSkins(ServerMapSettings mapSettings)
	{
		return mapSettings.skins == null || mapSettings.skins.Length == 0;
	}

	private void KeyReady(VoxelKey key)
	{
		keyReady_ = true;
		logicVoxelManager_.HightestKeyFounded -= KeyReady;
		VoxelKey key2;
		LogicVoxel lvoxel;
		if (logicVoxelManager_.GetRandomVoxel(out key2, out lvoxel))
		{
			game_.SpawnPosition = key2.ToVector() + new Vector3(0.5f, 1.5f, 0.5f);
			game_.Spawnrotation = Vector3.zero;
		}
		else
		{
			game_.SpawnPosition = key.ToVector() + new Vector3(0.5f, 3.5f, 0.5f);
			game_.Spawnrotation = Vector3.zero;
		}
		MyPlayerModuleController singlton;
		SingletonManager.Get<MyPlayerModuleController>(out singlton);
		singlton.ResetPlayerPosition(game_.SpawnPosition, game_.Spawnrotation);
		TryStartGame();
	}

	private void MapReady()
	{
		mapReady_ = true;
		mapFxController_.Start();
		TryStartGame();
	}

	private void ReportProgressed(float progress)
	{
		splashScreen_.SetProgress(progress);
	}

	private void TryStartGame()
	{
		if (mapReady_ && keyReady_)
		{
			game_.levelLoaded = true;
		}
	}
}
