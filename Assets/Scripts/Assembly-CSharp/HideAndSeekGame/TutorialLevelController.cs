using CraftyEngine.Infrastructure;
using CraftyVoxelEngine;
using PlayerModule.MyPlayer;
using Prompts;
using ShapesModule;
using TutorialModule;
using UnityEngine;
using VoxelInventoryModule;

namespace HideAndSeekGame
{
	public class TutorialLevelController
	{
		private VoxelEngine voxelEngine_;

		private MyPlayerStatsModel myPlayerStatsModel_;

		private PromptsManager promptsManager_;

		private MyPlayerModuleController myPlayerModule_;

		private UnityEvent unityEvent_;

		private TutorialManager tutorialManager_;

		private TutorialShapeManager tutorialShapeManager_;

		private LocationsEntries location_;

		public void Start()
		{
			SingletonManager.Get<PromptsManager>(out promptsManager_);
			location_ = HideAndSeekGameMap.Locations[PromptsMap.Tutorial.TUTORIAL_LEVEL_ID];
			VoxelLoader singlton;
			SingletonManager.Get<VoxelLoader>(out singlton);
			singlton.LoadMap(location_.GetFullMapPath(), 2);
			QueueManager singlton2;
			SingletonManager.Get<QueueManager>(out singlton2, 2);
			singlton2.AddTask(Load);
		}

		private void Load()
		{
			int tUTORIAL_LEVEL_ID = PromptsMap.Tutorial.TUTORIAL_LEVEL_ID;
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			SingletonManager.Get<MyPlayerModuleController>(out myPlayerModule_);
			SingletonManager.Get<TutorialShapeManager>(out tutorialShapeManager_);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			Vector3 position = Vector3Utils.SafeParse(location_.spawn_position);
			Vector3 vector = Vector3Utils.SafeParse(location_.spawn_rotation);
			CameraManager cameraManager = SingletonManager.Get<CameraManager>();
			cameraManager.Transform.position = position;
			cameraManager.Transform.eulerAngles = vector;
			myPlayerModule_.ResetPlayerPosition(position, vector);
			myPlayerStatsModel_.myVisibility.VisibleBySubstate = true;
			myPlayerStatsModel_.Enable = true;
			myPlayerStatsModel_.input.EnabledByGameState = true;
			promptsManager_.view.LoadModel();
			promptsManager_.HandleLevelStarted(tUTORIAL_LEVEL_ID);
			tutorialShapeManager_.Start();
			tutorialManager_ = TutorialManager.Init(tUTORIAL_LEVEL_ID);
			unityEvent_.Subscribe(UnityEventType.Update, UnityUpdate);
			voxelEngine_.spawned = true;
			VoxelEngineTasksObserver voxelEngineTasksObserver = new VoxelEngineTasksObserver();
			voxelEngineTasksObserver.Start();
		}

		private void UnityUpdate()
		{
			if (myPlayerStatsModel_ != null && voxelEngine_ != null)
			{
				voxelEngine_.TestTriggerRegion(myPlayerStatsModel_.stats.Position);
			}
		}

		public void Quit()
		{
			myPlayerStatsModel_.Enable = false;
			myPlayerStatsModel_.input.EnabledByGameState = false;
			myPlayerStatsModel_.myVisibility.VisibleBySubstate = false;
			unityEvent_.Unsubscribe(UnityEventType.Update, UnityUpdate);
			tutorialManager_.Terminate();
		}
	}
}
