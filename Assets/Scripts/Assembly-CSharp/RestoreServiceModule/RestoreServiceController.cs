using Authorization;
using HudSystem;
using InGameMenuModule;
using PlayerModule.MyPlayer;
using PopUpModule;
using RemoteData.Lua;
using SyncOnlineModule;

namespace RestoreServiceModule
{
	public class RestoreServiceController : Singleton
	{
		private RestoreServiceOnlineController restoreServiceOnlineController_;

		private IRestoreInGameMenu inGameMenu_;

		private string gameCenterId_;

		private bool syncRecieved_;

		private BindPlayerMessage bindPlayerMessage_;

		private IRestoreServiceWrapper wrapper_;

		private AuthorizationData authorizationData_;

		public RestoreServiceState State { get; private set; }

		public override void Init()
		{
			PersistanceManager.Get<AuthorizationData>(out authorizationData_);
			SingletonManager.Get<IRestoreInGameMenu>(out inGameMenu_);
			SingletonManager.Get<RestoreServiceOnlineController>(out restoreServiceOnlineController_);
			inGameMenu_.RestoreButtonClicked += OnRestoreButtonClicked;
			restoreServiceOnlineController_.AnotherProfileReceived += OnAnotherProfileReceived;
			restoreServiceOnlineController_.BoundSucceedReceived += OnBoundSucceedReceived;
			restoreServiceOnlineController_.BoundForcedReceived += OnBoundSucceedReceived;
			restoreServiceOnlineController_.UnboundReceived += OnUnboundReceived;
			State = RestoreServiceState.Uninitialized;
			if (CompileConstants.IOS && !CompileConstants.EDITOR)
			{
				wrapper_ = new GameCenterWrapper();
			}
			else if (CompileConstants.EDITOR)
			{
				wrapper_ = new EditorGameCenterWrapper();
			}
			wrapper_.AuthFinished += OnAuthFinished;
			wrapper_.Init();
		}

		public override void OnDataLoaded()
		{
			inGameMenu_.EnableRestoreButton(true);
			SetRestoreButtonText();
		}

		private void OnAnotherProfileReceived(BindPlayerMessage bindPlayerMessage)
		{
			bindPlayerMessage_ = bindPlayerMessage;
			OpenRestoreWindow();
		}

		private void OnBoundSucceedReceived()
		{
			bindPlayerMessage_ = null;
			SetGameCenterId(wrapper_.GetPlayerId());
		}

		private void OnUnboundReceived()
		{
			bindPlayerMessage_ = null;
			SetGameCenterId(string.Empty);
		}

		public override void OnSyncRecieved()
		{
			PlayerSyncMessage message;
			if (SyncManager.TryRead<PlayerSyncMessage>(out message) && message.main != null && message.main.Length > 0)
			{
				syncRecieved_ = true;
				string gameCenterId = message.main[0].gameCenterId;
				if (!string.IsNullOrEmpty(gameCenterId))
				{
					gameCenterId_ = gameCenterId;
				}
				TryUpdateState();
				BindOnStart();
			}
		}

		private void SetGameCenterId(string id)
		{
			gameCenterId_ = id;
			PlayerSyncMessage message;
			if (SyncManager.TryRead<PlayerSyncMessage>(out message) && message.main != null && message.main.Length > 0)
			{
				message.main[0].gameCenterId = id;
			}
			TryUpdateState();
		}

		private void OnAuthFinished(bool success)
		{
			TryUpdateState();
			BindOnStart();
		}

		private void BindOnStart()
		{
			if (State == RestoreServiceState.NotBound || State == RestoreServiceState.AnotherIdFound)
			{
				SendBindService();
			}
		}

		private void TryUpdateState()
		{
			if (syncRecieved_ && wrapper_.IsAuthenticated())
			{
				if (string.IsNullOrEmpty(gameCenterId_))
				{
					State = RestoreServiceState.NotBound;
				}
				else if (gameCenterId_ == wrapper_.GetPlayerId())
				{
					State = RestoreServiceState.Bound;
				}
				else
				{
					State = RestoreServiceState.AnotherIdFound;
				}
			}
			else
			{
				State = RestoreServiceState.Uninitialized;
			}
			SetRestoreButtonText();
		}

		private void SetRestoreButtonText()
		{
			string restoreButtonText = string.Empty;
			switch (State)
			{
			case RestoreServiceState.Uninitialized:
			case RestoreServiceState.NotBound:
			case RestoreServiceState.AnotherIdFound:
				restoreButtonText = "UI_BindGameCenter";
				break;
			case RestoreServiceState.Bound:
				restoreButtonText = "UI_UnbindGameCenter";
				break;
			}
			inGameMenu_.SetRestoreButtonText(restoreButtonText);
		}

		public void OpenRestoreWindow()
		{
			if (bindPlayerMessage_ != null)
			{
				MyPlayerStatsModel myPlayerStatsModel = SingletonManager.Get<MyPlayerStatsModel>();
				RestoreServiceWindow restoreServiceWindow = GuiModuleHolder.Get<RestoreServiceWindow>();
				restoreServiceWindow.OpenWindow(myPlayerStatsModel.stats.nickname, myPlayerStatsModel.stats.experiance.level, myPlayerStatsModel.money.CrystalsAmount, bindPlayerMessage_.name, bindPlayerMessage_.level, bindPlayerMessage_.money);
			}
		}

		public void SelectCurrentProfile()
		{
			restoreServiceOnlineController_.SendGameCenterBindForce(wrapper_.GetPlayerId(), authorizationData_.password);
		}

		public void SelectRemoteProfile()
		{
			if (bindPlayerMessage_ != null)
			{
				SetGameCenterId(bindPlayerMessage_.gameCenterId);
				authorizationData_.login = bindPlayerMessage_.email;
				authorizationData_.password = bindPlayerMessage_.passwd;
				PersistanceManager.Save(authorizationData_);
				GameModel singlton;
				SingletonManager.Get<GameModel>(out singlton);
				singlton.restartPending = true;
			}
		}

		private void SendBindService()
		{
			restoreServiceOnlineController_.SendGameCenterBind(wrapper_.GetPlayerId(), authorizationData_.password);
		}

		private void SendUnbindService()
		{
			restoreServiceOnlineController_.SendGameCenterUnbind();
		}

		private void OnRestoreButtonClicked()
		{
			switch (State)
			{
			case RestoreServiceState.Uninitialized:
			{
				wrapper_.Init();
				PopUpManager popUpManager = SingletonManager.Get<PopUpManager>();
				popUpManager.AddMessage(Localisations.Get("UI_ConnectGameCenterInfo"));
				break;
			}
			case RestoreServiceState.NotBound:
				SendBindService();
				break;
			case RestoreServiceState.AnotherIdFound:
				SendBindService();
				break;
			case RestoreServiceState.Bound:
				SendUnbindService();
				break;
			}
		}

		public override void Dispose()
		{
			restoreServiceOnlineController_.AnotherProfileReceived -= OnAnotherProfileReceived;
			restoreServiceOnlineController_.BoundSucceedReceived -= OnBoundSucceedReceived;
			restoreServiceOnlineController_.BoundForcedReceived -= OnBoundSucceedReceived;
			restoreServiceOnlineController_.UnboundReceived -= OnUnboundReceived;
			wrapper_.AuthFinished -= OnAuthFinished;
		}
	}
}
