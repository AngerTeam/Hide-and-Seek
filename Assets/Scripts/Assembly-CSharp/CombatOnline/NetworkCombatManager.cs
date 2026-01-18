using System;
using System.Collections.Generic;
using Combat;
using CraftyNetworkEngine;
using CraftyVoxelEngine;
using Extensions;
using InventoryModule;
using PlayerModule;
using PlayerModule.MyPlayer;
using PlayerModule.Playmate;
using ProjectilesModule;
using RemoteData;
using RemoteData.Socket;
using UnityEngine;

namespace CombatOnline
{
	public class NetworkCombatManager : NetworkBasicPlayersManager
	{
		private CombatInteraction combatInteraction_;

		private MyPlayerStatsModel myPlayerStatsModel_;

		private MyPlayerModuleController myPlayerModuleController_;

		private IPvpOnline pvpOnline_;

		private WearController wearController_;

		private PlayerModelsHolder playerModelsHolder_;

		private InventoryModel inventoryModel_;

		private ProjectilesManager projectilesManager_;

		private VoxelEngine voxelEngine_;

		public event Action<string, KillMessageType> KillSucceseded;

		public event Action PlayerInteracted;

		public override void Dispose()
		{
			myPlayerModuleController_.Fallen -= KillMe;
			pvpOnline_.HitResponseReceivedLowPriority -= OnHitResponseReceived;
			pvpOnline_.HitReceived -= OnHitReceived;
			pvpOnline_.HitResponseReceivedHighPriority -= OnHitResponseReceivedHighPriority;
			pvpOnline_.DeathResponseReceived -= OnDeathResponseReceived;
			pvpOnline_.DeathReceived -= OnDeathReceived;
			pvpOnline_.ProjectileShotResponseReceived -= OnProjectileShotResponseReceived;
			pvpOnline_.ProjectileShotReceived -= OnProjectileShotReceived;
			pvpOnline_.ProjectileHitResponseReceived -= OnProjectileHitResponseReceived;
			pvpOnline_.ProjectileHitReceived -= OnProjectileHitReceived;
			combatInteraction_.MyPlayerHitEnemy -= HandleMyPlayerHitEnemy;
			combatInteraction_.MyPlayerProjectileShot -= HandleMyPlayerProjectileShot;
			combatInteraction_.MyPlayerProjectileHit -= HandleMyPlayerProjectileHit;
		}

		public void Hit(string attackerId, string targetId, int health, MemberMessage[] membersUpdate = null, VectorMessage pushDirection = null, int artikulId = 0)
		{
			combatInteraction_.DoHit(attackerId, targetId, health);
			bool flag = attackerId == myPlayerStatsModel_.stats.persId;
			bool flag2 = targetId == myPlayerStatsModel_.stats.persId;
			PlaymateEntity actor = combatInteraction_.GetActor(attackerId);
			if (actor != null && !actor.Model.IsDead && flag2)
			{
				actor.Model.combat.attackedMyPlayerMoment = Time.time;
				this.PlayerInteracted.SafeInvoke();
			}
			if (pushDirection != null)
			{
				float pushForce = 0f;
				ArtikulsEntries value;
				if (InventoryContentMap.Artikuls.TryGetValue(artikulId, out value))
				{
					pushForce = value.hit_repulsion_force;
				}
				if (flag2)
				{
					myPlayerStatsModel_.stats.InvokePushPlayer(pushDirection.ToVector3(), pushForce);
				}
				else if (!flag)
				{
					PlaymateEntity actor2 = combatInteraction_.GetActor(targetId);
					if (actor2 != null)
					{
						actor2.Model.InvokeBlinkRed();
					}
				}
			}
			if (membersUpdate != null && targetId != myPlayerStatsModel_.stats.persId)
			{
				ShowKillMessage(membersUpdate, true);
			}
		}

		public void HitResponce(string target, int health, SlotMessage[] slotMessage = null, MemberMessage[] membersUpdate = null)
		{
			combatInteraction_.DoHit(target, health);
			PlayerStatsModel value;
			if (playerModelsHolder_.Models.TryGetValue(target, out value) && !value.IsDead)
			{
				value.combat.attackedMyPlayerMoment = Time.time;
				this.PlayerInteracted.SafeInvoke();
			}
			if (slotMessage != null)
			{
				ApplySlotMessage(slotMessage);
			}
			if (membersUpdate != null)
			{
				ShowKillMessage(membersUpdate);
			}
		}

		public override void Init()
		{
			SingletonManager.Get<IPvpOnline>(out pvpOnline_);
			SingletonManager.Get<CombatInteraction>(out combatInteraction_);
			SingletonManager.Get<WearController>(out wearController_);
			SingletonManager.Get<MyPlayerStatsModel>(out myPlayerStatsModel_);
			SingletonManager.Get<PlayerModelsHolder>(out playerModelsHolder_);
			SingletonManager.Get<InventoryModel>(out inventoryModel_);
			SingletonManager.Get<ProjectilesManager>(out projectilesManager_);
			SingletonManager.Get<VoxelEngine>(out voxelEngine_);
			myPlayerStatsModel_.stats.Died += ModelPlayerDied;
			SingletonManager.Get<IPvpOnline>(out pvpOnline_);
			SingletonManager.Get<MyPlayerModuleController>(out myPlayerModuleController_);
			pvpOnline_.HitResponseReceivedLowPriority += OnHitResponseReceived;
			pvpOnline_.HitReceived += OnHitReceived;
			pvpOnline_.HitResponseReceivedHighPriority += OnHitResponseReceivedHighPriority;
			pvpOnline_.DeathResponseReceived += OnDeathResponseReceived;
			pvpOnline_.DeathReceived += OnDeathReceived;
			pvpOnline_.ProjectileShotResponseReceived += OnProjectileShotResponseReceived;
			pvpOnline_.ProjectileShotReceived += OnProjectileShotReceived;
			pvpOnline_.ProjectileHitResponseReceived += OnProjectileHitResponseReceived;
			pvpOnline_.ProjectileHitReceived += OnProjectileHitReceived;
			myPlayerModuleController_.Fallen += KillMe;
			base.Init();
		}

		public override void OnDataLoaded()
		{
			combatInteraction_.MyPlayerHitEnemy += HandleMyPlayerHitEnemy;
			combatInteraction_.MyPlayerProjectileShot += HandleMyPlayerProjectileShot;
			combatInteraction_.MyPlayerProjectileHit += HandleMyPlayerProjectileHit;
		}

		private void HandleMyPlayerHitEnemy(string persId, Vector3 direction)
		{
			pvpOnline_.SendHit(persId, 1, direction);
		}

		private void HandleMyPlayerProjectileHit(int clientProjectileId, Vector3 point, string[] targets, List<VoxelKey> voxels)
		{
			pvpOnline_.SendProjectileHit(clientProjectileId, point, targets, voxels);
		}

		private void HandleMyPlayerProjectileShot(int? artikulId, Vector3 direction, Vector3[] trajectory)
		{
			pvpOnline_.SendProjectileShot(artikulId, direction, trajectory);
		}

		private void KillMe()
		{
			pvpOnline_.SendDeath();
		}

		private void ModelPlayerDied()
		{
			myPlayerStatsModel_.stats.StreakCurrent = 0;
		}

		private void OnDeathReceived(RemoteMessageEventArgs e)
		{
			DeathMessage deathMessage = (DeathMessage)e.remoteMessage;
			combatInteraction_.DoHit(deathMessage.persId, deathMessage.persId, 0);
			if (deathMessage.membersUpdate != null)
			{
				UpdateMembers(deathMessage.membersUpdate);
			}
		}

		private void OnDeathResponseReceived(RemoteMessageEventArgs args)
		{
			DeathResponse deathResponse = (DeathResponse)args.remoteMessage;
			if (deathResponse.membersUpdate != null)
			{
				UpdateMembers(deathResponse.membersUpdate);
			}
		}

		private void OnHitReceived(RemoteMessageEventArgs e)
		{
			HitMessage hitMessage = (HitMessage)e.remoteMessage;
			Hit(hitMessage.actor, hitMessage.target, hitMessage.health, hitMessage.membersUpdate, hitMessage.direction, hitMessage.artikulId);
			PlayerStatsModel value;
			if (holder.Models.TryGetValue(hitMessage.actor, out value))
			{
				value.visibility.ByGameLogic = true;
			}
			if (hitMessage.membersUpdate != null)
			{
				UpdateMembers(hitMessage.membersUpdate);
			}
			if (hitMessage.teamData != null)
			{
				ReportStatsRecieved(hitMessage.teamData, myPlayerStatsModel.stats.Side);
			}
		}

		private void OnHitResponseReceived(RemoteMessageEventArgs args)
		{
			HitResponseMessage hitResponseMessage = (HitResponseMessage)args.remoteMessage;
			if (hitResponseMessage.membersUpdate != null)
			{
				UpdateMembers(hitResponseMessage.membersUpdate);
			}
			if (hitResponseMessage.teamData != null)
			{
				ReportStatsRecieved(hitResponseMessage.teamData, myPlayerStatsModel.stats.Side);
			}
		}

		private void OnHitResponseReceivedHighPriority(RemoteMessageEventArgs e)
		{
			HitResponseMessage hitResponseMessage = (HitResponseMessage)e.remoteMessage;
			HitResponce(hitResponseMessage.target, hitResponseMessage.health, hitResponseMessage.slotUpdate, hitResponseMessage.membersUpdate);
		}

		private void OnProjectileShotReceived(RemoteMessageEventArgs e)
		{
			PlayerProjectileShotMessage playerProjectileShotMessage = (PlayerProjectileShotMessage)e.remoteMessage;
			Vector3[] trajectory = new List<VectorMessage>(playerProjectileShotMessage.trajectory).ConvertAll((VectorMessage v) => v.ToVector3()).ToArray();
			combatInteraction_.DoProjectileShot(playerProjectileShotMessage.persId, trajectory, playerProjectileShotMessage.projectileId);
		}

		private void OnProjectileShotResponseReceived(RemoteMessageEventArgs args)
		{
			ProjectileShotResponse projectileShotResponse = (ProjectileShotResponse)args.remoteMessage;
			if (projectileShotResponse.slotUpdate != null)
			{
				SlotUpdateMessage[] slotUpdate = projectileShotResponse.slotUpdate;
				foreach (SlotUpdateMessage slotUpdateMessage in slotUpdate)
				{
					SlotModel slot;
					inventoryModel_.GetSlotByName(slotUpdateMessage.slotId, out slot);
					myPlayerStatsModel_.stats.GrenadeAmmo--;
					slot.Item.Amount = slotUpdateMessage.count;
					if (slot.Item.Amount == 0)
					{
						slot.Clear();
					}
				}
				ApplyUpdateSlots(projectileShotResponse.slotUpdate);
			}
			projectilesManager_.SetResponsedClientProjectileId(projectileShotResponse.clientProjectileId);
		}

		public void ApplyUpdateSlots(SlotUpdateMessage[] slotUpdate)
		{
			foreach (SlotUpdateMessage slotUpdateMessage in slotUpdate)
			{
				if (slotUpdateMessage.artikulId == 0)
				{
					wearController_.Clear(slotUpdateMessage.slotId);
					continue;
				}
				wearController_.UpdateSlotWear(slotUpdateMessage.slotId, slotUpdateMessage.wear);
				SlotModel slot;
				inventoryModel_.GetSlotByName(slotUpdateMessage.slotId, out slot);
				slot.Item.Amount = slotUpdateMessage.count;
				if (slot.Item.Amount == 0)
				{
					slot.Clear();
				}
			}
		}

		public void ApplySlotMessage(SlotMessage[] slotMessages)
		{
			foreach (SlotMessage slotMessage in slotMessages)
			{
				if (slotMessage.artikulId == 0)
				{
					wearController_.Clear(slotMessage.slotId);
				}
				else
				{
					wearController_.UpdateSlotWear(slotMessage.slotId, slotMessage.wear);
				}
			}
		}

		private void OnProjectileHitReceived(RemoteMessageEventArgs e)
		{
			PlayerProjectileHitMessage playerProjectileHitMessage = (PlayerProjectileHitMessage)e.remoteMessage;
			ProjectileHit(playerProjectileHitMessage.actor, playerProjectileHitMessage.projectileId, playerProjectileHitMessage.playersDamageList, playerProjectileHitMessage.voxelChangeList, playerProjectileHitMessage.membersUpdate, playerProjectileHitMessage.teamData);
		}

		private void OnProjectileHitResponseReceived(RemoteMessageEventArgs args)
		{
			ProjectileHitResponse projectileHitResponse = (ProjectileHitResponse)args.remoteMessage;
			ProjectileHit(myPlayerStatsModel_.stats.persId, 0, projectileHitResponse.playersDamageList, projectileHitResponse.voxelChangeList, projectileHitResponse.membersUpdate, projectileHitResponse.teamData);
		}

		private void ProjectileHit(string actor, int clientProjectileId, PlayerDamageMessage[] playerDamageList, VoxelMessage[] voxelChangeList, MemberMessage[] membersUpdate, TeamDataMessage[] teamData)
		{
			foreach (PlayerDamageMessage playerDamageMessage in playerDamageList)
			{
				Hit(actor, playerDamageMessage.target, playerDamageMessage.health, membersUpdate);
			}
			foreach (VoxelMessage voxelMessage in voxelChangeList)
			{
				VoxelKey voxelKey = new VoxelKey(voxelMessage.x, voxelMessage.y, voxelMessage.z);
				DestroyVoxel(voxelKey, voxelMessage.voxelId, voxelMessage.rotation);
			}
			if (membersUpdate != null)
			{
				UpdateMembers(membersUpdate);
			}
			if (teamData != null)
			{
				ReportStatsRecieved(teamData, myPlayerStatsModel.stats.Side);
			}
			projectilesManager_.ExplodeProjectile(clientProjectileId);
		}

		public void ShowKillMessage(MemberMessage[] memberMessages, bool assist = false)
		{
			foreach (MemberMessage memberMessage in memberMessages)
			{
				if (!(memberMessage.persId == myPlayerStatsModel_.stats.persId))
				{
					continue;
				}
				if (assist)
				{
					this.KillSucceseded.SafeInvoke(Localisations.Get("UI_Message_Kill_Assist"), KillMessageType.Assist);
					break;
				}
				myPlayerStatsModel_.stats.StreakCurrent++;
				if (myPlayerStatsModel_.stats.StreakCurrent > memberMessage.series)
				{
					myPlayerStatsModel_.stats.StreakCurrent = memberMessage.series;
				}
				if (myPlayerStatsModel_.stats.StreakCurrent == 2)
				{
					this.KillSucceseded.SafeInvoke(Localisations.Get("UI_Message_Double_Kill"), KillMessageType.KillStreak);
				}
				else if (myPlayerStatsModel_.stats.StreakCurrent > 2)
				{
					this.KillSucceseded.SafeInvoke(string.Format("{0}{1}", Localisations.Get("UI_Message_Kill_Streak"), myPlayerStatsModel_.stats.StreakCurrent), KillMessageType.KillStreak);
				}
				else
				{
					this.KillSucceseded.SafeInvoke(Localisations.Get("UI_Message_Kill"), KillMessageType.Kill);
				}
				break;
			}
		}

		private void DestroyVoxel(VoxelKey voxelKey, int voxelId, int voxelRotation)
		{
			int chunkIndex3d;
			int localVoxelIndex3D;
			VoxelMath.GlobalKeyToIndex3D(voxelKey, out chunkIndex3d, out localVoxelIndex3D);
			voxelEngine_.voxelActions.SetVoxel(voxelKey, (ushort)voxelId, (byte)voxelRotation, false, default(Vector3), 0, false);
		}
	}
}
