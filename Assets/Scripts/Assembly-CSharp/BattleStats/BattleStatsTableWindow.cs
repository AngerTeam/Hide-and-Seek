using System;
using System.Collections.Generic;
using BattleStats.Hierarchy;
using ChestsViewModule;
using CraftyEngine.Utils;
using Extensions;
using FriendsModule;
using HudSystem;
using NguiTools;
using PlayerModule;
using UnityEngine;
using WindowsModule;

namespace BattleStats
{
	public class BattleStatsTableWindow : GameWindow
	{
		private List<BattleStatsItemController> controllers_;

		private List<BattleStatsItemController> controllersToRemove_;

		private BattleStatsTableType currentWindowType_;

		private int fullSizeContent_;

		private BattleStatsTableWindowHierarchy hierarchy_;

		private PlayerModelsHolder playersHolder_;

		private PrefabsManagerNGUI prefabsManager_;

		private BattleStatsRawHierarchy titleRow_;

		private BattleStatsRawHierarchy titleSecondRow_;

		private FriendsController friendsController_;

		private bool isResult_;

		private string rowPrefabName_;

		private int myTeamKills_;

		private int enemyTeamKills_;

		private UnityTimerManager timerManager_;

		private Color playerRowColor_ = new Color(0f, 1f, 0.3372549f, 0.8f);

		public bool allowContinue;

		private BattleStatsTableFormat format_;

		private bool friendsModuleAvalible_;

		private ChestRewardWidgetController rewadController_;

		private bool locked_;

		public event Action HomeButtonClicked;

		public event Action NextButtonClicked;

		public event Action ContinueButtonClicked;

		public BattleStatsTableWindow(BattleStatsTableFormat format)
			: base(false)
		{
			format_ = format;
			base.HudState = 40960;
			SingletonManager.Get<PlayerModelsHolder>(out playersHolder_);
			SingletonManager.Get<PrefabsManagerNGUI>(out prefabsManager_);
			SingletonManager.Get<UnityTimerManager>(out timerManager_);
			GameModel singlton;
			SingletonManager.Get<GameModel>(out singlton);
			friendsModuleAvalible_ = SingletonManager.TryGet<FriendsController>(out friendsController_);
			rowPrefabName_ = format_.RowPrefabName;
			prefabsManager_.Load("BattleStatsPrefabsHolder");
			hierarchy_ = prefabsManager_.InstantiateNGUIIn<BattleStatsTableWindowHierarchy>("UIBattleStatsTableWindow", nguiManager.UiRoot.gameObject);
			format.SetHierarchy(hierarchy_);
			ButtonSet.Up(hierarchy_.nextButton.button, ReportNextButtonClicked, ButtonSetGroup.InWindow);
			ButtonSet.Up(hierarchy_.homeButton.button, ReportHomeButtonClicked, ButtonSetGroup.InWindow);
			hierarchy_.continueButton.widget.gameObject.SetActive(false);
			SetContent(hierarchy_.transform, true, true, false, false, true);
			string nextButtonTitle = format_.NextButtonTitle;
			hierarchy_.nextButton.label.text = Localisations.Get(nextButtonTitle);
			rewadController_ = new ChestRewardWidgetController(hierarchy_.rewardWidget.transform);
			hierarchy_.homeButton.label.text = Localisations.Get("UI_Battle_Table_BackBtn");
			format_.Organize();
			format.SetTitle();
			hierarchy_.continueButton.widget.gameObject.SetActive(true);
			hierarchy_.continueButton.label.text = Localisations.Get("UI_Continue");
			ButtonSet.Up(hierarchy_.continueButton.button, Continue, ButtonSetGroup.InWindow);
			titleRow_ = prefabsManager_.InstantiateNGUIIn<BattleStatsRawHierarchy>(rowPrefabName_, hierarchy_.tableTitleContainer.gameObject);
			format_.SetupTitleRow(titleRow_);
			SetupRow(titleRow_, true);
			if (format_.TwoTeams)
			{
				titleSecondRow_ = prefabsManager_.InstantiateNGUIIn<BattleStatsRawHierarchy>(rowPrefabName_, hierarchy_.tableTitleSecondContainer.gameObject);
				format_.SetupTitleRow(titleSecondRow_);
				SetupRow(titleSecondRow_, true);
			}
			controllers_ = new List<BattleStatsItemController>();
			controllersToRemove_ = new List<BattleStatsItemController>();
		}

		public void Continue()
		{
			ToggleWindow();
			Unlock();
			SetWindowType(BattleStatsTableType.Basic);
			this.ContinueButtonClicked.SafeInvoke();
		}

		public override void Dispose()
		{
			rewadController_.Dispose();
			controllers_.Clear();
			controllers_ = null;
			base.Dispose();
		}

		public void SetWindowType(BattleStatsTableType type)
		{
			currentWindowType_ = type;
			isResult_ = currentWindowType_ == BattleStatsTableType.Result;
			base.HudState = ((!isResult_) ? 40960 : 0);
			hierarchy_.blackBackground.gameObject.SetActive(isResult_);
			base.Hierarchy.closeButton.gameObject.SetActive(!isResult_);
			Reposition();
			CheckResult();
		}

		public void SetCloseButton(bool isActive)
		{
			if (isActive)
			{
				UnityTimer unityTimer = timerManager_.SetTimer();
				unityTimer.Completeted += delegate
				{
					if (base.Hierarchy != null)
					{
						base.Hierarchy.closeButton.gameObject.SetActive(true);
					}
				};
			}
			else
			{
				base.Hierarchy.closeButton.gameObject.SetActive(false);
			}
		}

		public void OnGetPlayerInfo(string persId)
		{
			if (friendsModuleAvalible_)
			{
				friendsController_.GetPlayerInfo(persId);
			}
			windowsManager.ToggleWindow<PlayerInfoWindow>();
		}

		public void ToggleWindow()
		{
			windowsManager.ToggleWindow(this);
			Reposition();
			if (Visible)
			{
				hierarchy_.scrollBar.value = 0f;
			}
		}

		public void SetTimer(string time, bool critical)
		{
			hierarchy_.timerText.text = time;
			if (critical)
			{
				hierarchy_.timerText.color = Color.red;
				hierarchy_.timerTween.ResetToBeginning();
				hierarchy_.timerTween.PlayForward();
			}
			else
			{
				hierarchy_.timerText.color = Color.white;
			}
		}

		public void SetTeamStats(TeamStats[] teamStats)
		{
			if (!format_.TwoTeams)
			{
				return;
			}
			foreach (TeamStats teamStats2 in teamStats)
			{
				string text = ((teamStats2.leavers <= 0) ? string.Empty : string.Format("{0}:{1}", Localisations.Get("UI_Leavers"), teamStats2.leavers));
				if (teamStats2.isMyPlayerTeam)
				{
					myTeamKills_ = teamStats2.kills;
					hierarchy_.myTeamScoreLabel.text = myTeamKills_.ToString();
					hierarchy_.myTeamLeaversLabel.text = text;
				}
				else
				{
					enemyTeamKills_ = teamStats2.kills;
					hierarchy_.enemyTeamScoreLabel.text = enemyTeamKills_.ToString();
					hierarchy_.enemyTeamLeaversLabel.text = text;
				}
			}
			CheckResult();
		}

		private void CheckResult()
		{
			if (isResult_)
			{
				hierarchy_.resultWidget.gameObject.SetActive(true);
				hierarchy_.timerWidget.gameObject.SetActive(false);
				format_.SetResult(myTeamKills_, enemyTeamKills_);
			}
			else
			{
				hierarchy_.resultWidget.gameObject.SetActive(false);
				hierarchy_.timerWidget.gameObject.SetActive(true);
			}
		}

		public void UpdateTable()
		{
			if (locked_)
			{
				return;
			}
			RefreshModelsAndControllers();
			TryAddNewControllers();
			controllers_.Sort(Sort);
			bool flag = false;
			bool flag2 = false;
			int num = ((!format_.TwoTeams) ? hierarchy_.rowStartY : hierarchy_.rowCompactStartY);
			int num2 = num;
			int num3 = 1;
			int num4 = 1;
			for (int i = 0; i < controllers_.Count; i++)
			{
				BattleStatsItemController battleStatsItemController = controllers_[i];
				PlayerStatsModel model = battleStatsItemController.model;
				BattleStatsRawHierarchy view = battleStatsItemController.view;
				if (model == null)
				{
					view.gameObject.SetActive(false);
					continue;
				}
				view.gameObject.SetActive(true);
				bool flag3 = !format_.TwoTeams || model.InMyPlayerTeam;
				bool active = !format_.TwoTeams && isResult_ && num3 <= 3;
				string persId = model.persId;
				view.place.icon.gameObject.SetActive(active);
				view.place.label.text = ((!flag3) ? num4.ToString() : num3.ToString());
				view.lvlLabel.text = string.Format("[{0}]", model.experiance.level);
				view.nickname.label.text = model.nickname;
				if (friendsModuleAvalible_)
				{
					ButtonSet.Up(view.infoButton, delegate
					{
						OnGetPlayerInfo(persId);
					}, ButtonSetGroup.InWindow);
				}
				else
				{
					view.infoButton.gameObject.SetActive(false);
				}
				format_.SetScore(view, model, isResult_);
				format_.SetLabelColor(view, model);
				UpdateReward(model, view);
				bool flag4;
				if (flag3)
				{
					flag4 = flag;
					flag = !flag;
				}
				else
				{
					flag4 = flag2;
					flag2 = !flag2;
				}
				Color backgroundColor = ((!model.IsMyPlayer) ? ((!flag4) ? new Color(1f, 1f, 1f, 0.3f) : new Color(0f, 0f, 0f, 0f)) : playerRowColor_);
				int num5 = ((!flag3) ? hierarchy_.rowCompactX : 0);
				int num6 = ((!flag3) ? num2 : num);
				Vector3 position = new Vector3(num5, num6, 0f);
				battleStatsItemController.MoveTo(position, backgroundColor);
				num6 += ((!format_.TwoTeams) ? hierarchy_.rowStepY : hierarchy_.rowCompactStepY);
				if (flag3)
				{
					num = num6;
				}
				else
				{
					num2 = num6;
				}
				if (flag3)
				{
					num3++;
				}
				else
				{
					num4++;
				}
			}
			Reposition();
			PlayResultAnimation();
		}

		private void UpdateReward(PlayerStatsModel model, BattleStatsRawHierarchy view)
		{
			bool flag = isResult_ && model.reward > 0;
			view.rewardIcon.gameObject.SetActive(isResult_);
			if (isResult_)
			{
				if (flag)
				{
					nguiManager.SetIconSprite(view.rewardIcon, model.reward.ToString());
					view.rewardIcon.alpha = 1f;
				}
				else
				{
					view.rewardIcon.alpha = 0f;
				}
			}
		}

		private void PlayResultAnimation()
		{
			if (isResult_)
			{
				BattleStatsTableAnimator battleStatsTableAnimator = new BattleStatsTableAnimator(hierarchy_, false);
				battleStatsTableAnimator.PlayResultAnimation();
			}
		}

		internal void Unlock()
		{
			locked_ = false;
		}

		internal void Lock()
		{
			locked_ = true;
		}

		private static int SortyByExp(BattleStatsItemController first, BattleStatsItemController second)
		{
			int num = second.model.BattleExperiance.CompareTo(first.model.BattleExperiance);
			if (num == 0)
			{
				int num2 = second.model.combat.KillFragsCount.CompareTo(first.model.combat.KillFragsCount);
				if (num2 == 0)
				{
					return first.model.persId.CompareTo(second.model.persId);
				}
				return num2;
			}
			return num;
		}

		private BattleStatsRawHierarchy AddTableRow()
		{
			BattleStatsRawHierarchy battleStatsRawHierarchy = prefabsManager_.InstantiateNGUIIn<BattleStatsRawHierarchy>(rowPrefabName_, hierarchy_.scrollPanel.gameObject);
			SetupRow(battleStatsRawHierarchy, false);
			return battleStatsRawHierarchy;
		}

		private void ReportHomeButtonClicked()
		{
			this.HomeButtonClicked.SafeInvoke();
		}

		private void ReportNextButtonClicked()
		{
			this.NextButtonClicked.SafeInvoke();
		}

		private void Reposition()
		{
			if (fullSizeContent_ == 0)
			{
				fullSizeContent_ = hierarchy_.content.height;
			}
			hierarchy_.homeButton.widget.gameObject.SetActive(isResult_);
			hierarchy_.nextButton.widget.gameObject.SetActive(isResult_);
			hierarchy_.continueButton.widget.gameObject.SetActive(isResult_ && allowContinue);
			base.Hierarchy.envelopContent.Execute();
			hierarchy_.buttonsTable.Reposition();
			hierarchy_.buttonsEnvelop.Execute();
			titleRow_.rewardIcon.gameObject.SetActive(isResult_);
			titleRow_.rewardLabel.text = string.Empty;
			titleRow_.tableLeft.Reposition();
			titleRow_.tableRight.Reposition();
			if (titleSecondRow_ != null)
			{
				titleSecondRow_.rewardIcon.gameObject.SetActive(isResult_);
				titleSecondRow_.rewardLabel.text = string.Empty;
				titleSecondRow_.tableLeft.Reposition();
				titleSecondRow_.tableRight.Reposition();
			}
			hierarchy_.content.height = ((!isResult_) ? hierarchy_.compactSizeContentHeight : fullSizeContent_);
			for (int i = 0; i < controllers_.Count; i++)
			{
				BattleStatsRawHierarchy view = controllers_[i].view;
				if (view != null && view.tableLeft.gameObject.activeInHierarchy)
				{
					view.tableLeft.Reposition();
					view.tableRight.Reposition();
				}
			}
		}

		private void SetupRow(BattleStatsRawHierarchy newRow, bool enableTitle)
		{
			newRow.arrowDownSprite.alpha = 0f;
			newRow.arrowUpSprite.alpha = 0f;
			newRow.kills.Set(enableTitle);
			newRow.nickname.Set(enableTitle);
			newRow.place.Set(enableTitle);
			newRow.score.Set(enableTitle);
			newRow.info.Set(enableTitle);
			newRow.info.gameObject.SetActive(friendsModuleAvalible_);
		}

		private int Sort(BattleStatsItemController first, BattleStatsItemController second)
		{
			if (first.model == null || second.model == null)
			{
				return 0;
			}
			if (currentWindowType_ == BattleStatsTableType.Basic)
			{
				return SortyByExp(first, second);
			}
			int num = first.model.place.CompareTo(second.model.place);
			if (num == 0)
			{
				return SortyByExp(first, second);
			}
			return num;
		}

		private void TryAddNewControllers()
		{
			foreach (PlayerStatsModel value in playersHolder_.Models.Values)
			{
				bool flag = false;
				for (int i = 0; i < controllers_.Count; i++)
				{
					if (controllers_[i].model.persId == value.persId)
					{
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					BattleStatsItemController battleStatsItemController = new BattleStatsItemController();
					battleStatsItemController.Init(AddTableRow(), value);
					controllers_.Add(battleStatsItemController);
				}
				if (value.place == 0)
				{
					value.place = int.MaxValue;
				}
			}
		}

		private void RefreshModelsAndControllers()
		{
			for (int i = 0; i < controllers_.Count; i++)
			{
				BattleStatsItemController battleStatsItemController = controllers_[i];
				PlayerStatsModel value;
				if (playersHolder_.Models.TryGetValue(battleStatsItemController.model.persId, out value))
				{
					battleStatsItemController.model = value;
				}
				else
				{
					controllersToRemove_.Add(controllers_[i]);
				}
			}
			for (int j = 0; j < controllersToRemove_.Count; j++)
			{
				BattleStatsItemController battleStatsItemController2 = controllersToRemove_[j];
				UnityEngine.Object.Destroy(battleStatsItemController2.view.gameObject);
				controllers_.Remove(battleStatsItemController2);
			}
			controllersToRemove_.Clear();
		}
	}
}
