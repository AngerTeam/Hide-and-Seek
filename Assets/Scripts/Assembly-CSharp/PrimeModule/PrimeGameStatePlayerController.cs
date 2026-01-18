using System;
using CraftyEngine.States;
using CraftyNetworkEngine;
using CraftyNetworkEngine.Sockets;
using CraftyVoxelEngine;
using HudSystem;
using InventoryModule;
using Modules.KillCam;
using PlayerCameraModule;
using PlayerModule.MyPlayer;
using RemoteData.Socket;
using TcpIpOnline;
using UnityEngine;

namespace PrimeModule
{
	public class PrimeGameStatePlayerController : IDisposable
	{
		private OnlineConnectionController connectionController_;

		private SocketsConnectionOnline connectionOnline_;

		private PrimeGameExitController exitController_;

		private bool firstSpawn_;

		private IGameOnline gameOnline_;

		private PrimeStateHudController hudController_;

		private HudStateSwitcher hudStateSwitcher_;

		private KillCamModule killCamModule_;

		private PrimeGameStatePlayerModel model_;

		private MyPlayerModuleController myPlayerEntiry_;

		private MyPlayerStatsModel playerModel_;

		private PrimeModel primeModel_;

		private StateMachine stateMachine_;

		private PlayerCameraManager cameraManager_;

		public bool Enabled
		{
			get
			{
				return stateMachine_.enabled;
			}
			set
			{
				stateMachine_.enabled = value;
			}
		}

		public PrimeGameStatePlayerController(PrimeGameExitController exitController)
		{
			exitController_ = exitController;
			model_ = new PrimeGameStatePlayerModel();
			SingletonManager.Get<MyPlayerModuleController>(out myPlayerEntiry_);
			SingletonManager.Get<PrimeModel>(out primeModel_);
			SingletonManager.Get<HudStateSwitcher>(out hudStateSwitcher_);
			SingletonManager.Get<IGameOnline>(out gameOnline_);
			SingletonManager.Get<MyPlayerStatsModel>(out playerModel_);
			SingletonManager.Get<SocketsConnectionOnline>(out connectionOnline_);
			SingletonManager.Get<OnlineConnectionController>(out connectionController_);
			SingletonManager.Get<PlayerCameraManager>(out cameraManager_);
			gameOnline_.ReadyResponseReceived += HandleReadyResponseReceived;
			connectionOnline_.SyncPlayerResponseRecieved += HandleSyncPlayerResponseRecieved;
			State state = new State("idle");
			State state2 = new State("readyState");
			State state3 = new State("alive");
			State state4 = new State("dead");
			state.AddTransaction(state2, () => model_.sendReady);
			state2.AddTransaction(state3, () => model_.readyResponceRecieved);
			state3.AddTransaction(state4, () => playerModel_.stats.IsDead);
			state4.AddTransaction(state2, () => model_.sendReady);
			state.AddTransaction(state3, () => model_.readyResponceRecieved);
			stateMachine_ = new StateMachine(state, "PrimeGameState Player Controller");
			stateMachine_.enableLog = true;
			stateMachine_.enabled = false;
			stateMachine_.SetAutoUpdate(2);
			state4.Entered += KillCamEnable;
			state4.Exited += KillCamDisable;
			state3.Entered += Respawn;
			state3.Entered += ControlsEnable;
			state3.Exited += ControlsDisable;
			state.Entered += LoadoutHudEnable;
			state.Exited += LoadoutHudDisable;
			state2.Entered += SendReady;
			hudController_ = new PrimeStateHudController(primeModel_.forceRespawnTime);
			hudController_.forceRespawnTimer.Completed += HandleForceRespawnTimerCompleted;
			hudController_.hud.ReadyClicked += HandleReadyClicked;
			killCamModule_ = new KillCamModule();
			killCamModule_.Hide();
			connectionController_.Reconnected += HandleReconnected;
		}

		public void ControlsDisable()
		{
			hudStateSwitcher_.SwitchNormal(1089536);
			ControlsSet(false);
		}

		public void ControlsEnable()
		{
			if (firstSpawn_)
			{
				firstSpawn_ = false;
				InventoryModel inventoryModel = SingletonManager.Get<InventoryModel>();
				playerModel_.stats.SelectedArtikul = inventoryModel.SelectedSlot.ArtikulId;
			}
			hudStateSwitcher_.SwitchNormal(-1);
			ControlsSet(true);
		}

		public void Dispose()
		{
			stateMachine_.Dispose();
			hudController_.Dispose();
			killCamModule_.Dispose();
			connectionOnline_.SyncPlayerResponseRecieved -= HandleSyncPlayerResponseRecieved;
			connectionController_.Reconnected -= HandleReconnected;
			hudStateSwitcher_.SwitchNormal(-1);
		}

		public void NotifyVoxelEngine()
		{
			VoxelEngine singlton;
			SingletonManager.Get<VoxelEngine>(out singlton);
			GameModel singlton2;
			SingletonManager.Get<GameModel>(out singlton2);
			if (primeModel_.cameraPosition.HasValue && primeModel_.cameraRotation.HasValue)
			{
				singlton2.SpawnPosition = primeModel_.cameraPosition.Value;
				singlton2.Spawnrotation = primeModel_.cameraRotation.Value;
			}
			else
			{
				singlton2.SpawnPosition = playerModel_.stats.Position;
				singlton2.Spawnrotation = playerModel_.stats.Rotation;
			}
			singlton.spawned = true;
		}

		public void Start()
		{
			LoadoutHudEnable();
			ControlsDisable();
			ShowStaticCamera();
			Enabled = true;
		}

		private void ControlsSet(bool value)
		{
			playerModel_.myVisibility.VisibleBySubstate = value;
			playerModel_.Enable = value;
			playerModel_.input.EnabledByGameState = value;
		}

		private void HandleForceRespawnTimerCompleted()
		{
			model_.sendReady = true;
		}

		private void HandleReadyClicked()
		{
			model_.sendReady = true;
		}

		private void HandleReadyResponseReceived(RemoteMessageEventArgs obj)
		{
			if (obj == null)
			{
				Exc.Report(3202);
				return;
			}
			ReadyMessage readyMessage = obj.remoteMessage as ReadyMessage;
			if (readyMessage != null && readyMessage.position != null)
			{
				playerModel_.stats.HealthCurrent = readyMessage.health;
				myPlayerEntiry_.ResetPlayerPosition(readyMessage.position.ToVector3(), readyMessage.rotation.ToVector3());
				playerModel_.stats.SpawnTime = (int)readyMessage.started;
				model_.readyResponceRecieved = true;
				NotifyVoxelEngine();
			}
			else
			{
				Exc.Report(3202);
			}
		}

		private void HandleReconnected()
		{
			if (!model_.readyResponceRecieved)
			{
				stateMachine_.ReenterState();
			}
		}

		private void HandleSyncPlayerResponseRecieved(RemoteMessageEventArgs obj)
		{
			PlayerSyncMessage playerSyncMessage = obj.remoteMessage as PlayerSyncMessage;
			if (playerSyncMessage == null)
			{
				return;
			}
			if (playerSyncMessage.pvpBattle != null)
			{
				PvpBattleMessage pvpBattleMessage = playerSyncMessage.pvpBattle[0];
				playerModel_.stats.HealthCurrent = pvpBattleMessage.health;
				playerModel_.stats.combat.KillFragsCount = pvpBattleMessage.kills;
				playerModel_.stats.SetSide(pvpBattleMessage.side, true);
				if (pvpBattleMessage.ready == 1)
				{
					model_.readyResponceRecieved = true;
				}
			}
			if (playerSyncMessage.position != null && playerSyncMessage.position.Length == 1)
			{
				Vector3 position = playerSyncMessage.position[0].ToVector3();
				Vector3 rotation = playerSyncMessage.rotation[0].ToVector3();
				myPlayerEntiry_.ResetPlayerPosition(position, rotation);
				NotifyVoxelEngine();
			}
		}

		private void KillCamDisable()
		{
			killCamModule_.Hide();
			hudController_.StopTimer();
			hudController_.SetHudVisible(false);
		}

		private void KillCamEnable()
		{
			ShowStaticCamera();
			bool isSuicide = playerModel_.stats.AttackerId == playerModel_.stats.persId;
			killCamModule_.SetDead(playerModel_.stats.AttackerId, isSuicide, false);
			hudController_.StartTimer();
			hudController_.SetHudVisible(true);
		}

		private void LoadoutHudDisable()
		{
			hudController_.StopTimer();
			hudController_.SetHudVisible(false);
			exitController_.CloseStatsWindow();
		}

		private void LoadoutHudEnable()
		{
			exitController_.ShowLoadout();
			hudController_.StartTimer();
			hudController_.SetHudVisible(true);
		}

		private void Respawn()
		{
			cameraManager_.StatesController.SwitchToPersonMode(true);
			playerModel_.stats.Respawn();
		}

		private void SendReady()
		{
			model_.readyResponceRecieved = false;
			model_.sendReady = false;
			gameOnline_.SendReady();
		}

		private bool SyncHandler()
		{
			return true;
		}

		private void ShowStaticCamera()
		{
			if (primeModel_.cameraPosition.HasValue && primeModel_.cameraRotation.HasValue)
			{
				cameraManager_.StatesController.SwitchStaticState(primeModel_.cameraPosition.Value, Quaternion.Euler(primeModel_.cameraRotation.Value));
			}
		}
	}
}
