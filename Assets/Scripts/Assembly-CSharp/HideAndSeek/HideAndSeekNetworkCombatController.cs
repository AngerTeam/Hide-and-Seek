using BankModule;
using BattleStats;
using CombatOnline;
using CraftyNetworkEngine;
using CraftyVoxelEngine;
using HudSystem;
using InventoryModule;
using PlayerModule;
using RemoteData;
using RemoteData.Socket;
using SyncOnlineModule;
using UnityEngine;

namespace HideAndSeek
{
	public class HideAndSeekNetworkCombatController : NetworkBasicPlayersManager
	{
		public bool silent;

		private bool allowNotifications_;

		private int currentStage_;

		private int lastSentHideVoxelId_;

		private NetworkPlayersManager manager_;

		private HideAndSeekModel model_;

		private HideAndSeekMyPlayerController myPlayerController_;

		private NetworkCombatManager networkCombatManager_;

		private IPlayersOnline playersOnline_;

		private BroadPurchaseOnline purchaseOnline_;

		private IGameOnline pvpOnline_;

		private SocketsHideAndSeekOnline sockets_;

		private IInventoryLogic inventory_;

		private HideAndSeekVoxelsController voxelsController_;

		private ScoreCounterHud scoreCounterHud_;

		public override void Dispose()
		{
			playersOnline_.PlayerSideChangeReceived -= HandlePlayerSideChangeRecieved;
			pvpOnline_.StartStageReceived -= HandleStartStageRecieved;
			playersOnline_.PlayerExit -= HandlePlayerExit;
			playersOnline_.SyncInstance -= HandleSyncInstance;
			holder.ModelAdded -= HandleModelAdded;
			manager_.ActorAdded -= HandleActorAdded;
			myPlayerStatsModel.stats.hideAndSeek.RoleChanged -= HandleMyRoleChanged;
			myPlayerStatsModel.stats.hideAndSeek.HiddenChanged -= HandleMyVoxelPositionUpdated;
			myPlayerStatsModel.stats.hideAndSeek.SelectedHideVoxelChanged -= HandleMyPlayerSelectedHideVoxelChanged;
			myPlayerStatsModel.stats.Died -= HandleDied;
			myPlayerStatsModel.stats.Ressurected -= HandleDied;
			model_.CastingStarted -= HandleCastingStarted;
			model_.HidersAmountChanged -= HandleHidersAmountChanged;
			sockets_.PlayerAppear -= HandlePlayerAppear;
			sockets_.PlayerHide -= HandlePlayerHide;
			sockets_.PlayerHideVoxelSelect -= HandlePlayerHideVoxelSelect;
			sockets_.HideResponceReceived -= HandleResponceReceived;
			sockets_.SelectHideVoxelResponceReceived -= HandleResponceReceived;
			sockets_.SeekResponceReceived -= HandleSeekResponse;
			sockets_.PlayerSeek -= HandlePlayerSeek;
			foreach (PlayerStatsModel value in holder.Models.Values)
			{
				value.allowArtikulChange = true;
			}
			myPlayerStatsModel.stats.BodyType = BodyType.DEFAULT;
		}

		public override void Init()
		{
			base.Init();
			SingletonManager.Get<HideAndSeekModel>(out model_);
			SingletonManager.Get<NetworkPlayersManager>(out manager_);
			SingletonManager.Get<IGameOnline>(out pvpOnline_);
			SingletonManager.Get<IPlayersOnline>(out playersOnline_);
			SingletonManager.Get<SocketsHideAndSeekOnline>(out sockets_);
			SingletonManager.Get<HideAndSeekMyPlayerController>(out myPlayerController_);
			SingletonManager.Get<BroadPurchaseOnline>(out purchaseOnline_);
			SingletonManager.Get<NetworkCombatManager>(out networkCombatManager_);
			SingletonManager.Get<HideAndSeekVoxelsController>(out voxelsController_);
			SingletonManager.Get<IInventoryLogic>(out inventory_);
			playersOnline_.PlayerSideChangeReceived += HandlePlayerSideChangeRecieved;
			pvpOnline_.StartStageReceived += HandleStartStageRecieved;
			playersOnline_.PlayerExit += HandlePlayerExit;
			playersOnline_.SyncInstance += HandleSyncInstance;
			holder.ModelAdded += HandleModelAdded;
			manager_.ActorAdded += HandleActorAdded;
			myPlayerStatsModel.stats.hideAndSeek.RoleChanged += HandleMyRoleChanged;
			myPlayerStatsModel.stats.hideAndSeek.HiddenChanged += HandleMyVoxelPositionUpdated;
			myPlayerStatsModel.stats.hideAndSeek.SelectedHideVoxelChanged += HandleMyPlayerSelectedHideVoxelChanged;
			myPlayerStatsModel.stats.Died += HandleDied;
			myPlayerStatsModel.stats.Ressurected += HandleDied;
			model_.CastingStarted += HandleCastingStarted;
			model_.HidersAmountChanged += HandleHidersAmountChanged;
			sockets_.PlayerAppear += HandlePlayerAppear;
			sockets_.PlayerHide += HandlePlayerHide;
			sockets_.PlayerHideVoxelSelect += HandlePlayerHideVoxelSelect;
			sockets_.HideResponceReceived += HandleResponceReceived;
			sockets_.SelectHideVoxelResponceReceived += HandleResponceReceived;
			sockets_.SeekResponceReceived += HandleSeekResponse;
			sockets_.PlayerSeek += HandlePlayerSeek;
			GuiModuleHolder.Get<ScoreCounterHud>(out scoreCounterHud_);
		}

		private void HandleHidersAmountChanged()
		{
			scoreCounterHud_.stageNameCount = model_.HidersAmount;
			scoreCounterHud_.RefreshNotification();
		}

		private void HandleDied()
		{
			HandleDied(myPlayerStatsModel.stats);
			foreach (PlayerStatsModel value in holder.Models.Values)
			{
				SetSide(value, value.Side);
			}
		}

		private void HandleDied(PlayerStatsModel playerModel)
		{
			SetSide(playerModel, 4);
			RefreshPlayer(playerModel);
			RefreshAmount();
		}

		private void RefreshAmount()
		{
			int num = 0;
			foreach (PlayerStatsModel value in holder.Models.Values)
			{
				SetSide(value, value.Side);
				if (value.Side == 3)
				{
					num++;
				}
			}
			model_.HidersAmount = num;
		}

		private void HandleMyRoleChanged()
		{
			HandleRoleChanged(myPlayerStatsModel.stats);
		}

		public override void OnSyncRecieved()
		{
			allowNotifications_ = true;
			PlayerSyncMessage message;
			if (SyncManager.TryRead<PlayerSyncMessage>(out message) && message.pvpBattle != null && message.pvpBattle.Length > 0)
			{
				PvpBattleMessage pvpBattleMessage = message.pvpBattle[0];
				if (pvpBattleMessage.defaultHideVoxelId > 0)
				{
					model_.DefaultHideVoxel = HideAndSeekContentMap.HideVoxels[pvpBattleMessage.defaultHideVoxelId];
				}
				if (pvpBattleMessage.hideVoxelId > 0)
				{
					myPlayerStatsModel.stats.hideAndSeek.HideVoxelId = pvpBattleMessage.hideVoxelId;
				}
			}
		}

		private void HandleActorAdded(PlayerMessage message, PlayerStatsModel model)
		{
			TrySetArtikul(model, message.hideVoxelId);
		}

		private void HandleAnySeek(SeekBasicMessage basic)
		{
			PlayerStatsModel value;
			if (holder.Models.TryGetValue(basic.target, out value))
			{
				SetPosition(value, basic.x, basic.y, basic.z);
				value.hideAndSeek.Appear();
				if (basic.membersUpdate != null)
				{
					UpdateMembers(basic.membersUpdate);
				}
			}
		}

		private void HandleCastingStarted()
		{
			sockets_.SendHideCastCommand();
		}

		private void HandleModelAdded(PlayerStatsModel model)
		{
			model.hideAndSeek = new PlayerHideAndSeekModel();
			model.hideAndSeek.SelectedHideVoxelChanged += delegate
			{
				RefreshPlayer(model);
			};
			model.hideAndSeek.HiddenChanged += delegate
			{
				RefreshPlayer(model);
			};
			model.hideAndSeek.RoleChanged += delegate
			{
				HandleRoleChanged(model);
			};
			model.Died += delegate
			{
				HandleDied(model);
			};
			model.Ressurected += delegate
			{
				RefreshPlayer(model);
			};
			RefreshPlayer(model);
		}

		private void HandleRoleChanged(PlayerStatsModel model)
		{
			switch (model.hideAndSeek.Role)
			{
			case HideAndSeekRole.Monstr:
				model.BodyType = 16;
				break;
			case HideAndSeekRole.Hider:
				model.BodyType = 8;
				break;
			default:
				model.BodyType = BodyType.DEFAULT;
				break;
			}
		}

		private void HandleMyPlayerSelectedHideVoxelChanged()
		{
			RefreshPlayer(myPlayerStatsModel.stats);
			if (allowNotifications_ && lastSentHideVoxelId_ != myPlayerStatsModel.stats.hideAndSeek.HideVoxelId)
			{
				lastSentHideVoxelId_ = myPlayerStatsModel.stats.hideAndSeek.HideVoxelId;
				sockets_.SendHideVoxelSelectCommand(myPlayerStatsModel.stats.hideAndSeek.HideVoxelId);
			}
		}

		private void HandleMyVoxelPositionUpdated()
		{
			RefreshPlayer(myPlayerStatsModel.stats);
			PlayerHideAndSeekModel hideAndSeek = myPlayerStatsModel.stats.hideAndSeek;
			if (allowNotifications_ && !silent)
			{
				if (hideAndSeek.IsHidden)
				{
					sockets_.SendHideCommand(hideAndSeek.HidePosition, hideAndSeek.HideRotation);
				}
				else
				{
					sockets_.SendAppearCommand();
				}
			}
		}

		private void HandlePlayerAppear(RemoteMessageEventArgs args)
		{
			PlayerAppearMessage playerAppearMessage = (PlayerAppearMessage)args.remoteMessage;
			PlayerStatsModel value;
			if (holder.Models.TryGetValue(playerAppearMessage.persId, out value))
			{
				SetPosition(value, playerAppearMessage.x, playerAppearMessage.y, playerAppearMessage.z);
				value.hideAndSeek.Appear();
			}
		}

		private void HandlePlayerExit(RemoteMessageEventArgs obj)
		{
			OnHiderChanged();
		}

		private void HandlePlayerHide(RemoteMessageEventArgs args)
		{
			PlayerHideMessage playerHideMessage = (PlayerHideMessage)args.remoteMessage;
			PlayerStatsModel value;
			if (holder.Models.TryGetValue(playerHideMessage.persId, out value))
			{
				HidePlayer(value, playerHideMessage);
			}
		}

		private void HandlePlayerHideVoxelSelect(RemoteMessageEventArgs args)
		{
			PlayerHideVoxelSelectMessage playerHideVoxelSelectMessage = (PlayerHideVoxelSelectMessage)args.remoteMessage;
			PlayerStatsModel value;
			if (holder.Models.TryGetValue(playerHideVoxelSelectMessage.persId, out value))
			{
				value.hideAndSeek.HideVoxelId = playerHideVoxelSelectMessage.voxelId;
			}
		}

		private void HandlePlayerSeek(RemoteMessageEventArgs args)
		{
			PlayerSeekMessage playerSeekMessage = (PlayerSeekMessage)args.remoteMessage;
			HandleAnySeek(playerSeekMessage);
			networkCombatManager_.Hit(playerSeekMessage.actor, playerSeekMessage.target, playerSeekMessage.health);
		}

		private void HandlePlayerSideChangeRecieved(RemoteMessageEventArgs args)
		{
			ChangePlayersSideMessage changePlayersSideMessage = (ChangePlayersSideMessage)args.remoteMessage;
			UpdateStagePlayers(changePlayersSideMessage.stagePlayers);
		}

		private void HandleResponceReceived(RemoteMessageEventArgs obj)
		{
			purchaseOnline_.Report(obj.remoteMessage as PurchaseMessage);
		}

		private void HandleSeekResponse(RemoteMessageEventArgs args)
		{
			SeekMessage seekMessage = (SeekMessage)args.remoteMessage;
			if (seekMessage.damage != 0)
			{
				HandleAnySeek(seekMessage);
				networkCombatManager_.HitResponce(seekMessage.target, seekMessage.health, seekMessage.slotUpdate);
				purchaseOnline_.Report(seekMessage);
			}
		}

		private void HandleStartStageRecieved(RemoteMessageEventArgs args)
		{
			StartStageMessage startStageMessage = (StartStageMessage)args.remoteMessage;
			UpdateStagePlayers(startStageMessage.stagePlayers, startStageMessage.stage);
			RefreshPlayer(myPlayerStatsModel.stats);
		}

		private void HandleSyncInstance(RemoteMessageEventArgs obj)
		{
			OnHiderChanged();
			SyncInstanceMessage syncInstanceMessage = (SyncInstanceMessage)obj.remoteMessage;
			currentStage_ = syncInstanceMessage.stage;
			PlayerMessage[] players = syncInstanceMessage.players;
			foreach (PlayerMessage playerMessage in players)
			{
				PlayerStatsModel value;
				if (holder.Models.TryGetValue(playerMessage.persId, out value))
				{
					SetSide(value, playerMessage.side);
					TrySetArtikul(value, playerMessage.hideVoxelId);
					if (playerMessage.hidePosition != null)
					{
						HidePlayer(value, playerMessage.hidePosition);
					}
				}
			}
			UpdateVisiblity();
			RefreshPlayer(myPlayerStatsModel.stats);
		}

		private void HidePlayer(PlayerStatsModel model, PlayerHideMessage message)
		{
			model.hideAndSeek.HideVoxelId = message.voxelId;
			if (model.IsMyPlayer)
			{
				myPlayerController_.HidePlayerBySync(message);
			}
			else
			{
				model.hideAndSeek.Hide(new VoxelKey(message.x, message.y, message.z), (byte)message.rotation);
			}
		}

		private void OnHiderChanged()
		{
			TryFindLastHider();
		}

		private void RefreshPlayer(PlayerStatsModel model)
		{
			model.visibility.ByGameLogic = !model.hideAndSeek.IsHidden;
			model.visibility.ByPlayerSide = model.Side == myPlayerStatsModel.stats.Side || currentStage_ != 2;
			UpdateRole(model);
			UpdateSelectedArtikul(model);
			model.visibility.ByGameLogic = !model.hideAndSeek.IsHidden;
			UpdateVoxel(model);
		}

		private void UpdateVoxel(PlayerStatsModel model)
		{
			if (model.hideAndSeek.IsHidden)
			{
				model_.TryAddHiddenPlayer(model.hideAndSeek.HidePosition);
				if (model.InMyPlayerTeam || currentStage_ > 2)
				{
					voxelsController_.SetPlayerVoxel(model.hideAndSeek.HidePosition, model.hideAndSeek.HideRotation, model.hideAndSeek.VoxelId);
				}
			}
			else
			{
				model_.TryRemoveHiddenPlayer(model.hideAndSeek.HidePosition);
				voxelsController_.SetPlayerVoxel(model.hideAndSeek.LastHidePosition, 0, 0);
			}
		}

		private void UpdateRole(PlayerStatsModel model)
		{
			HideAndSeekRole role = ((!model.IsDead) ? ((currentStage_ == 0) ? HideAndSeekRole.Idle : ((model.Side != 3) ? HideAndSeekRole.Seeker : (model.hideAndSeek.IsHidden ? HideAndSeekRole.Hidden : ((currentStage_ != 4) ? HideAndSeekRole.Hider : HideAndSeekRole.Monstr)))) : HideAndSeekRole.Dead);
			model.hideAndSeek.Role = role;
		}

		private void SetPosition(PlayerStatsModel model, float x, float y, float z)
		{
			model.SetPosition(new Vector3(x, y, z), false);
			model.visibility.ByServerPosition = true;
		}

		private void SetSide(PlayerStatsModel model, int side)
		{
			bool inMyPlayerTeam = model.persId == myPlayerStatsModel.stats.persId || side == myPlayerStatsModel.stats.Side;
			model.SetSide(side, inMyPlayerTeam);
		}

		private void UpdateSelectedArtikul(PlayerStatsModel model)
		{
			model.allowArtikulChange = true;
			model.SelectedArtikul = ((!model.hideAndSeek.IsHidden && !model.hideAndSeek.IsHider) ? inventory_.Model.SelectedSlot.ArtikulId : model.hideAndSeek.ArtikulId);
			model.allowArtikulChange = model.hideAndSeek.HasItems;
		}

		private void TryFindLastHider()
		{
			int num = 0;
			PlayerStatsModel playerStatsModel = null;
			foreach (PlayerStatsModel value in holder.Models.Values)
			{
				value.hideAndSeek.isLastHider = false;
				if (value.Side == 3)
				{
					num++;
					if (num == 1)
					{
						playerStatsModel = value;
					}
				}
			}
			if (playerStatsModel != null)
			{
				playerStatsModel.hideAndSeek.isLastHider = true;
			}
		}

		private void TrySetArtikul(PlayerStatsModel model, int hideVoxelId)
		{
			if (model.Side == 3 && hideVoxelId > 0)
			{
				model.hideAndSeek.HideVoxelId = hideVoxelId;
			}
		}

		private void UpdateStagePlayers(StagePlayerMessage[] stagePlayers, int stage = -1)
		{
			myPlayerStatsModel.stats.allowSpawnReport = true;
			if (stage >= 0)
			{
				currentStage_ = stage;
			}
			if (stagePlayers == null)
			{
				UpdateVisiblity();
				return;
			}
			foreach (StagePlayerMessage stagePlayerMessage in stagePlayers)
			{
				if (stagePlayerMessage.persId == myPlayerStatsModel.stats.persId)
				{
					SetSide(myPlayerStatsModel.stats, stagePlayerMessage.side);
					if (stagePlayerMessage.hideVoxelId > 0)
					{
						model_.DefaultHideVoxel = HideAndSeekContentMap.HideVoxels[stagePlayerMessage.hideVoxelId];
					}
					break;
				}
			}
			bool flag = stage == 0;
			foreach (StagePlayerMessage stagePlayerMessage2 in stagePlayers)
			{
				PlayerStatsModel value;
				if (holder.Models.TryGetValue(stagePlayerMessage2.persId, out value))
				{
					SetSide(value, stagePlayerMessage2.side);
					if (flag && !value.IsMyPlayer)
					{
						value.visibility.ByServerPosition = false;
					}
					if (flag || stagePlayerMessage2.hideVoxelId == 0)
					{
						value.hideAndSeek.Appear();
						value.ResetPlayerHealth();
					}
					else
					{
						TrySetArtikul(value, stagePlayerMessage2.hideVoxelId);
					}
					if (stagePlayerMessage2.position != null && stagePlayerMessage2.rotation != null)
					{
						value.SetPosition(stagePlayerMessage2.position.ToVector3(), stagePlayerMessage2.rotation.ToVector3(), false);
					}
				}
			}
			UpdateVisiblity();
		}

		private void UpdateVisiblity()
		{
			foreach (PlayerStatsModel value in holder.Models.Values)
			{
				RefreshPlayer(value);
			}
			RefreshAmount();
		}
	}
}
