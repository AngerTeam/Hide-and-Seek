using CraftyBundles.Content;
using CraftyEngine.Content;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.SingletonManagerCore;
using CraftyVoxelEngine;
using HudSystem;
using MyPlayerInput;
using NguiTools;
using PopUpModule;
using SplashesModule;
using UpdateModule;

namespace GameInfrastructure
{
	public class InfrastructureContoller
	{
		private GameModel model_;

		private QueueManager queueManagerPermanent_;

		public void InitPermanentBasicSystem(int layer)
		{
			SingletonManager.Add<BundlesContentDeserializer>(layer);
			SingletonManager.AddAlias<PrefabsManagerNGUI, PrefabsManager>(layer);
			SingletonManager.Add<NguiManager>(layer);
			SingletonManager.Add<NguiFileManager>(layer);
			SingletonManager.Add<SplashScreenManager>(layer);
			SingletonManager.InitiatePhase(SingletonPhase.Init, layer);
			model_.minmalDataLoaded = true;
		}

		public void InitEternalSystem()
		{
			SingletonManager.Get<GameModel>(out model_);
			if (!model_.minmalDataLoaded)
			{
				RuntimePersistanceManager.Init();
				Localisations.Init();
				SingletonManager.InitiatePhase(SingletonPhase.Init, 0);
			}
		}

		public void InitPermanentAdvancedSystem<T>() where T : CameraManager, new()
		{
			if (!model_.permanentDataLoaded)
			{
				int layer = 1;
				SingletonManager.AddAlias<UnityEventRuntimeConductor, UnityEvent>(layer);
				ContentLoaderEntity.InitModule(layer);
				SingletonManager.Add<UpdateManager>(layer);
				queueManagerPermanent_ = SingletonManager.Add<QueueManager>(layer);
				CraftyEngineModuleController.AddFilesManager(layer);
				SingletonManager.Add<MouseCursorManager>(layer);
				SingletonManager.Add<ControlModeManager>(layer);
				SingletonManager.AddAlias<T, CameraManager>(layer);
				SingletonManager.Add<UnityTouchScreenKeyboardTracker>(layer);
				SingletonManager.Add<UnityScreenSizeTracker>(layer);
				SingletonManager.Add<HudStateSwitcher>(layer);
				SingletonManager.Add<GuiModuleHolder>(layer);
				SingletonManager.Add<InputModel>(layer);
				SingletonManager.Add<KeyboardInputManager>(layer);
				SingletonManager.AddAlias<InputManagerNgui, InputManager>(layer);
				SingletonManager.Add<PoolsManager>(layer);
				SingletonManager.Add<PopUpManager>(layer);
				VoxelEngine.CreateEngineManager(layer);
			}
		}

		public void InitAndLoadContent()
		{
			if (SingletonAsyncPass.async)
			{
				SingletonManager.Add<LateLoader>(1);
			}
			SingletonManager.InitiatePhase(SingletonPhase.Init, 1);
			ContentLoaderModel contentLoaderModel = SingletonManager.Get<ContentLoaderModel>();
			contentLoaderModel.Loaded += HandleDeployDataLoaded;
			if (!SingletonAsyncPass.async)
			{
				contentLoaderModel.Load();
			}
		}

		private void HandleContentLoaded()
		{
			SingletonManager.InitiatePhase(SingletonPhase.LogicLoaded, 1);
		}

		private void HandleDeployDataLoaded()
		{
			DataStorage.manualLoadOnly = false;
			SingletonManager.InitiatePhase(SingletonPhase.DataLoaded, 4);
			SingletonManager.InitiatePhase(SingletonPhase.DataLoaded, 1);
			queueManagerPermanent_.AddTask(HandleContentLoaded);
		}
	}
}
