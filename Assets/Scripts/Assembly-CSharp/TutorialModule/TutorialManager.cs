using System.Collections.Generic;
using Prompts;
using WindowsModule;

namespace TutorialModule
{
	public class TutorialManager
	{
		private int currentIndex_;

		private PromptHolder currentPrompt_;

		private TutorialState currentStateHolder_;

		private PromptsManager promptsManager_;

		private List<TutorialState> states_;

		private TutorialStates tutorialStates_;

		private TutorialView view_;

		private WindowsManager windowsManager_;

		public TutorialManager(int mode, int promptId = 0)
		{
			SingletonManager.Get<PromptsManager>(out promptsManager_);
			SingletonManager.Get<WindowsManager>(out windowsManager_);
			DataStorage.forbidDropToLoot = true;
			view_ = new TutorialView();
			tutorialStates_ = new TutorialStates();
			switch (mode)
			{
			case 1:
				states_ = tutorialStates_.controlStates;
				currentIndex_ = -1;
				promptsManager_.PromptActivated += HandlePromptActivatedForAttack;
				Push();
				break;
			case 2:
				promptsManager_.PromptActivated += HandlePromptActivatedForCraft;
				promptsManager_.freeMode = true;
				promptsManager_.ShowActualPrompt();
				break;
			default:
				Log.Error("Unable to get tutorial states for {0}", mode);
				Close();
				break;
			}
		}

		public void Terminate()
		{
			promptsManager_.Clear();
			DataStorage.forbidDropToLoot = false;
			promptsManager_.PromptActivated -= HandlePromptActivatedForCraft;
			if (currentStateHolder_ != null)
			{
				currentStateHolder_.OnComplete();
				RemoveState();
			}
		}

		internal static TutorialManager Init(int id)
		{
			TutorialManager result = null;
			if (id == PromptsMap.Tutorial.TUTORIAL_LEVEL_ID)
			{
				result = new TutorialManager(1);
			}
			return result;
		}

		internal static TutorialManager LateInit(int id)
		{
			TutorialManager result = null;
			switch (id)
			{
			case 9:
				result = new TutorialManager(2);
				break;
			case 5:
				result = new TutorialManager(2, 119);
				break;
			}
			return result;
		}

		private void Close()
		{
			DataStorage.forbidDropToLoot = false;
			if (view_.Hierarchy == null)
			{
				try
				{
					Terminate();
					return;
				}
				catch
				{
					return;
				}
			}
			windowsManager_.allowAnimations = true;
			view_.Close();
			if (currentPrompt_ != null)
			{
				currentPrompt_.completed = true;
			}
			tutorialStates_.craftStates = null;
			promptsManager_.freeMode = true;
			promptsManager_.ShowActualPrompt();
		}

		private void HandlePromptActivatedForAttack(int obj)
		{
			if (obj == 126)
			{
				currentPrompt_ = promptsManager_.CurrentPrompt;
				states_ = tutorialStates_.attackStates;
				currentIndex_ = -1;
				Push();
			}
		}

		private void HandlePromptActivatedForCraft(int obj)
		{
		}

		private void HandleStateCompleted()
		{
			RemoveState();
			Push();
		}

		private void HandleStateFailed(bool critical)
		{
			RemoveState();
			if (critical)
			{
				Close();
			}
			else
			{
				Pull();
			}
		}

		private void Pull()
		{
			currentIndex_--;
			if (currentIndex_ < 0)
			{
				Close();
			}
			else
			{
				SetState(states_[currentIndex_]);
			}
		}

		private void Push()
		{
			currentIndex_++;
			if (currentIndex_ >= states_.Count)
			{
				Close();
			}
			else
			{
				SetState(states_[currentIndex_]);
			}
		}

		private void RemoveState()
		{
			currentStateHolder_.Completed -= HandleStateCompleted;
			currentStateHolder_.Failed -= HandleStateFailed;
			currentStateHolder_ = null;
		}

		private void SetState(TutorialState state)
		{
			if (view_.Hierarchy == null)
			{
				try
				{
					Terminate();
					return;
				}
				catch
				{
					return;
				}
			}
			currentStateHolder_ = state;
			windowsManager_.allowAnimations = false;
			state.Completed += HandleStateCompleted;
			state.Failed += HandleStateFailed;
			state.Start();
			view_.Update(currentStateHolder_);
		}
	}
}
