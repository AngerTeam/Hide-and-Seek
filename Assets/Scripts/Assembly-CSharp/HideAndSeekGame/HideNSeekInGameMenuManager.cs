using System;
using System.Diagnostics;
using CraftyVoxelEngine.Editor;
using Extensions;
using HudSystem;
using InGameMenuModule;
using NguiTools;
using UnityEngine;
using WindowsModule;

namespace HideAndSeekGame
{
	public class HideNSeekInGameMenuManager : Singleton, IRestoreInGameMenu, ISingleton
	{
		private GameMenuHud hud_;

		private DefaultInGameMenu menu_;

		private GameModel model_;

		private InGameMenuManager inGameMenuManager_;

		private UIButton currentModeButton_;

		private UIButton restoreButton_;

		private UILabel restoreButtonLabel_;

		public event Action RestoreButtonClicked;

		public override void Init()
		{
			SingletonManager.Get<GameModel>(out model_);
			SingletonManager.Get<InGameMenuManager>(out inGameMenuManager_);
			model_.CurrentGameStateTypeChanged += HandleCurrentGameStateTypeChanged;
		}

		public override void OnDataLoaded()
		{
			hud_ = GuiModuleHolder.Add<GameMenuHud>();
			hud_.ButtonClicked += HandleHudButtonClicked;
			menu_ = new DefaultInGameMenu();
			menu_.AddButton("UI_MainMenu_Settings", ToggleSettings);
			if (!CompileConstants.MOBILE || CompileConstants.EDITOR)
			{
				menu_.AddButton("Restart Game", RestartGame);
			}
			if (DataStorage.isAdmin)
			{
				menu_.AddButton("Toggle UI", ToggleAdminUi);
				if (!CompileConstants.EDITOR)
				{
					menu_.AddButton("Quit", Quit);
				}
			}
			menu_.AddButton("UI_Export", ToggleExporterUi);
			menu_.AddButton("UI_News_Button", ToggleNewsUi);
			menu_.ChangeLanguageReqested += RestartGame;
			menu_.Reposition();
		}

		private void RestoreServiceClicked()
		{
			this.RestoreButtonClicked.SafeInvoke();
		}

		public void EnableRestoreButton(bool enable)
		{
			if (menu_ != null)
			{
				restoreButton_ = menu_.AddButton("UI_BindGameCenter", RestoreServiceClicked);
				restoreButtonLabel_ = restoreButton_.GetComponentInChildren<UILabel>();
				menu_.Reposition();
			}
		}

		public void SetRestoreButtonText(string text)
		{
			if (restoreButtonLabel_ != null)
			{
				restoreButtonLabel_.text = Localisations.Get(text);
			}
		}

		private void RestartGame()
		{
			model_.restartPending = true;
		}

		private void ToggleSettings()
		{
			inGameMenuManager_.Toggle(5);
		}

		private void ToggleExporterUi()
		{
			WindowsManagerShortcut.ToggleWindow<ExporterWindow>();
		}

		private void ToggleNewsUi()
		{
			WindowsManagerShortcut.ToggleWindow<NewsWindow>();
		}

		private void HandleHudButtonClicked()
		{
			WindowsManagerShortcut.ToggleWindow(menu_);
		}

		public override void Dispose()
		{
			model_.CurrentGameStateTypeChanged -= HandleCurrentGameStateTypeChanged;
			if (hud_ != null)
			{
				hud_.ButtonClicked -= HandleHudButtonClicked;
			}
		}

		private void HandleCurrentGameStateTypeChanged(GameStateType state)
		{
			if (currentModeButton_ != null)
			{
				UnityEngine.Object.Destroy(currentModeButton_.gameObject);
				currentModeButton_ = null;
			}
			if (restoreButton_ != null)
			{
				UnityEngine.Object.Destroy(restoreButton_.gameObject);
				restoreButton_ = null;
				restoreButtonLabel_ = null;
			}
			if (menu_ == null)
			{
				return;
			}
			switch (state)
			{
			case GameStateType.Editor:
				if (model_.developer)
				{
					currentModeButton_ = menu_.AddButton("Toggle Frame", ToggleFrame);
				}
				else
				{
					currentModeButton_ = menu_.AddButton("UI_BackToLobby", ExitEditor);
				}
				break;
			case GameStateType.Prime:
			case GameStateType.Tutorial:
				currentModeButton_ = menu_.AddButton("UI_BackToLobby", ExitPrime);
				break;
			}
			menu_.Reposition();
			if (menu_.Visible)
			{
				WindowsManagerShortcut.ToggleWindow(menu_);
			}
		}

		private void ToggleFrame()
		{
			VoxelEditorModel voxelEditorModel = SingletonManager.Get<VoxelEditorModel>();
			voxelEditorModel.ToggleFrameMode();
		}

		private void ExitEditor()
		{
			PlayerVoxelEditorController singleton;
			if (SingletonManager.TryGet<PlayerVoxelEditorController>(out singleton))
			{
				singleton.EditorController.Exit();
			}
			else
			{
				Log.Error("Unable to get PlayerVoxelEditorController");
			}
		}

		private void ExitPrime()
		{
			DialogWindowManager.AskFor("UI_QuitGameConfirm", ExitPrimeAction);
		}

		private void ExitPrimeAction()
		{
			GameModel singlton;
			SingletonManager.Get<GameModel>(out singlton);
			singlton.prime = false;
		}

		private void Quit()
		{
			DialogWindowManager.AskFor("UI_QuitGameConfirm", QuitAction);
		}

		private void QuitAction()
		{
			if (CompileConstants.MOBILE)
			{
				Application.Quit();
			}
			else
			{
				Process.GetCurrentProcess().Kill();
			}
		}

		private void ToggleAdminUi()
		{
			NguiManager singlton;
			SingletonManager.Get<NguiManager>(out singlton);
			if (singlton != null)
			{
				singlton.UiRoot.UICamera.enabled = !singlton.UiRoot.UICamera.enabled;
			}
		}
	}
}
