using AbilitiesModule;
using CombatOnline;
using CraftyNetworkEngine;
using PlayerModule;
using PlayerModule.Playmate;
using RemoteData.Socket;
using UnityEngine;

namespace AbilitiesOnlineModule
{
	public class NetworkAbilitiesManager : NetworkBasicPlayersManager
	{
		private NetworkCombatManager networkCombatManager_;

		private AbilitiesOnline abilitiesOnline_;

		private PlayerAbilityManager playerAbilityManager_;

		private PlaymatesActorsHolder actorsHolder_;

		public override void Init()
		{
			base.Init();
			SingletonManager.Get<AbilitiesOnline>(out abilitiesOnline_);
			SingletonManager.Get<PlayerAbilityManager>(out playerAbilityManager_);
			SingletonManager.Get<NetworkCombatManager>(out networkCombatManager_);
			SingletonManager.Get<PlaymatesActorsHolder>(out actorsHolder_);
		}

		public override void OnDataLoaded()
		{
			playerAbilityManager_.AbilityUsed += HandleAbilityUsed;
			abilitiesOnline_.AbilityUseResponseReceived += HandleAbilityUseResponse;
			abilitiesOnline_.PlayerAbilityUseReceived += HandlePlayerAbilityUse;
		}

		private void HandleAbilityUsed(string[] targets, Vector3 direction)
		{
			abilitiesOnline_.SendAbilityUse(targets, direction);
		}

		private void HandleAbilityUseResponse(RemoteMessageEventArgs args)
		{
			AbilityUseResponse abilityUseResponse = (AbilityUseResponse)args.remoteMessage;
			if (abilityUseResponse.damageList != null)
			{
				InflictDamage(myPlayerStatsModel.stats.persId, abilityUseResponse.damageList);
			}
			if (abilityUseResponse.membersUpdate != null)
			{
				UpdateMembers(abilityUseResponse.membersUpdate);
				networkCombatManager_.ShowKillMessage(abilityUseResponse.membersUpdate);
			}
			if (abilityUseResponse.teamData != null)
			{
				ReportStatsRecieved(abilityUseResponse.teamData, myPlayerStatsModel.stats.Side);
			}
			if (abilityUseResponse.slotUpdate != null)
			{
				networkCombatManager_.ApplyUpdateSlots(abilityUseResponse.slotUpdate);
			}
		}

		private void HandlePlayerAbilityUse(RemoteMessageEventArgs args)
		{
			PlayerAbilityUseMessage playerAbilityUseMessage = (PlayerAbilityUseMessage)args.remoteMessage;
			PlaymateEntity actor = actorsHolder_.GetActor(playerAbilityUseMessage.actor);
			actor.Controller.StartAbility();
			if (playerAbilityUseMessage.damageList != null)
			{
				InflictDamage(playerAbilityUseMessage.actor, playerAbilityUseMessage.damageList);
			}
			if (playerAbilityUseMessage.membersUpdate != null)
			{
				UpdateMembers(playerAbilityUseMessage.membersUpdate);
				networkCombatManager_.ShowKillMessage(playerAbilityUseMessage.membersUpdate, true);
			}
			if (playerAbilityUseMessage.teamData != null)
			{
				ReportStatsRecieved(playerAbilityUseMessage.teamData, myPlayerStatsModel.stats.Side);
			}
		}

		private void InflictDamage(string attackerId, DamageDataMessage[] damageList)
		{
			foreach (DamageDataMessage damageDataMessage in damageList)
			{
				if (attackerId == myPlayerStatsModel.stats.persId)
				{
					networkCombatManager_.HitResponce(damageDataMessage.target, damageDataMessage.health);
				}
				else
				{
					networkCombatManager_.Hit(attackerId, damageDataMessage.target, damageDataMessage.health);
				}
			}
		}

		public override void Dispose()
		{
			playerAbilityManager_.AbilityUsed -= HandleAbilityUsed;
			abilitiesOnline_.AbilityUseResponseReceived -= HandleAbilityUseResponse;
			abilitiesOnline_.PlayerAbilityUseReceived -= HandlePlayerAbilityUse;
		}
	}
}
