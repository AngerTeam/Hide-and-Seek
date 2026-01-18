using System;
using CraftyEngine.Infrastructure;
using CraftyEngine.Utils;
using ExceptionsModule;
using Extensions;
using PlayerModule;
using RemoteData.Socket;
using UnityEngine;

namespace CraftyNetworkEngine
{
	public class NetworkPlayersManager : NetworkBasicPlayersManager
	{
		public bool enabled;

		private GreedyCounter errorCounter_;

		private IGameOnline gameOnline_;

		private PlayerModelsHolder playersHolder_;

		private UnityEvent unityEvent_;

		private IPlayersOnline playersOnline_;

		private bool synced_;

		private float lastServerUpdateTime_;

		private float nextUpdateTime_;

		private ExceptionsManager exceptionsManager_;

		public event Action<PlayerMessage, PlayerStatsModel> ActorAdded;

		public event Action StatsUpdated;

		public override void Dispose()
		{
			gameOnline_.PvpExitSent -= HandlePvpExitSent;
			myPlayerStatsModel.stats.SideChanged -= UpdateOtherPlayersSides;
			errorCounter_.Stop();
			unityEvent_.Unsubscribe(UnityEventType.Update, UnityUpdate);
			exceptionsManager_.RemoveHandler(ExceptionHandler);
		}

		public override void Init()
		{
			enabled = true;
			SingletonManager.Get<IGameOnline>(out gameOnline_);
			SingletonManager.Get<IPlayersOnline>(out playersOnline_);
			SingletonManager.Get<PlayerModelsHolder>(out playersHolder_);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			SingletonManager.Get<ExceptionsManager>(out exceptionsManager_);
			errorCounter_ = new GreedyCounter(8, 2f);
			errorCounter_.CriticalAmountReached += ReportDesynced;
			errorCounter_.Start();
			gameOnline_.InstanceResultsRecieved += HandleInstanceResultsRecieved;
			gameOnline_.InstanceStopped += HandleInstanceStopped;
			gameOnline_.StartStageReceived += HandleStartStageRecieved;
			gameOnline_.PvpExitSent += HandlePvpExitSent;
			playersOnline_.ActorsStatusChanged += HandleActorsStatusChanged;
			playersOnline_.PlayerExit += HandlePlayerExit;
			playersOnline_.PlayerIn += HandlePlayerIn;
			playersOnline_.PlayerSideChangeReceived += HandlePlayerSideChangeRecieved;
			playersOnline_.PlayerSpawn += HandlePlayerSpawn;
			playersOnline_.SkinChangeReceived += HandleSkinChangeRecieved;
			playersOnline_.SyncInstance += HandleSyncInstance;
			nextUpdateTime_ = Time.time + DataStorage.updateRateNetwork;
			unityEvent_.Subscribe(UnityEventType.Update, UnityUpdate);
			exceptionsManager_.AddHandler(ExceptionHandler, 3202);
			base.Init();
		}

		private void ReportDesynced()
		{
			if (synced_)
			{
				synced_ = false;
				Exc.Report(3202);
			}
		}

		private bool ExceptionHandler(ExceptionArgs args)
		{
			playersOnline_.ResyncInstance();
			return true;
		}

		private void HandlePvpExitSent()
		{
			synced_ = false;
		}

		public override void OnLogicLoaded()
		{
			myPlayerStatsModel.stats.SideChanged += UpdateOtherPlayersSides;
			playersHolder_.AddRemoteModel(myPlayerStatsModel.stats);
		}

		private PlayerStatsModel AddRemoteModel(PlayerMessage actorData)
		{
			PlayerStatsModel value;
			if (!playersHolder_.Models.TryGetValue(actorData.persId, out value))
			{
				value = MessageToModel(actorData, GetPlaymateTeam(actorData.side));
				playersHolder_.AddRemoteModel(value);
				value.visibility.ByServerPosition = false;
				this.ActorAdded.SafeInvoke(actorData, value);
			}
			return value;
		}

		private PlayerStatsModel MessageToModel(PlayerMessage actorData, bool inMyPlayerTeam)
		{
			PlayerStatsModel playerStatsModel = new PlayerStatsModel();
			playerStatsModel.visibility.ByServerPosition = false;
			playerStatsModel.persId = actorData.persId;
			playerStatsModel.visibility.persId = actorData.persId;
			playerStatsModel.HealthCurrent = actorData.health;
			playerStatsModel.nickname = actorData.name;
			playerStatsModel.SkinId = actorData.skinId;
			playerStatsModel.SetSpawnTime((int)actorData.started);
			playerStatsModel.experiance.level = actorData.level;
			playerStatsModel.SetSide(actorData.side, inMyPlayerTeam);
			return playerStatsModel;
		}

		private void UnityUpdate()
		{
			if (Time.time >= nextUpdateTime_)
			{
				nextUpdateTime_ += DataStorage.updateRateNetwork;
				NetworkUpdate();
			}
		}

		public override void OnSyncRecieved()
		{
			playersOnline_.ResyncInstance();
		}

		private void HandleActorsStatusChanged(RemoteMessageEventArgs args)
		{
			lastServerUpdateTime_ = Time.time;
			if (!synced_ || !enabled)
			{
				return;
			}
			PlayersUpdateMessage playersUpdateMessage = (PlayersUpdateMessage)args.remoteMessage;
			PlayerStatusMessage[] players = playersUpdateMessage.players;
			foreach (PlayerStatusMessage playerStatusMessage in players)
			{
				PlayerStatsModel value;
				if (playersHolder_.Models.TryGetValue(playerStatusMessage.persId, out value) && !value.IsMyPlayer)
				{
					if (!value.IsDead)
					{
						value.SetPosition(playerStatusMessage.position.ToVector3(), playerStatusMessage.rotation.ToVector3());
						value.visibility.ByServerPosition = true;
					}
					value.SelectedArtikul = (ushort)playerStatusMessage.selectedArtikulId;
					if (value.IsDead || value.HealthCurrent <= 0)
					{
						errorCounter_.PushError();
					}
				}
			}
			PlayerStatusMessage[] players2 = playersUpdateMessage.players;
			foreach (PlayerStatusMessage playerStatusMessage2 in players2)
			{
				if (!(playerStatusMessage2.persId == myPlayerStatsModel.stats.persId))
				{
					PlayerStatsModel value2;
					if (playersHolder_.Models.TryGetValue(playerStatusMessage2.persId, out value2))
					{
						value2.action = playerStatusMessage2.action;
					}
					else
					{
						ReportDesynced();
					}
				}
			}
		}

		private void HandleInstanceResultsRecieved(RemoteMessageEventArgs obj)
		{
			InstanceTopMessage instanceTopMessage = (InstanceTopMessage)obj.remoteMessage;
			foreach (PlayerStatsModel value2 in playersHolder_.Models.Values)
			{
				value2.place = int.MaxValue;
				value2.points = 0;
				value2.reward = 0;
				if (value2.hideAndSeek != null)
				{
					value2.hideAndSeek.isLastHider = value2.persId == instanceTopMessage.lastHider;
				}
			}
			if (instanceTopMessage.top != null)
			{
				SetTopStats(instanceTopMessage.top);
			}
			else if (instanceTopMessage.teamTop != null)
			{
				TeamTopMessage[] teamTop = instanceTopMessage.teamTop;
				foreach (TeamTopMessage teamTopMessage in teamTop)
				{
					SetTopStats(teamTopMessage.top);
				}
			}
			if (instanceTopMessage.teamData != null)
			{
				ReportStatsRecieved(instanceTopMessage.teamData, myPlayerStatsModel.stats.Side);
			}
			TopRewardMessage[] topRewards = instanceTopMessage.topRewards;
			foreach (TopRewardMessage topRewardMessage in topRewards)
			{
				PlayerStatsModel value;
				if (playersHolder_.Models.TryGetValue(topRewardMessage.persId, out value))
				{
					value.reward = topRewardMessage.chestArtikulId;
					continue;
				}
				Log.Error("Unbale to find pers {0} in {1}", topRewardMessage.persId, ArrayUtils.ArrayToString(playersHolder_.Models.Keys));
			}
			playersHolder_.ReportStatsChanged();
			this.StatsUpdated.SafeInvoke();
		}

		private void HandleInstanceStopped(RemoteMessageEventArgs obj)
		{
			synced_ = false;
			foreach (PlayerStatsModel value in playersHolder_.Models.Values)
			{
				value.action = 0;
				if (!value.IsMyPlayer)
				{
					value.visibility.ByGameState = false;
				}
			}
		}

		private void HandlePlayerExit(RemoteMessageEventArgs obj)
		{
			PlayerExitMessage playerExitMessage = (PlayerExitMessage)obj.remoteMessage;
			playersHolder_.RemoveRemoteModel(playerExitMessage.persId);
		}

		private void HandlePlayerIn(RemoteMessageEventArgs obj)
		{
			PlayerInMessage playerInMessage = (PlayerInMessage)obj.remoteMessage;
			AddRemoteModel(playerInMessage.player);
		}

		private void HandlePlayerSideChangeRecieved(RemoteMessageEventArgs args)
		{
			ChangePlayersSideMessage changePlayersSideMessage = (ChangePlayersSideMessage)args.remoteMessage;
			UpdateStagePlayers(changePlayersSideMessage.stagePlayers);
		}

		private void HandlePlayerSpawn(RemoteMessageEventArgs obj)
		{
			PlayerSpawnMessage playerSpawnMessage = (PlayerSpawnMessage)obj.remoteMessage;
			PlayerStatsModel value;
			if (playersHolder_.Models.TryGetValue(playerSpawnMessage.persId, out value))
			{
				UpdateRemoteModel(value, playerSpawnMessage.health, playerSpawnMessage.started);
			}
			else
			{
				ReportDesynced();
			}
		}

		private void HandleSkinChangeRecieved(RemoteMessageEventArgs args)
		{
			ChangeSkinMessage changeSkinMessage = (ChangeSkinMessage)args.remoteMessage;
			PlayerStatsModel value;
			if (playersHolder_.Models.TryGetValue(changeSkinMessage.persId, out value))
			{
				value.SkinId = changeSkinMessage.skinId;
			}
		}

		private void HandleStartStageRecieved(RemoteMessageEventArgs args)
		{
			StartStageMessage startStageMessage = (StartStageMessage)args.remoteMessage;
			UpdateMembers(startStageMessage.membersUpdate);
			UpdateStagePlayers(startStageMessage.stagePlayers);
		}

		private void HandleSyncInstance(RemoteMessageEventArgs obj)
		{
			SyncInstanceMessage syncInstanceMessage = (SyncInstanceMessage)obj.remoteMessage;
			foreach (PlayerStatsModel value2 in playersHolder_.Models.Values)
			{
				if (!value2.IsMyPlayer)
				{
					value2.online = false;
				}
			}
			PlayerMessage[] players = syncInstanceMessage.players;
			foreach (PlayerMessage playerMessage in players)
			{
				PlayerStatsModel value;
				if (playersHolder_.Models.TryGetValue(playerMessage.persId, out value))
				{
					UpdateRemoteModel(value, playerMessage);
				}
				else
				{
					value = AddRemoteModel(playerMessage);
					this.ActorAdded.SafeInvoke(playerMessage, value);
				}
				value.online = true;
			}
			UpdateMembers(syncInstanceMessage.members);
			if (syncInstanceMessage.teamData != null)
			{
				ReportStatsRecieved(syncInstanceMessage.teamData, myPlayerStatsModel.stats.Side);
			}
			playersHolder_.UpdateOnlineState();
			myPlayerStatsModel.stats.reportSpawnPending = true;
			synced_ = true;
			lastServerUpdateTime_ = Time.time;
		}

		private void SetTopStats(TopMessage[] tops)
		{
			foreach (TopMessage topMessage in tops)
			{
				PlayerStatsModel value;
				if (playersHolder_.Models.TryGetValue(topMessage.persId, out value))
				{
					value.combat.KillFragsCount = topMessage.kills;
					value.BattleExperiance = topMessage.exp;
					value.place = topMessage.pos;
					value.points = topMessage.points;
				}
				else
				{
					Log.Error("Unbale to find pers {0} in {1}", topMessage.persId, ArrayUtils.ArrayToString(playersHolder_.Models.Keys));
				}
			}
		}

		private void UpdateOtherPlayersSides()
		{
			foreach (PlayerStatsModel value in playersHolder_.Models.Values)
			{
				if (!value.IsMyPlayer)
				{
					SetPlaymateSide(value, value.Side);
				}
			}
		}

		private void UpdateRemoteModel(PlayerStatsModel model, int health, double started)
		{
			model.HealthCurrent = health;
			model.SetSpawnTime((int)started);
		}

		private void UpdateRemoteModel(PlayerStatsModel model, PlayerMessage actorData)
		{
			UpdateRemoteModel(model, actorData.health, actorData.started);
			model.SkinId = actorData.skinId;
			SetPlaymateSide(model, actorData.side);
		}

		private void UpdateStagePlayers(StagePlayerMessage[] stagePlayers)
		{
			if (stagePlayers == null)
			{
				return;
			}
			foreach (StagePlayerMessage stagePlayerMessage in stagePlayers)
			{
				PlayerStatsModel value;
				if (!playersHolder_.Models.TryGetValue(stagePlayerMessage.persId, out value))
				{
					continue;
				}
				value.visibility.ByGameState = true;
				if (value.IsMyPlayer)
				{
					myPlayerStatsModel.stats.points = 0;
					if (stagePlayerMessage.position != null && stagePlayerMessage.rotation != null)
					{
						myPlayerStatsModel.stats.SetPosition(stagePlayerMessage.position.ToVector3(), stagePlayerMessage.rotation.ToVector3(), false);
					}
					continue;
				}
				value.points = 0;
				SetPlaymateSide(value, stagePlayerMessage.side);
				if (stagePlayerMessage.position != null && stagePlayerMessage.rotation != null)
				{
					value.SetPosition(stagePlayerMessage.position.ToVector3(), stagePlayerMessage.rotation.ToVector3(), false);
					if (!value.IsMyPlayer)
					{
						value.visibility.ByServerPosition = false;
					}
				}
			}
			playersHolder_.ReportStatsChanged();
		}

		private void NetworkUpdate()
		{
			if (synced_ && enabled && myPlayerStatsModel.Enable && !myPlayerStatsModel.stats.IsDead)
			{
				playersOnline_.SendMyPlayerPosition();
				if (lastServerUpdateTime_ - Time.time > 5f)
				{
					Exc.Report(3108);
				}
			}
		}
	}
}
