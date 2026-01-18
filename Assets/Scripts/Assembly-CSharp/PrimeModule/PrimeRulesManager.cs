using System.Collections.Generic;
using BattleStats;
using CraftyVoxelEngine;
using HideAndSeek;
using MyPlayerInput;
using UnityEngine;

namespace PrimeModule
{
	public class PrimeRulesManager : Singleton
	{
		private GameModel gameModel_;

		private MyPlayerInputModel inputModel_;

		private PrimeModel model_;

		private VoxelInteractionModel voxelInteractionModel_;

		public override void Init()
		{
			SingletonManager.Get<PrimeModel>(out model_);
			SingletonManager.Get<GameModel>(out gameModel_);
			SingletonManager.Get<MyPlayerInputModel>(out inputModel_);
			SingletonManager.Get<VoxelInteractionModel>(out voxelInteractionModel_);
			int modeId = model_.modeId;
			gameModel_.gameMode = new GameModeModel
			{
				allowStats = true,
				supportTeams = (modeId == 3 || modeId == 5),
				twoTeams = (modeId == 3),
				continuable = (modeId == 5)
			};
			gameModel_.stages = new Dictionary<int, StageModel>();
			ServerMapSettings rules = model_.GetRules();
			inputModel_.criticalHeight = rules.critical_height;
			voxelInteractionModel_.allowDig = BitMath.GetBit(rules.flags, 0);
			voxelInteractionModel_.allowBuild = BitMath.GetBit(rules.flags, 1);
			SetupStages();
			SetupTitles(modeId);
			gameModel_.battleStatsTableFormat = GetStatsFormat(modeId);
			if (CompileConstants.EDITOR)
			{
				Log.Info("Rules: {0}", JsonUtility.ToJson(rules, true));
			}
		}

		private void AddStage(int id, int duration, bool allowCombat)
		{
			Log.Info("AddStage {0}: {1}", id, duration);
			gameModel_.stages[id] = new StageModel
			{
				id = id,
				duration = duration,
				allowCombat = allowCombat
			};
		}

		private BattleStatsTableFormat GetStatsFormat(int mode)
		{
			switch (mode)
			{
			case 5:
				return new BattleStatsTableHideAndSeekFormat();
			case 4:
				return new BattleStatsTableSandboxFormat();
			case 3:
				return new BattleStatsTableTwoTeamsFormat();
			default:
				return new BattleStatsTableDefaultFormat();
			}
		}

		private void SetupStages()
		{
			AddStage(0, model_.rules.idle_timeout, false);
			AddStage(1, model_.rules.ttl, true);
			AddStage(2, model_.rules.hide_timeout, false);
			AddStage(3, model_.rules.seek_timeout, true);
			AddStage(4, model_.rules.hide_fight_timeout, true);
			gameModel_.stages[1].criticalTime = true;
			gameModel_.stages[3].criticalTime = true;
		}

		private void SetupTitles(int mode)
		{
			if (mode == 5)
			{
				gameModel_.stageTitles = new string[5][];
				gameModel_.stageTitles[0] = new string[5];
				gameModel_.stageTitles[2] = new string[5];
				gameModel_.stageTitles[3] = new string[5];
				gameModel_.stageTitles[4] = new string[5];
				gameModel_.stageTitles[0][0] = "UI_HNS_Starting";
				gameModel_.stageTitles[2][4] = "UI_HNS_Wait";
				gameModel_.stageTitles[2][3] = "UI_HNS_Hide";
				gameModel_.stageTitles[3][4] = "UI_HNS_Seek";
				gameModel_.stageTitles[3][3] = "UI_HNS_Be_Quiet";
				gameModel_.stageTitles[4][4] = "UI_HNS_SeekerFight";
				gameModel_.stageTitles[4][3] = "UI_HNS_HiderFight";
			}
			else
			{
				gameModel_.stageTitles = null;
			}
		}
	}
}
