using ChestsViewModule;
using CraftyEngine.Content;
using CraftyEngine.Infrastructure;
using CraftyEngine.Sounds;
using CraftyGameEngine.Gui;
using CraftyGameEngine.Player;
using CraftyVoxelEngine;
using Effects;
using HudSystem;
using PlayerModule.MyPlayer;
using SelectModeModule;
using UnityEngine;
using VoxelInventoryModule;
using WindowsModule;

namespace HomeLobby
{
	public class HomeLobbyController : Singleton
	{
		private ActorRotator actorRotator_;

		private LobbyCameraShaker cameraShaker_;

		private MyPlayerModuleController controller_;

		private LobbyHud lobbyHud_;

		private MyPlayerStatsModel model_;

		private VoxelEngine voxelEngine_;

		private MapFxController mapFxController_;

		private GameModel gameModel_;

		public override void Dispose()
		{
			model_.stats.visibility.ByCameraMode = false;
			model_.stats.IsCocky = false;
			cameraShaker_.Dispose();
			actorRotator_.Dispose();
			mapFxController_.Dispose();
			model_.stats.visual.Transform.localScale = Vector3.one;
			controller_.PlaymateEntity.Controller.BodyViewUpdated -= HandleBodyViewUpdated;
			GuiModuleHolder.Remove<LobbyHud>();
		}

		public void Start(string mapFilePath)
		{
			ContentDeserializer.Deserialize<HomeLobbyMap>();
			VoxelLoader singlton;
			SingletonManager.Get<VoxelLoader>(out singlton);
			singlton.LoadMap(mapFilePath, 2);
			QueueManager singlton2;
			SingletonManager.Get<QueueManager>(out singlton2, 2);
			singlton2.AddTask(LoadFx);
			singlton2.AddTask(Load);
			SoundProvider.SoundAmbient(47);
		}

		private void LoadFx()
		{
			mapFxController_ = new MapFxController();
			mapFxController_.Load(1, 0, true);
		}

		private void CheckEmptyRewarsSlots()
		{
			ChestsManagerBase.CheckEmptyRewardChestsSlots(OpenSelectPvpModeWindow);
		}

		private void HandleBodyViewUpdated()
		{
			if (model_.stats.visual.Transform != null)
			{
				model_.stats.visual.Transform.localScale = Vector3.one * 2f;
			}
		}

		private void Load()
		{
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			SingletonManager.Get<MyPlayerStatsModel>(out model_);
			SingletonManager.Get<GameModel>(out gameModel_);
			cameraShaker_ = new LobbyCameraShaker();
			Vector3 vector = Vector3Utils.SafeParse(HomeLobbyMap.HomeLobbySettings.playerInLobbyPosition);
			model_.stats.SetPosition(vector, Vector3.zero);
			model_.stats.HealthMax = 100;
			model_.stats.HealthCurrent = 100;
			model_.stats.visibility.ByGameLogic = true;
			model_.stats.visibility.ByCameraMode = true;
			model_.stats.IsCocky = true;
			model_.input.EnabledByGameState = false;
			SingletonManager.Get<MyPlayerModuleController>(out controller_);
			controller_.PlaymateEntity.Controller.BodyViewUpdated += HandleBodyViewUpdated;
			HandleBodyViewUpdated();
			controller_.PlaymateEntity.Controller.LoadBody();
			if (actorRotator_ == null)
			{
				actorRotator_ = new ActorRotator(model_.stats);
			}
			if (lobbyHud_ == null)
			{
				lobbyHud_ = GuiModuleHolder.Add<LobbyHud>();
				lobbyHud_.ToArsenalButtonClicked += OnArsenalButtonClicked;
				lobbyHud_.ToPvpButtonClicked += OnPvpButtonClicked;
			}
			Vector3 amplitude = Vector3Utils.SafeParse(HomeLobbyMap.HomeLobbySettings.lobbyCameraTweenAmplitude);
			cameraShaker_.PlaceCameraCenter(vector, amplitude, HomeLobbyMap.HomeLobbySettings.lobbyCameraTweenDuration);
			VoxelEngineTasksObserver voxelEngineTasksObserver = new VoxelEngineTasksObserver();
			voxelEngineTasksObserver.Start();
			gameModel_.SpawnPosition = vector;
			voxelEngine_.spawned = true;
			mapFxController_.Start();
		}

		private void OnArsenalButtonClicked()
		{
			WindowsManagerShortcut.ToggleWindow<IShop>();
		}

		private void OnPvpButtonClicked()
		{
			CheckEmptyRewarsSlots();
		}

		private void OpenSelectPvpModeWindow()
		{
			WindowsManagerShortcut.ToggleWindow<SelectModeWindow>();
		}
	}
}
