using System.Collections.Generic;
using Combat;
using CraftyEngine.Utils;
using InventoryModule;
using LootModule;
using MobsModule.Content;
using PlayerModule;
using PlayerModule.Playmate;
using Prompts;
using ShapesModule;
using UnityEngine;

namespace TutorialModule
{
	public class TutorialStateAttack : TutorialStatePlayerControl
	{
		private ShapeInstance completeShape_;

		private LootItem lootItem_;

		private PlayerStatsModel mobModel_;

		private PlayerModelsHolder modelsHolder_;

		private PlaymatesActorsHolder actorsHolder_;

		private PromptsManager promptsManager_;

		private ArtikulsEntries weaponArticul_;

		private List<ShapeInstance> weaponFx;

		private CombatInteraction combatInteraction_;

		public TutorialStateAttack()
		{
			SingletonManager.Get<PlayerModelsHolder>(out modelsHolder_);
			SingletonManager.Get<PlaymatesActorsHolder>(out actorsHolder_);
			title = "Prompt_TutorialAttack";
			label.itemId = 13;
			label.anchor = TutorialAnchor.Right;
			weaponFx = new List<ShapeInstance>();
			promptsManager_ = SingletonManager.Get<PromptsManager>();
			promptsManager_.PromptActivated += HandlePromptActivated;
			ShapeManager shapeManager = SingletonManager.Get<ShapeManager>();
			foreach (ShapeInstance shape in shapeManager.Shapes)
			{
				if (shape.typeId == PromptsMap.Tutorial.FINISH_LEVEL_TASK)
				{
					completeShape_ = shape;
					completeShape_.Container.SetActive(false);
				}
				else if (shape.typeId == 3)
				{
					weaponFx.Add(shape);
					shape.Container.SetActive(false);
				}
			}
			SpawnLoot();
			SpawnMob();
		}

		public override void OnStart()
		{
			mobModel_.visibility.ByGameLogic = true;
			base.OnStart();
		}

		protected override void Update()
		{
			if (myPlayerStatsModel_.stats.action != 0)
			{
				Complete();
			}
		}

		private void HandleAttack(string persId, Vector3 vector)
		{
			int damage = weaponArticul_.damage;
			mobModel_.HealthCurrent -= damage;
			mobModel_.combat.attackedMyPlayerMoment = Time.time;
		}

		private void HandleHealthUpdated(int prev, int current, string persId)
		{
			if (mobModel_.IsDead)
			{
				UnityTimerManager singlton;
				SingletonManager.Get<UnityTimerManager>(out singlton);
				UnityTimer unityTimer = singlton.SetTimer();
				unityTimer.Completeted += delegate
				{
					completeShape_.Container.SetActive(true);
				};
				promptsManager_.CurrentPrompt.completed = true;
				promptsManager_.ShowActualPrompt();
				combatInteraction_.MyPlayerHitEnemy -= HandleAttack;
			}
		}

		private void HandlePromptActivated(int id)
		{
			switch (id)
			{
			case 125:
				lootItem_.GameObject.SetActive(true);
				{
					foreach (ShapeInstance item in weaponFx)
					{
						item.Container.SetActive(true);
					}
					break;
				}
			case 126:
				foreach (ShapeInstance item2 in weaponFx)
				{
					item2.Container.SetActive(false);
				}
				promptsManager_.PromptActivated -= HandlePromptActivated;
				break;
			}
		}

		private void SpawnLoot()
		{
			LootManager singleton;
			SingletonManager.TryGet<LootManager>(out singleton);
			if (singleton != null)
			{
				weaponArticul_ = InventoryContentMap.Artikuls[PromptsMap.Tutorial.TUTORIAL_WEAPON];
				Vector3 position = Vector3Utils.SafeParse(PromptsMap.Tutorial.TUTORIAL_WEAPON_PLACE);
				lootItem_ = singleton.SpawnLoot((ushort)weaponArticul_.id, position, null, null, 1, false, false, 0, true);
				lootItem_.GameObject.SetActive(false);
			}
		}

		private void SpawnMob()
		{
			mobModel_ = new PlayerStatsModel();
			mobModel_.BodyType = 4;
			mobModel_.MobId = PromptsMap.Tutorial.TUTORIAL_ENEMY_MOB;
			mobModel_.persId = string.Format("Mob_{0}", mobModel_.MobId);
			MobsEntries value;
			if (MobsContentMap.Mobs.TryGetValue(mobModel_.MobId, out value))
			{
				mobModel_.SkinId = mobModel_.MobId;
				mobModel_.HealthMax = value.hp;
				mobModel_.HealthCurrent = value.hp;
			}
			else
			{
				mobModel_.SkinId = PromptsMap.Tutorial.TUTORIAL_ENEMY_SKIN;
				mobModel_.HealthMax = PromptsMap.Tutorial.TUTORIAL_ENEMY_HEALTH;
				mobModel_.HealthCurrent = mobModel_.HealthMax;
			}
			mobModel_.nickname = Localisations.Get("TutorialEnemy");
			mobModel_.HealthChanged += HandleHealthUpdated;
			mobModel_.visibility.ByGameLogic = false;
			Vector3 position = Vector3Utils.SafeParse(PromptsMap.Tutorial.TUTORIAL_ENEMY_PLACE);
			mobModel_.SetPosition(position, Vector3.zero);
			modelsHolder_.AddRemoteModel(mobModel_);
			PlaymateEntity actor = actorsHolder_.GetActor(mobModel_.persId);
			actor.Controller.prebakeCorpse = true;
			SingletonManager.Get<CombatInteraction>(out combatInteraction_);
			combatInteraction_.MyPlayerHitEnemy += HandleAttack;
		}
	}
}
