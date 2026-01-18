using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using CraftyEngine.Sounds;
using CraftyEngine.Utils.Unity;
using DG.Tweening;
using Extensions;
using HudSystem;
using NguiTools;
using UnityEngine;

namespace WindowsModule
{
	public class WindowsManager : Singleton
	{
		public GameObject conteiner;

		public Action ToggleInGameMenu;

		internal bool allowAnimations;

		private float animationTime = 0.4f;

		private CameraManager cameraManager_;

		private bool ignoreCamera_;

		private bool inited_;

		private KeyboardInputManager inputManager_;

		private NguiManager nguiManager_;

		private List<UIPanel> panelsSort_;

		private int totalDepth_;

		private List<GameWindow> visibleWindows_;

		public bool AnyWindowIsOpen
		{
			get
			{
				return visibleWindows_ != null && visibleWindows_.Count != 0;
			}
		}

		public GameWindow FrontWindow
		{
			get
			{
				if (AnyWindowIsOpen)
				{
					return visibleWindows_[FrontWindowIndex];
				}
				return null;
			}
		}

		private int FrontWindowIndex
		{
			get
			{
				return visibleWindows_.Count - 1;
			}
		}

		public event Action AnyWindowToggled;

		public event Action AllWindowsClosed;

		public event Action WindowsCountChanged;

		public WindowsManager()
		{
			WindowsManagerShortcut.instance = this;
		}

		public override void Init()
		{
			SingletonManager.Get<KeyboardInputManager>(out inputManager_);
			SingletonManager.Get<CameraManager>(out cameraManager_);
			inputManager_.ButtonReleased += HandleButtonReleased;
			if (inited_)
			{
				ignoreCamera_ = true;
				CloseAll();
				ignoreCamera_ = false;
				return;
			}
			inited_ = true;
			allowAnimations = true;
			panelsSort_ = new List<UIPanel>();
			SingletonManager.Get<NguiManager>(out nguiManager_);
			visibleWindows_ = new List<GameWindow>();
			conteiner = new GameObject("WindowsManager");
			conteiner.layer = 5;
			conteiner.AddChild<UIPanel>();
			conteiner.transform.SetParent(nguiManager_.UiRoot.transform, false);
			BlackBack(false);
		}

		public override void OnDataLoaded()
		{
			cameraManager_.SetVisiblePlease(this, true);
			ButtonSet.Up(nguiManager_.UiRoot.BlackBackButton, OnBlackBackClicked, ButtonSetGroup.InWindow);
		}

		public override void OnReset()
		{
			CloseAll();
			BlackBack(false);
		}

		public void ToggleWindow<T>() where T : class
		{
			T module;
			if (!GuiModuleHolder.TryGet<T>(out module))
			{
				Log.Error("{0} is not register in GuiModuleHolder", typeof(T));
				return;
			}
			GameWindow gameWindow = module as GameWindow;
			if (gameWindow == null)
			{
				Log.Error("{0} is not implement GameWindow interface", typeof(T));
			}
			else
			{
				ToggleWindow(gameWindow);
			}
		}

		public bool ToggleWindow(GameWindow actualWindow)
		{
			if (actualWindow.Visible && !actualWindow.closable)
			{
				return false;
			}
			UIInput.selection = null;
			int count = visibleWindows_.Count;
			bool wasVisible = SortVisibility(actualWindow);
			DistributeWindows(actualWindow, wasVisible);
			if (allowAnimations)
			{
				SoundProvider.PlayGroupSound2D((!actualWindow.Visible) ? 3 : 2, 1f);
			}
			if (visibleWindows_.Count != count && this.WindowsCountChanged != null)
			{
				this.WindowsCountChanged();
			}
			BlackBack(visibleWindows_.Count > 0);
			if (visibleWindows_.Count == 0 && count > 0 && this.AllWindowsClosed != null)
			{
				this.AllWindowsClosed();
				cameraManager_.SetVisiblePlease(this, true);
			}
			else if (actualWindow.HeavyGraphics && !ignoreCamera_)
			{
				cameraManager_.SetVisiblePlease(this, !actualWindow.Visible);
			}
			Log.Info("ToggleWindow {0}", actualWindow);
			this.AnyWindowToggled.SafeInvoke();
			return true;
		}

		internal void RegisterWindow(GameWindow window)
		{
			if (window.Hierarchy.closeButton != null)
			{
				ButtonSet.Up(window.Hierarchy.closeButton, delegate
				{
					ToggleWindow(window);
				}, ButtonSetGroup.Undefined);
			}
		}

		internal void UnregisterWindow(GameWindow gameWindow)
		{
			if (visibleWindows_.Contains(gameWindow))
			{
				visibleWindows_.Remove(gameWindow);
			}
		}

		private void ApplyVisible(GameWindow actualWindow)
		{
			if (actualWindow.Visible)
			{
				if (visibleWindows_.Contains(actualWindow))
				{
					visibleWindows_.Remove(actualWindow);
				}
				visibleWindows_.Add(actualWindow);
				return;
			}
			visibleWindows_.Remove(actualWindow);
			if (actualWindow.tween != null)
			{
				actualWindow.tween.Kill();
			}
			UIPanel panel = actualWindow.Hierarchy.panel;
			if (allowAnimations)
			{
				actualWindow.tween = DOTween.To(() => panel.alpha, delegate(float a)
				{
					panel.alpha = a;
				}, 0f, animationTime).OnComplete(delegate
				{
					HandleTweenComplete(actualWindow);
				});
			}
			else
			{
				panel.alpha = 0f;
				actualWindow.Conteiner.SetActive(false);
			}
		}

		private void HandleTweenComplete(GameWindow actualWindow)
		{
			if (actualWindow != null && actualWindow.Conteiner != null)
			{
				actualWindow.Conteiner.SetActive(false);
			}
		}

		private void BlackBack(bool enable)
		{
			nguiManager_.UiRoot.BlackBackWidget.gameObject.SetActive(enable);
		}

		private void ChangeFront(GameWindow frontWindow, GameWindow actualWindow)
		{
			if (frontWindow != null)
			{
				frontWindow.ReportIsFrontChanged(false);
			}
			if (actualWindow != null)
			{
				actualWindow.ReportIsFrontChanged(true);
			}
		}

		public void CloseAll()
		{
			allowAnimations = false;
			if (visibleWindows_ != null)
			{
				for (int num = visibleWindows_.Count - 1; num >= 0; num--)
				{
					ToggleWindow(visibleWindows_[num]);
				}
				this.WindowsCountChanged.SafeInvoke();
			}
			allowAnimations = true;
			BlackBack(false);
		}

		private void DistributeWindows(GameWindow actualWindow, bool wasVisible)
		{
			totalDepth_ = 301;
			for (int i = 0; i < visibleWindows_.Count; i++)
			{
				SortPanels(visibleWindows_[i]);
				GameWindow window = visibleWindows_[FrontWindowIndex - i];
				window.Conteiner.SetActive(true);
				UIPanel panel = window.Hierarchy.panel;
				bool flag = i == 0;
				GameObjectUtils.SwitchColliders(window.Hierarchy.gameObject, flag);
				if (window == actualWindow && !wasVisible)
				{
					panel.transform.localScale = Vector3.one + Vector3.one * 0.2f;
					panel.alpha = 0f;
				}
				if (window.tween != null)
				{
					window.tween.Kill();
				}
				if (window.Hierarchy.envelopContent.enabled)
				{
					window.Hierarchy.envelopContent.Execute();
				}
				Vector3 vector = Vector3.one - Vector3.one * 0.2f * i;
				Vector3 vector2 = window.Initial.position + new Vector3(0f, 150 * i, 0f);
				float num = window.Initial.alpha - 0.3f * (float)i;
				float num2 = (flag ? 1 : 0);
				if (allowAnimations)
				{
					Sequence sequence = DOTween.Sequence();
					sequence.Insert(0f, DOTween.To(() => panel.transform.localScale, delegate(Vector3 s)
					{
						panel.transform.localScale = s;
					}, vector, animationTime));
					sequence.Insert(0f, DOTween.To(() => panel.transform.localPosition, delegate(Vector3 s)
					{
						panel.transform.localPosition = s;
					}, vector2, animationTime));
					sequence.Insert(0f, DOTween.To(() => panel.alpha, delegate(float a)
					{
						panel.alpha = a;
					}, num, animationTime));
					if (window.Hierarchy.closeButtonWidget != null)
					{
						sequence.Insert(0f, DOTween.To(() => window.Hierarchy.closeButtonWidget.alpha, delegate(float a)
						{
							window.Hierarchy.closeButtonWidget.alpha = a;
						}, num2, animationTime));
					}
					sequence.Play();
					window.tween = sequence;
				}
				else
				{
					panel.transform.localScale = vector;
					panel.transform.localPosition = vector2;
					panel.alpha = num;
					if (window.Hierarchy != null && window.Hierarchy.closeButtonWidget != null)
					{
						window.Hierarchy.closeButtonWidget.alpha = num2;
					}
				}
			}
		}

		private void HandleButtonReleased(object sender, InputEventArgs e)
		{
			if (e.keyCode != KeyCode.Escape)
			{
				return;
			}
			if (visibleWindows_.Count == 0)
			{
				if (ToggleInGameMenu != null)
				{
					ToggleInGameMenu();
				}
				return;
			}
			GameWindow gameWindow = visibleWindows_[FrontWindowIndex];
			if (!gameWindow.DontCloseOnEsc)
			{
				ToggleWindow(gameWindow);
			}
		}

		private void OnBlackBackClicked()
		{
			if (AnyWindowIsOpen && FrontWindow.Hierarchy != null && FrontWindow.Hierarchy.closeButton != null && FrontWindow.Hierarchy.closeButton.gameObject.activeInHierarchy)
			{
				ToggleWindow(FrontWindow);
			}
		}

		private void SortPanels(GameWindow window)
		{
			UIPanel panel = window.Hierarchy.panel;
			if (totalDepth_ < window.minimumDepth)
			{
				totalDepth_ = window.minimumDepth;
			}
			panel.depth = totalDepth_;
			UIPanel[] componentsInChildren = GameObjectUtils.GetComponentsInChildren<UIPanel>(window.Hierarchy.gameObject);
			SortPanels(componentsInChildren, panel, panel.depth);
			totalDepth_ += componentsInChildren.Length + 1;
		}

		private int SortPanels(UIPanel a, UIPanel b)
		{
			return a.depth.CompareTo(b.depth);
		}

		private void SortPanels(UIPanel[] panels, UIPanel exclude, int depth)
		{
			if (panels == null || panels.Length <= 0)
			{
				return;
			}
			int num = 0;
			panelsSort_.AddRange(panels);
			panelsSort_.Sort(SortPanels);
			for (int i = 0; i < panelsSort_.Count; i++)
			{
				if (panelsSort_[i] != exclude)
				{
					panelsSort_[i].depth = depth + ++num;
				}
			}
			panelsSort_.Clear();
		}

		private bool SortVisibility(GameWindow actualWindow)
		{
			GameWindow gameWindow = ((visibleWindows_.Count <= 0) ? null : visibleWindows_[FrontWindowIndex]);
			bool visible = actualWindow.Visible;
			bool flag = gameWindow != null && gameWindow.Visible;
			if (gameWindow == actualWindow)
			{
				actualWindow.Visible = false;
				GameWindow gameWindow2 = ((visibleWindows_.Count <= 1) ? null : visibleWindows_[FrontWindowIndex - 1]);
				if (gameWindow2 != null)
				{
					gameWindow2.ReportIsFrontChanged(true);
				}
			}
			else if (gameWindow != null && (gameWindow.HeavyGraphics || (gameWindow.ExclusiveGroup != 0 && gameWindow.ExclusiveGroup == actualWindow.ExclusiveGroup)))
			{
				actualWindow.Visible = true;
				gameWindow.Visible = false;
				ChangeFront(gameWindow, actualWindow);
			}
			else
			{
				actualWindow.Visible = true;
				ChangeFront(gameWindow, actualWindow);
			}
			if (gameWindow != null && gameWindow != actualWindow && flag != gameWindow.Visible)
			{
				gameWindow.ReportViewChanged();
				ApplyVisible(gameWindow);
			}
			if (visible != actualWindow.Visible)
			{
				actualWindow.ReportViewChanged();
			}
			ApplyVisible(actualWindow);
			return visible;
		}
	}
}
