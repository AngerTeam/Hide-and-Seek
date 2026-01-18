using System;
using System.Collections.Generic;
using BattleStats;
using Extensions;
using UnityEngine;

[Serializable]
public class GameModel : Singleton
{
	public BattleStatsTableFormat battleStatsTableFormat;

	private GameStateType currentGameStateType_;

	private int currentGameHudState_;

	public bool developer;

	public bool manageSoloLoot;

	public bool lobby;

	public bool editor;

	public bool editorExited;

	private bool prime_;

	public bool afterPrime;

	public bool primeRepeat;

	public bool tutorialCompleted;

	public bool minmalDataLoaded;

	public bool permanentDataLoaded;

	public bool levelLoaded;

	public bool restartPending;

	public bool lvlUpChecked;

	public bool rated;

	public bool rateNotNeeded;

	public bool mapRateDone;

	public bool adDone;

	public bool playerViewer;

	public bool showEnemyNickname;

	private StageModel currentStage_;

	public GameModeModel gameMode;

	public Dictionary<int, StageModel> stages;

	public string[][] stageTitles;

	public Vector3 SpawnPosition { get; set; }

	public Vector3 Spawnrotation { get; set; }

	public GameStateType CurrentGameStateType
	{
		get
		{
			return currentGameStateType_;
		}
		set
		{
			if (currentGameStateType_ != value)
			{
				currentGameStateType_ = value;
				this.CurrentGameStateTypeChanged.SafeInvoke(currentGameStateType_);
			}
		}
	}

	public int CurrentGameHudState
	{
		get
		{
			return currentGameHudState_;
		}
		set
		{
			currentGameHudState_ = value;
			this.CurrentGameHudStateChanged.SafeInvoke();
		}
	}

	public bool prime
	{
		get
		{
			return prime_;
		}
		set
		{
			if (prime_ != value)
			{
				Log.Info("Prime = {0}", value);
				prime_ = value;
			}
		}
	}

	public StageModel CurrentStage
	{
		get
		{
			return currentStage_;
		}
		set
		{
			if (currentStage_ != value)
			{
				currentStage_ = value;
				this.StageChanged.SafeInvoke();
			}
		}
	}

	public event Action<GameStateType> CurrentGameStateTypeChanged;

	public event Action CurrentGameHudStateChanged;

	public event Action StageChanged;

	public void Reset()
	{
		this.CurrentGameStateTypeChanged = null;
		this.CurrentGameHudStateChanged = null;
		lobby = true;
		developer = false;
		editor = false;
		editorExited = false;
		prime = false;
		afterPrime = false;
		tutorialCompleted = false;
		minmalDataLoaded = false;
		permanentDataLoaded = false;
		levelLoaded = false;
		restartPending = false;
	}

	public string GetStageName(int side)
	{
		if (stageTitles != null && CurrentStage != null && stageTitles.Length > CurrentStage.id)
		{
			string[] array = stageTitles[CurrentStage.id];
			if (array != null && array.Length > side)
			{
				return array[side];
			}
		}
		return null;
	}
}
