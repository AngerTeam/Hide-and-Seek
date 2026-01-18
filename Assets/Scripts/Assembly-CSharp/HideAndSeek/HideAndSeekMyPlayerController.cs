using CraftyEngine.Infrastructure;
using CraftyEngine.States;
using CraftyEngine.Utils;
using CraftyVoxelEngine;
using HudSystem;
using InventoryModule;
using PlayerCameraModule;
using PlayerModule.MyPlayer;
using RemoteData.Socket;
using SyncOnlineModule;
using UnityEngine;
using VoxelInventoryModule;

namespace HideAndSeek
{
	public class HideAndSeekMyPlayerController : Singleton
	{
		private bool castingCompleted_;

		private bool castingInterrupted_;

		private VoxelKey castingVoxelKey_;

		private State hiddenBySync_;

		private VoxelInteraction interaction_;

		private HideAndSeekModel model_;

		private MyPlayerStatsModel player_;

		private StateMachine stateMachine_;

		private HideAndSeekMyPlayerView view_;

		private SocketsHideAndSeekOnline online_;

		private UnityEvent unityEvent_;

		private MyPlayerModuleController myPlayerModule_;

		private VoxelInteractionModel voxelInteractionModel_;

		private PlayerCameraManager cameraManager_;

		private VoxelInventoryBroadcaster voxelInventory_;

		private IInventoryLogic inventory_;

		private GameModel gameModel_;

		private bool lookingAtHider_;

		private HideAndSeekActionsHud hideHud_;

		public override void Dispose()
		{
			cameraManager_.StatesController.SwitchToPersonMode(true);
			hideHud_.ActionButtonClicked -= ClickAction;
			player_.stats.SideChanged -= UpdatePlayerStats;
			player_.MovedShiftDistance -= HandlePlayerMovedShiftDistance;
			player_.stats.HealthChanged -= HandlePlayerHealthChanged;
			player_.stats.hideAndSeek.RoleChanged -= UpdatePlayerStats;
			player_.stats.hideAndSeek.HiddenChanged -= HandleHiddenChanged;
			player_.stats.hideAndSeek.SelectedHideVoxelChanged -= UpdatePlayerStats;
			view_.HideCastSucceeded -= OnHideCastSucceeded;
			myPlayerModule_.ContactHappened -= HandleContactHappened;
			gameModel_.StageChanged -= UpdatePlayerStats;
			inventory_.Model.SelectedSlotChanged -= HandleSelectedSlotChanged;
			model_.AllowSelect = false;
			voxelInteractionModel_.supressDig = false;
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			GuiModuleHolder.Remove(hideHud_);
			stateMachine_.Dispose();
		}

		private void HandleSelectedSlotChanged()
		{
			model_.lastSelectedVoxel = false;
			UpdatePlayerStats();
		}

		public void HidePlayerBySync(PlayerHideMessage hide)
		{
			player_.stats.hideAndSeek.HideVoxelId = hide.voxelId;
			VoxelKey key = new VoxelKey(hide.x, hide.y, hide.z);
			HideMyPlayer(key, (byte)hide.rotation);
			stateMachine_.GoTo(hiddenBySync_);
		}

		public override void Init()
		{
			SingletonManager.Get<MyPlayerStatsModel>(out player_);
			SingletonManager.Get<VoxelInteraction>(out interaction_);
			SingletonManager.Get<HideAndSeekModel>(out model_);
			SingletonManager.Get<HideAndSeekMyPlayerView>(out view_);
			SingletonManager.Get<SocketsHideAndSeekOnline>(out online_);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			SingletonManager.Get<MyPlayerModuleController>(out myPlayerModule_);
			SingletonManager.Get<VoxelInteractionModel>(out voxelInteractionModel_);
			SingletonManager.Get<PlayerCameraManager>(out cameraManager_);
			SingletonManager.Get<VoxelInventoryBroadcaster>(out voxelInventory_);
			SingletonManager.Get<GameModel>(out gameModel_);
			SingletonManager.Get<IInventoryLogic>(out inventory_);
			player_.stats.SideChanged += UpdatePlayerStats;
			player_.MovedShiftDistance += HandlePlayerMovedShiftDistance;
			player_.stats.HealthChanged += HandlePlayerHealthChanged;
			player_.stats.hideAndSeek.HiddenChanged += HandleHiddenChanged;
			player_.stats.hideAndSeek.SelectedHideVoxelChanged += UpdatePlayerStats;
			player_.stats.hideAndSeek.RoleChanged += UpdatePlayerStats;
			view_.HideCastSucceeded += OnHideCastSucceeded;
			myPlayerModule_.ContactHappened += HandleContactHappened;
			gameModel_.StageChanged += UpdatePlayerStats;
			inventory_.Model.SelectedSlotChanged += HandleSelectedSlotChanged;
			hideHud_ = GuiModuleHolder.Add<HideAndSeekActionsHud>();
			hideHud_.ActionButtonClicked += ClickAction;
			State state = new State("normal");
			State state2 = new State("casting");
			State state3 = new State("hidden");
			hiddenBySync_ = new State("hiddenBySync");
			model_.AllowSelect = true;
			stateMachine_ = new StateMachine(state, "HideAndSeekPlayerController");
			stateMachine_.SetAutoUpdate(Layer);
			stateMachine_.enabled = false;
			stateMachine_.enableLog = true;
			state.AddTransaction(state2, () => player_.stats.action == 6);
			state2.AddTransaction(state3, () => castingCompleted_);
			state2.AddTransaction(state, () => player_.stats.action != 6);
			state3.AddTransaction(state, () => !player_.stats.hideAndSeek.IsHidden);
			hiddenBySync_.AddTransaction(state, () => !player_.stats.hideAndSeek.IsHidden);
			hiddenBySync_.Exited += HandleHiddenExited;
			state3.Exited += HandleHiddenExited;
			state3.Entered += HandleHiddenEntered;
			state2.Entered += HandleCastingEntered;
			state2.Exited += HandleCastingExited;
			UpdatePlayerStats();
			unityEvent_.Subscribe(UnityEventType.Update, Update);
		}

		private void HandleHiddenChanged()
		{
			player_.myVisibility.VisibleByControlMode = !player_.stats.hideAndSeek.IsHidden;
			if (player_.stats.hideAndSeek.IsHidden)
			{
				Vector3 vector = player_.stats.hideAndSeek.HidePosition.ToVector() + Vector3.one * 0.5f;
				Vector3 position = vector + Vector3.up * 1.5f;
				cameraManager_.StatesController.SwitchCinematicState(position);
				view_.SetHiderFx();
				myPlayerModule_.ResetPlayerPosition(vector, player_.stats.Rotation);
			}
			else
			{
				cameraManager_.StatesController.SwitchToPersonMode();
				view_.ClearHiderFx();
			}
		}

		private void HandleContactHappened()
		{
			if (lookingAtHider_)
			{
				VoxelKey full = interaction_.model.rayHit.Full;
				online_.SendSeekCommand(full);
			}
		}

		private void Update()
		{
			lookingAtHider_ = player_.stats.hideAndSeek.IsSeeker && interaction_.model.rayHitSuccess && model_.CheckHiddenPlayer(interaction_.model.rayHit.Full);
			voxelInteractionModel_.supressDig = lookingAtHider_;
		}

		public override void OnDataLoaded()
		{
			if (DataStorage.isAdmin)
			{
				DebugButtonsManager singlton;
				SingletonManager.Get<DebugButtonsManager>(out singlton);
				singlton.Add(Localisations.Get("Hide"), KeyCode.H, ClickAction);
			}
		}

		public override void OnSyncRecieved()
		{
			PlayerSyncMessage message;
			if (!SyncManager.TryRead<PlayerSyncMessage>(out message))
			{
				return;
			}
			if (message.pvpBattle != null && message.hidePosition.Length > 0)
			{
				int side = message.pvpBattle[0].side;
				if (player_.stats.Side == side)
				{
					UpdatePlayerStats();
				}
				else
				{
					player_.stats.SetSide(message.pvpBattle[0].side, true);
				}
			}
			if (message.hidePosition != null && message.hidePosition.Length > 0)
			{
				PlayerHideMessage hide = message.hidePosition[0];
				HidePlayerBySync(hide);
			}
		}

		private bool AllowHideHere()
		{
			return interaction_.logic.AllowTechnicalBuild(castingVoxelKey_, true);
		}

		private void ClickAction()
		{
			HiderInteractive();
		}

		private void HiderInteractive()
		{
			if (player_.stats.hideAndSeek.IsHidden)
			{
				player_.stats.hideAndSeek.Appear();
				return;
			}
			if (player_.stats.action == 6)
			{
				TryInterruptCasting();
				return;
			}
			castingVoxelKey_ = interaction_.model.rayHit.Free;
			if (interaction_.model.rayHitSuccess && AllowHideHere())
			{
				player_.stats.action = 6;
				return;
			}
			castingVoxelKey_ = new VoxelKey(player_.stats.Position);
			if (AllowHideHere())
			{
				player_.stats.action = 6;
			}
		}

		private void HandleBoost()
		{
			float speedBoost;
			switch (player_.stats.hideAndSeek.Role)
			{
			case HideAndSeekRole.Hider:
				speedBoost = HideAndSeekContentMap.HideSeekSettings.hideAndSeekHiderSpeedBoost;
				break;
			case HideAndSeekRole.Seeker:
				speedBoost = HideAndSeekContentMap.HideSeekSettings.hideAndSeekSeekerSpeedBoost;
				break;
			case HideAndSeekRole.Monstr:
				speedBoost = HideAndSeekContentMap.HideSeekSettings.hideAndSeekMonstrSpeedBoost;
				break;
			default:
				speedBoost = 0f;
				break;
			}
			player_.speedBoost = speedBoost;
		}

		private void HandleCastingEntered()
		{
			view_.StartCast(castingVoxelKey_);
			model_.ReportCastingStarted();
		}

		private void HandleCastingExited()
		{
			player_.stats.action = 0;
			if (castingInterrupted_)
			{
				view_.DestroyHideCastVoxel();
			}
			castingInterrupted_ = false;
			view_.CancelTimer();
		}

		private void HandleHiddenEntered()
		{
			castingCompleted_ = false;
			if (!AllowHideHere())
			{
				TryInterruptCasting();
				return;
			}
			interaction_.controller.enableEvents = false;
			byte rotation;
			interaction_.controller.SetVoxel(castingVoxelKey_, (ushort)player_.stats.hideAndSeek.VoxelId, out rotation);
			interaction_.controller.enableEvents = true;
			HideMyPlayer(castingVoxelKey_, rotation);
		}

		private void HandleHiddenExited()
		{
			player_.stats.hideAndSeek.Appear();
		}

		private void HandlePlayerHealthChanged(int arg1, int arg2, string arg3)
		{
			TryInterruptCasting();
		}

		private void HandlePlayerMovedShiftDistance()
		{
			TryInterruptCasting();
		}

		private void UpdatePlayerStats()
		{
			player_.UiAction = 0;
			stateMachine_.enabled = player_.stats.hideAndSeek.IsHiderOrMonstr;
			voxelInteractionModel_.selectedItemDistance = ((!player_.stats.hideAndSeek.IsHiderOrMonstr && !model_.lastSelectedVoxel) ? voxelInventory_.GetInteractionDistance() : HideAndSeekContentMap.HideSeekSettings.interactionDistanceHide);
			HandleBoost();
		}

		private void HideMyPlayer(VoxelKey key, byte rotation)
		{
			player_.stats.hideAndSeek.Hide(key, rotation);
		}

		private void OnHideCastSucceeded()
		{
			if (AllowHideHere())
			{
				castingCompleted_ = true;
			}
			else
			{
				TryInterruptCasting();
			}
		}

		private void TryInterruptCasting()
		{
			if (player_.stats.action == 6)
			{
				player_.stats.action = 0;
				castingInterrupted_ = true;
			}
		}
	}
}
