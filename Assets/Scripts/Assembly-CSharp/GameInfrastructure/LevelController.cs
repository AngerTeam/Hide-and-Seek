using System;
using CraftyEngine.Infrastructure;
using CraftyVoxelEngine;
using MyPlayerInput;
using PlayerModule.MyPlayer;

namespace GameInfrastructure
{
	public class LevelController : IDisposable
	{
		private VoxelEngine voxelEngine_;

		private MyPlayerInputMobule myPlayerInputMobule_;

		private GameModel game_;

		public void Start(bool useDefaultInput)
		{
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			SingletonManager.Get<GameModel>(out game_);
			voxelEngine_.spawned = true;
			CameraManager cameraManager = SingletonManager.Get<CameraManager>();
			cameraManager.Transform.position = game_.SpawnPosition;
			cameraManager.Transform.eulerAngles = game_.Spawnrotation;
			if (useDefaultInput)
			{
				myPlayerInputMobule_ = new MyPlayerInputMobule(game_.SpawnPosition, game_.Spawnrotation);
				return;
			}
			MyPlayerStatsModel myPlayerStatsModel = SingletonManager.Get<MyPlayerStatsModel>();
			myPlayerStatsModel.stats.SetPosition(game_.SpawnPosition, game_.Spawnrotation);
			myPlayerStatsModel.stats.HealthMax = 100;
			myPlayerStatsModel.stats.HealthCurrent = 100;
			myPlayerStatsModel.Enable = true;
			myPlayerStatsModel.input.EnabledByGameState = true;
			myPlayerStatsModel.myVisibility.VisibleBySubstate = true;
		}

		public void Stop()
		{
			MyPlayerStatsModel myPlayerStatsModel = SingletonManager.Get<MyPlayerStatsModel>();
			myPlayerStatsModel.Enable = false;
			myPlayerStatsModel.input.EnabledByGameState = false;
			myPlayerStatsModel.myVisibility.VisibleBySubstate = false;
		}

		public void Dispose()
		{
			if (myPlayerInputMobule_ != null)
			{
				myPlayerInputMobule_.Dispose();
			}
		}
	}
}
