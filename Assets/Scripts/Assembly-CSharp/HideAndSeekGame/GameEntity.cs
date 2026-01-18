using System;
using AbilitiesOnlineModule;
using Animations;
using Authorization;
using BankModule;
using BattleStats;
using ChestsOnlineModule;
using ChestsViewModule;
using Combat;
using CombatOnline;
using CraftyEngine.Content;
using CraftyEngine.Infrastructure;
using CraftyEngine.Infrastructure.SingletonManagerCore;
using CraftyEngine.States;
using CraftyMultiplayerEngine;
using CraftyNetworkEngine.Chat;
using CraftyVoxelEngine;
using CraftyVoxelEngine.Editor;
using DisplayModule;
using Effects;
using ExpirienceModule;
using ExporterModule;
using Game;
using GameInfrastructure;
using HideAndSeek;
using HttpNetwork;
using HudSystem;
using InGameMenuModule;
using InputObserverModule;
using InventoryModule;
using KillMessageModule;
using Localizations;
using MobsModule;
using Modules.PerfomanceTests;
using MyNicknameModule;
using MyPlayerInput;
using NewsModule;
using PlayerCameraModule;
using PlayerModule;
using PlayerModule.MyPlayer;
using PrimeModule;
using ProjectilesModule;
using PurchasePopupModule;
using RateMeModule;
using RestoreServiceModule;
using SelectModeModule;
using ShapesModule;
using ShopModule;
using SoundsModule;
using SplashesModule;
using SyncOnlineModule;
using TcpIpOnline;
using TutorialModule;
using UnityEngine;
using WeaponSightsModule;
using WebViewModule;
using WindowsModule;

namespace HideAndSeekGame
{
	public class GameEntity
	{
		private static GameEntity instance_;

		private GameModel model_;

		private PrimeGameStateEntity primeStateEntity_;

		private InfrastructureContoller infrastructureContoller_;

		private StateMachine machine_;

		private ProgressUtility progressUtility_;

		private HttpTopManager httpTopManager_;

		private AuthorizationModel authorizationModel_;

		private PlayerCameraManager cameraManager_;

		private SplashScreenLogic splashLogic_;

		private MyPlayerStatsModel myPlayerStatsModel_;

		private UnityEvent unityEvent_;

		private SyncManager syncManager_;

		private RateController rateController_;

		private VoxelEditorModel voxelEditorModel_;

		private LevelUpController levelUpController_;

		private ShowAdController showAdController_;

		private TutorialLevelController tutorialLevelController_;

		private DisplayManager displayManager_;

		private PvpAuthorizationModel pvpAuthorizationModel_;

		private ReenterPrimeController reenterPrimeController_;

		private State decisionState_;

		private State stateEnter_;

		private State stateLobby_;

		private State stateLoadPermanentData_;

		private State stateNickname_;

		private State stateGetRandomMap_;

		private State exitOnline_;

		private State stateLoadPrime_;

		private State stateRepeatPrime_;

		private State statePrime_;

		private State stateLvlUp_;

		private State stateLvlUpOnEnter_;

		private State stateRate_;

		private State stateShowAd_;

		private State stateTutorial_;

		private PrimeModel primeModel_;

		public GameEntity()
		{
			CraftyEngineModuleController.defaultHosting = "http://deploy.hidenseek.online/public/";
			SplashScreenManager.defaultSplashScreen = "UIHnsSplashScreen";
			SingletonManager.Init(5);
			infrastructureContoller_ = new InfrastructureContoller();
			levelUpController_ = new LevelUpController();
			rateController_ = new RateController();
			tutorialLevelController_ = new TutorialLevelController();
			showAdController_ = new ShowAdController();
			CraftyEngineModuleController.InitEternalBasicSystem(0);
			model_ = SingletonManager.Add<GameModel>(0);
			InitStates();
			infrastructureContoller_.InitEternalSystem();
			unityEvent_ = SingletonManager.Get<UnityEvent>(0);
			unityEvent_.Subscribe(UnityEventType.Update, Update);
			stateLoadPermanentData_.Entered += LoadPermanentData;
			stateLobby_.Entered += LoadStateLobby;
			stateLobby_.Exited += ExitStateLobby;
			stateNickname_.Entered += ShowNicknameWindow;
			stateLoadPrime_.Entered += LoadPrimeState;
			stateGetRandomMap_.Entered += GetRandomMap;
			stateGetRandomMap_.Exited += UpdatePvpSettings;
			stateRepeatPrime_.Entered += RepeatPrimeState;
			statePrime_.Entered += StartPrimeState;
			exitOnline_.Exited += StopPrimeState;
			statePrime_.Entered += SetPlayerVisible;
			statePrime_.Exited += SetPlayerInvisible;
			stateLobby_.Entered += SetPlayerVisible;
			stateLobby_.Exited += SetPlayerInvisible;
			exitOnline_.Entered += ExitOnlineEntered;
			stateLvlUp_.Entered += levelUpController_.Start;
			stateLvlUpOnEnter_.Entered += levelUpController_.Start;
			stateRate_.Entered += rateController_.Start;
			stateShowAd_.Entered += showAdController_.Start;
			stateTutorial_.Entered += LoadTutorialState;
			stateTutorial_.Exited += ExitTutorialState;
			Start();
		}

		public static void Instantiate()
		{
			instance_ = new GameEntity();
		}

		private void GetRandomMap()
		{
			ShowSplashScreen();
			InitPrimeState();
			primeStateEntity_.EnterByMode();
			pvpAuthorizationModel_.alreadyInPvp = true;
		}

		private void ShowNicknameWindow()
		{
			NicknameWindow nicknameWindow = GuiModuleHolder.Get<NicknameWindow>();
			nicknameWindow.OpenWindow(false);
		}

		private void ExitOnlineEntered()
		{
			primeStateEntity_.ExitController.ExitByUser();
			ShowSplashScreen();
		}

		private void ShowSplashScreen()
		{
			splashLogic_.ShowSplashScreen();
		}

		private void SetPlayerInvisible()
		{
			myPlayerStatsModel_.myVisibility.VisibleGameState = false;
			cameraManager_.SetVisiblePlease(this, false);
		}

		private void SetPlayerVisible()
		{
			myPlayerStatsModel_.myVisibility.VisibleGameState = true;
			cameraManager_.SetVisiblePlease(this, true);
		}

		private void StartPrimeState()
		{
			model_.afterPrime = true;
			TimeManager singlton;
			SingletonManager.Get<TimeManager>(out singlton);
			DataStorage.primeStartedTimestamp = singlton.CurrentTimestamp;
		}

		private void StopPrimeState()
		{
			TimeManager singlton;
			SingletonManager.Get<TimeManager>(out singlton);
			DataStorage.primeEndedTimestamp = singlton.CurrentTimestamp;
			SingletonManager.Get<VoxelEngine>().Reset();
			DisposeCurrent();
			model_.levelLoaded = false;
			primeStateEntity_.Dispose();
			primeStateEntity_ = null;
			PlayerSkinsManager playerSkinsManager = SingletonManager.Get<PlayerSkinsManager>();
			playerSkinsManager.EnableSkins(true);
			SingletonManager.Get<WindowsManager>().CloseAll();
		}

		private void RepeatPrimeState()
		{
			model_.lobby = false;
			model_.primeRepeat = false;
			model_.prime = true;
		}

		private void LoadPrimeState()
		{
			InitPrimeState();
			CraftyEngineModuleController.InitCurrentSystem(2);
			myPlayerStatsModel_.stats.BodyType = BodyType.DEFAULT;
			myPlayerStatsModel_.OnReset();
			cameraManager_.OnReset();
			SingletonManager.Get<WindowsManager>().CloseAll();
			splashLogic_.ShowSplashScreenByGameType(primeModel_.modeId);
			primeStateEntity_.Enter(authorizationModel_.alreadyInPvp);
			splashLogic_.manager.SetProgress(0f);
			splashLogic_.manager.SetDefaultTitle();
			authorizationModel_.alreadyInPvp = false;
		}

		private void InitPrimeState()
		{
			if (primeStateEntity_ == null)
			{
				int layer = 2;
				SingletonManager.Add<PrimeRulesManager>(layer);
				PvpServerTopManager.InitModule(layer);
				SingletonManager.AddAlias<HNSNetworkShopManager, NetworkShopManager>(layer);
				SingletonManager.Add<PlaymatesExpirienceManager>(layer);
				ArtikulViewModuleController.Init(layer);
				SingletonManager.Add<SyncReceiver>(layer);
				SingletonManager.Add<ChestsSocketsManagerOnline>(layer);
				SingletonManager.Add<InputObserver>(layer);
				SingletonManager.Add<VoxelSettingsBroadcaster>(layer);
				CombatOnlineModuleController.InitModule(layer);
				SingletonManager.Add<KillMessageModuleController>(layer);
				SingletonManager.Add<ChatManager>(layer);
				MapFxController.InitModule(layer);
				VoxelInventoryModuleController.InitModule(layer);
				LootModuleController.Init(false);
				SingletonManager.Add<PvpTimersManager>(layer);
				if (primeModel_.modeId == 5)
				{
					HideAndSeekModuleController.InitPrime(layer);
				}
				AbilitiesOnlineModuleController.InitModule(layer);
				primeStateEntity_ = new PrimeGameStateEntity();
			}
		}

		private void UpdatePvpSettings()
		{
			SelectModeController selectModeController = SingletonManager.Get<SelectModeController>();
			selectModeController.SetSettings(pvpAuthorizationModel_.mapId);
		}

		public void Start()
		{
			CraftyEngineModuleController.InitPermanentBasicSystem(4);
			splashLogic_ = SingletonManager.Add<SplashScreenLogic>(4);
			infrastructureContoller_.InitPermanentBasicSystem(4);
			if (SingletonAsyncPass.async)
			{
				SingletonManager.Add<SplashScreenAsynOpener>();
			}
			else
			{
				splashLogic_.ShowSplashScreen();
			}
		}

		private void Restart()
		{
			model_.restartPending = false;
			if (primeStateEntity_ != null)
			{
				primeStateEntity_.Dispose();
				primeStateEntity_ = null;
			}
			for (int num = 4; num >= 0; num--)
			{
				if (num != 0)
				{
					SingletonManager.ClearLayer(num);
				}
			}
			SingletonManager.ClearEvents();
			model_.Reset();
			machine_.GoTo(stateEnter_, true);
			GC.Collect();
			Resources.UnloadUnusedAssets();
			unityEvent_.Subscribe(UnityEventType.Update, Start, true);
		}

		private void InitStates()
		{
			stateLoadPermanentData_ = new GameState("loadingPermanentData", GameStateType.Loading);
			stateLoadPrime_ = new GameState("loadPrime", GameStateType.Loading);
			stateRepeatPrime_ = new GameState("repeatPrime", GameStateType.Loading);
			stateLobby_ = new GameState("lobby", 27826, GameStateType.Lobby);
			stateTutorial_ = new GameState("tutorial", 25436175, GameStateType.Tutorial);
			stateNickname_ = new GameState("nickname", 0, GameStateType.Lobby);
			stateGetRandomMap_ = new GameState("getRandomMap", 0, GameStateType.Lobby);
			statePrime_ = new GameState("prime", 25468943, GameStateType.Prime);
			exitOnline_ = new GameState("exitOnline", 25468943, GameStateType.Loading);
			stateEnter_ = new GameState("enter", GameStateType.Loading);
			decisionState_ = new GameState("desision");
			stateLvlUp_ = new GameState("lvlUp");
			stateLvlUpOnEnter_ = new GameState("lvlUpOnEnter");
			stateRate_ = new GameState("rate");
			stateShowAd_ = new GameState("showAd");
			machine_ = new StateMachine(stateEnter_, "GameEntity");
			machine_.StateChanged += HandleStateChanged;
			machine_.SetModel<GameModelInspector>(model_);
			machine_.enableLog = true;
			stateEnter_.AddTransaction(stateLoadPermanentData_, () => model_.minmalDataLoaded);
			stateLoadPermanentData_.AddTransaction(decisionState_, () => model_.permanentDataLoaded && (authorizationModel_.result != 0 || model_.developer));
			reenterPrimeController_ = new ReenterPrimeController(decisionState_, stateLoadPrime_);
			reenterPrimeController_.MapIdRecieved += HandleMapIdRecieved;
			decisionState_.AddTransaction(stateTutorial_, () => model_.lobby && authorizationModel_.newUser && authorizationModel_.result == AuthorisationResult.Normal);
			decisionState_.AddTransaction(stateLvlUpOnEnter_, () => !model_.lvlUpChecked);
			decisionState_.AddTransaction(stateLobby_, () => model_.lobby && !authorizationModel_.newUser && authorizationModel_.result == AuthorisationResult.Normal);
			decisionState_.AddTransaction(stateNickname_, () => model_.prime && !authorizationModel_.HasNickname);
			decisionState_.AddTransaction(stateGetRandomMap_, () => model_.prime && pvpAuthorizationModel_.mapId == 0);
			decisionState_.AddTransaction(stateLoadPrime_, () => model_.prime && authorizationModel_.HasNickname);
			stateGetRandomMap_.AddTransaction(stateLoadPrime_, () => pvpAuthorizationModel_.mapId != 0);
			stateNickname_.AddTransaction(decisionState_, () => authorizationModel_.HasNickname);
			stateLoadPrime_.AddTransaction(statePrime_, () => model_.levelLoaded);
			statePrime_.AddTransaction(exitOnline_, () => !model_.prime);
			stateRepeatPrime_.AddTransaction(decisionState_, () => model_.prime);
			exitOnline_.AddTransaction(stateShowAd_, () => model_.primeRepeat);
			exitOnline_.AddTransaction(stateLvlUp_, () => model_.lobby && !model_.primeRepeat);
			stateLvlUp_.AddTransaction(stateRate_, () => model_.lvlUpChecked);
			stateLvlUpOnEnter_.AddTransaction(decisionState_, () => model_.lvlUpChecked);
			stateTutorial_.AddTransaction(stateLobby_, () => !authorizationModel_.newUser);
			stateRate_.AddTransaction(stateLobby_, () => model_.rated);
			stateRate_.AddTransaction(stateShowAd_, () => model_.rateNotNeeded);
			stateShowAd_.AddTransaction(stateLobby_, () => model_.adDone && !model_.primeRepeat);
			stateShowAd_.AddTransaction(stateRepeatPrime_, () => model_.adDone && model_.primeRepeat);
			stateLobby_.AddTransaction(decisionState_, () => !model_.lobby);
		}

		private void HandleMapIdRecieved(int mapId)
		{
			PvpAuthorizationModel pvpAuthorizationModel = SingletonManager.Get<PvpAuthorizationModel>();
			SelectModeController selectModeController = SingletonManager.Get<SelectModeController>();
			CommonIslandsEntries commonIslandsEntries = SelectGameModeMap.CommonIslands[mapId];
			selectModeController.PlayMap(commonIslandsEntries.mode_id, commonIslandsEntries.id, true);
			pvpAuthorizationModel.mapModeId = commonIslandsEntries.mode_id;
			reenterPrimeController_.Continue();
		}

		private void HandleStateChanged()
		{
			GameState gameState = machine_.CurrentState as GameState;
			if (gameState != null)
			{
				model_.CurrentGameHudState = gameState.hudState;
				if (gameState.type != 0)
				{
					model_.CurrentGameStateType = gameState.type;
				}
			}
		}

		private void LoadPermanentData()
		{
			DataStorage.version = Resources.Load<TextAsset>("version").text;
			DataStorage.bundleIdentifier = Application.identifier;
			int layer = 1;
			HttpOnlineManager.InitHttp(layer);
			HttpTopManager.InitAuth(layer);
			NetworkBankManager.InitBank(layer);
			SingletonManager.Get<PvpAuthorizationModel>(out pvpAuthorizationModel_);
			SingletonManager.Get<AuthorizationModel>(out authorizationModel_);
			SingletonManager.Get<HttpTopManager>(out httpTopManager_);
			MyPlayerModuleController.InitModel(layer);
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			myPlayerStatsModel_.myVisibility.VisibleGameState = false;
			syncManager_ = SingletonManager.Add<SyncManager>(layer);
			SingletonManager.Add<LocalizationsContentDeserializer>(layer);
			MyPlayerInputMobule.InitModule(layer);
			primeModel_ = SingletonManager.Add<PrimeModel>(layer);
			voxelEditorModel_ = SingletonManager.Add<VoxelEditorModel>(layer);
			voxelEditorModel_.developer = model_.developer;
			PVPModuleController.InitModule();
			SingletonManager.Add<PerfomanceTestsUtility>(layer);
			SingletonManager.Add<TimeManager>(layer);
			SingletonManager.Add<TimeManagerOnline>(layer);
			MyNicknameModuleController.InitModule(layer);
			SingletonManager.Add<GameContentDeserializer>(layer);
			SingletonManager.Add<SoundContentDeserializer>(layer);
			SingletonManager.Add<SoundManager>(layer);
			SingletonManager.Add<SoundManagerBridge>(layer);
			SingletonManager.AddAlias<HideNSeekInGameMenuManager, IRestoreInGameMenu>(layer);
			SingletonManager.Add<LevelUpController>(layer);
			SingletonManager.Add<RateController>(layer);
			SingletonManager.Add<RateMeController>(layer);
			SingletonManager.Add<ExpirienceManager>(layer).LevelUpEnabled = false;
			SingletonManager.Add<ChestOpener>(layer);
			SingletonManager.Add<PurchasePopupController>(layer);
			SingletonManager.Add<NewsModuleManager>(layer);
			AdsModuleController.InitModule(layer);
			ChestsModuleController.InitPermanent(layer);
			SelectModeModuleController.InitModule(layer);
			TutorialModuleController.InitModule(layer);
			displayManager_ = SingletonManager.Add<DisplayManager>(layer);
			displayManager_.Fps = 60;
			infrastructureContoller_.InitPermanentAdvancedSystem<PlayerCameraManager>();
			cameraManager_ = SingletonManager.Get<PlayerCameraManager>(layer);
			InventoryModuleController.InitModule();
			SingletonManager.Add<VoxelInventoryModel>(layer);
			WeaponSightsModuleController.InitModule();
			NotificationsModuleController.InitModule();
			InGameMenuManager.InitModule();
			BankController.InitModule(layer);
			MessageDisplay messageDisplay = SingletonManager.Get<MessageDisplay>();
			messageDisplay.CriticalErrorConfirmed += SetRestart;
			SingletonManager.Add<GameHudManager>(layer);
			MyPlayerModuleController.InitModule(layer);
			SingletonManager.Add<MobBodyViewManager>(layer);
			ShopModuleController.InitModule(layer);
			ShopModuleOnlineController.InitModule(layer);
			RecommendedToBuyModuleController.InitModule(layer);
			ExporterModuleController.InitModule(layer);
			WebViewModuleController.InitModule(layer);
			HideAndSeekModuleController.InitModule(layer);
			SingletonManager.Add<GameInventoryWindowController>(layer);
			SpecialOffersModuleController.InitModule(layer);
			ProjectilesModuleController.InitModule(layer);
			AbilitiesOnlineModuleController.InitPermaModule(layer);
			httpTopManager_.enableAutoAuthorizate = !model_.developer;
			infrastructureContoller_.InitAndLoadContent();
			levelUpController_.Init();
			rateController_.Init();
			showAdController_.Init();
			VoxelLoader voxelLoader = SingletonManager.Get<VoxelLoader>();
			progressUtility_ = new ProgressUtility(layer);
			progressUtility_.AddTask(SingletonManager.Get<ContentLoaderEntity>().StateMachine);
			progressUtility_.AddTask(SingletonManager.Get<AuthorizationEntity>().StateMachine);
			progressUtility_.AddTask(voxelLoader);
			voxelLoader.Loaded += HandleLoaded;
			reenterPrimeController_.Init();
		}

		private void SetRestart()
		{
			model_.restartPending = true;
		}

		private void LoadStateLobby()
		{
			myPlayerStatsModel_.OnReset();
			cameraManager_.OnReset();
			model_.levelLoaded = false;
			int num = 2;
			SingletonManager.Add<SyncReceiver>(num);
			SingletonManager.Add<ShapeManager>(num);
			SingletonManager.Add<VoxelSettingsBroadcaster>(num);
			SingletonManager.Add<LobbyShapeManager>(num);
			MapFxController.InitModule(num);
			ArtikulViewModuleController.Init(num);
			HttpTopManager.InitModule(num);
			SingletonManager.AddAlias<HNSNetworkShopManager, NetworkShopManager>(num);
			ChestsModuleController.InitCurrent(num);
			HideAndSeekModuleController.InitLobby(num);
			GuiModuleHolder.Add<GameHideAndSeekBeltHud>();
			RestoreServiceModuleController.InitModule(num);
			CraftyEngineModuleController.InitCurrentSystem(num, false);
			if (SingletonAsyncPass.async)
			{
				SingletonManager.Add<LobbyAsynStarter>(num);
			}
			HNSLobbyModuleController.InitModule(num);
			SingletonManager.InitiatePhase(SingletonPhase.Init, num);
			SingletonManager.InitiatePhase(SingletonPhase.DataLoaded, num);
			myPlayerStatsModel_.myVisibility.VisibleGameState = false;
			if (!SingletonAsyncPass.async)
			{
				HNSLobbyModuleController.Load(HideAndSeekGameMap.Islands[1].GetFullClientMapPath());
			}
			if (model_.afterPrime)
			{
				model_.afterPrime = false;
				httpTopManager_.Sync();
			}
			syncManager_.Report(num);
			progressUtility_.Clear();
			displayManager_.SleepTimeout = HideAndSeekGameMap.GameConstants.LOBBY_SCREEN_SLEEP_TIMEOUT * 60;
			RestoreServiceController singleton;
			SingletonManager.TryGet<RestoreServiceController>(out singleton);
			if (singleton != null)
			{
				singleton.OpenRestoreWindow();
			}
		}

		private void ExitStateLobby()
		{
			SingletonManager.Get<VoxelEngine>().Reset();
			SingletonManager.Get<WindowsManager>().CloseAll();
			displayManager_.SleepTimeout = 0;
			GuiModuleHolder.Remove<GameHideAndSeekBeltHud>();
			DisposeCurrent();
			pvpAuthorizationModel_.comaback = primeModel_.comeback;
			pvpAuthorizationModel_.mapModeId = primeModel_.modeId;
			pvpAuthorizationModel_.mapId = primeModel_.mapId;
		}

		private void DisposeCurrent()
		{
			SingletonManager.Get<PoolsManager>().ClearAll();
			SingletonManager.ClearLayer(2);
			myPlayerStatsModel_.OnReset();
			cameraManager_.OnReset();
			GC.Collect();
			Resources.UnloadUnusedAssets();
		}

		private void LoadTutorialState()
		{
			int layer = 2;
			ArtikulViewModuleController.Init(layer);
			SingletonManager.Add<InputObserver>(layer);
			SingletonManager.Add<ShapeManager>(layer);
			SingletonManager.Add<TutorialShapeManager>(layer);
			SingletonManager.Add<VoxelSettingsBroadcaster>(layer);
			SingletonManager.Add<PlayerModelsHolder>(layer);
			SingletonManager.Add<PlaymatesActorsHolder>(layer);
			SingletonManager.Add<CombatInteraction>(layer);
			MapFxController.InitModule(layer);
			VoxelInventoryModuleController.InitModule(layer);
			LootModuleController.Init(true);
			CraftyEngineModuleController.InitCurrentSystem(layer);
			myPlayerStatsModel_.OnReset();
			cameraManager_.OnReset();
			GuiModuleHolder.Add<GameHideAndSeekBeltHud>();
			SingletonManager.Get<WindowsManager>().CloseAll();
			tutorialLevelController_.Start();
			progressUtility_.Clear();
		}

		private void ExitTutorialState()
		{
			ShowSplashScreen();
			DisposeCurrent();
			SingletonManager.Get<VoxelEngine>().Reset();
			tutorialLevelController_.Quit();
			GuiModuleHolder.Remove<GameHideAndSeekBeltHud>();
		}

		private void HandleLoaded()
		{
			cameraManager_.SetObstacleSensor(new CameraVoxelObstacleSensor());
			AnimationsContentMap.AnimationSettings.allowVericalRunAnimations = true;
			AnimationsContentMap.AnimationSettings.allowBlendWeight = false;
			AnimationsContentMap.AnimationSettings.allowOverrideRun = false;
			model_.permanentDataLoaded = true;
		}

		private void Update()
		{
			if (model_.restartPending)
			{
				Restart();
			}
			else
			{
				machine_.Update();
			}
			if (progressUtility_ != null && splashLogic_ != null && splashLogic_.manager != null)
			{
				splashLogic_.manager.SetProgress(progressUtility_.Progress);
			}
		}
	}
}
