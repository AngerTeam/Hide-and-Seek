using System;
using System.Collections.Generic;
using CraftyEngine.Infrastructure;
using HudSystem;
using SoundsModule;
using UnityEngine;
using WindowsModule;

namespace InGameMenuModule
{
	public class DefaultInGameMenu : GameWindow
	{
		private const int BUTTON_WIDTH = 650;

		private UIMainMenuHierarchy hierarchy_;

		private LangSelectionWindow langSelectionWindow;

		private SoundManager soundManager_;

		private PersistanceUserSettings userSettings;

		public event Action ChangeLanguageReqested;

		public DefaultInGameMenu()
		{
			base.HudState = 41088;
			SingletonManager.Get<SoundManager>(out soundManager_);
			PersistanceManager.Get<PersistanceUserSettings>(out userSettings);
			prefabsManager.Load("ProjectInGameMenu");
			langSelectionWindow = new LangSelectionWindow();
			langSelectionWindow.RestartGame += ReportChangeLanguageReqested;
			hierarchy_ = prefabsManager.InstantiateNGUIIn<UIMainMenuHierarchy>("UIMainMenu", nguiManager.UiRoot.gameObject);
			hierarchy_.toggleSound.value = userSettings.soundOn;
			hierarchy_.toggleMusic.value = userSettings.musicOn;
			EventDelegate.Add(hierarchy_.toggleSound.onChange, ActionToggleSound);
			EventDelegate.Add(hierarchy_.toggleMusic.onChange, ActionToggleMusic);
			ButtonSet.Up(hierarchy_.buttonLanguage, ActionToggleLangSelection, ButtonSetGroup.InWindow);
			hierarchy_.languageFlag.spriteName = langSelectionWindow.currentFlagIcon;
			SetEnvelop(base.Hierarchy.envelopContent);
			SetContent(hierarchy_.transform, true, true, false, false, true);
			hierarchy_.transform.localPosition = new Vector3(0f, 170f, 0f);
			base.ViewChanged += HandleViewChanged;
		}

		public void Reposition()
		{
			hierarchy_.lineGrid.repositionNow = true;
			UnityEvent.OnNextUpdate(delegate
			{
				hierarchy_.envelopContent.executeOnNextUpdate = true;
			});
			UIWidget[] componentsInChildren = hierarchy_.GetComponentsInChildren<UIWidget>();
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				NGUITools.UpdateWidgetCollider(componentsInChildren[i].gameObject);
			}
		}

		private void HandleViewChanged(object sender, BoolEventArguments e)
		{
			if (!Visible)
			{
				return;
			}
			Transform transform = hierarchy_.lineGrid.transform;
			Transform transform2 = hierarchy_.bottomWidget.transform;
			List<Transform> list = new List<Transform>();
			GetChildren(transform, list);
			GetChildren(transform2, list);
			bool flag = false;
			int count = list.Count;
			int num = (int)hierarchy_.lineGrid.cellWidth - 650;
			for (int i = 0; i < count; i++)
			{
				bool flag2 = i == count - 1 && count % 2 == 1;
				Transform transform3 = list[i];
				UISprite component = transform3.GetComponent<UISprite>();
				if (flag2)
				{
					transform3.transform.SetParent(transform2);
					component.width = 1300 + num;
					component.transform.localPosition = new Vector3(0f, -80f, 0f);
					flag = true;
				}
				else
				{
					transform3.transform.SetParent(transform);
					component.width = 650;
				}
			}
			hierarchy_.bottomWidget.height = (flag ? 120 : 0);
			if (flag)
			{
				hierarchy_.bottomWidget.bottomAnchor.absolute = -120;
				hierarchy_.bottomWidget.topAnchor.absolute = 0;
			}
			Reposition();
		}

		private void GetChildren(Transform gridParent, List<Transform> children)
		{
			int childCount = gridParent.childCount;
			for (int i = 0; i < childCount; i++)
			{
				children.Add(gridParent.GetChild(i));
			}
		}

		public UIButton AddButton(string title, Action action)
		{
			UIButton uIButton = prefabsManager.InstantiateNGUIIn<UIButton>("UIWideButtonGreen", hierarchy_.lineGrid.gameObject);
			UISprite component = uIButton.GetComponent<UISprite>();
			component.width = 650;
			component.height = 120;
			UILabel componentInChildren = uIButton.GetComponentInChildren<UILabel>();
			componentInChildren.text = Localisations.Get(title);
			componentInChildren.depth = 6;
			componentInChildren.fontSize = 70;
			ButtonSet.Up(uIButton, action, ButtonSetGroup.InWindow);
			hierarchy_.lineGrid.repositionNow = true;
			return uIButton;
		}

		private void ReportChangeLanguageReqested(object sender, EventArgs e)
		{
			if (this.ChangeLanguageReqested == null)
			{
				Log.Error("Change language reqest has no subscribers!");
			}
			else
			{
				this.ChangeLanguageReqested();
			}
		}

		public override void Clear()
		{
			langSelectionWindow.Clear();
		}

		private void ActionToggleLangSelection()
		{
			windowsManager.ToggleWindow(langSelectionWindow);
		}

		private void ActionToggleMusic()
		{
			bool value = hierarchy_.toggleMusic.value;
			soundManager_.MusicOn = value;
			userSettings.musicOn = value;
			PersistanceManager.Save(userSettings);
			soundManager_.UpdateVolume();
		}

		private void ActionToggleSound()
		{
			bool value = hierarchy_.toggleSound.value;
			soundManager_.soundOn = value;
			userSettings.soundOn = value;
			PersistanceManager.Save(userSettings);
			soundManager_.UpdateVolume();
		}

		private void SetEnvelop(EnvelopContent env)
		{
			env.padLeft = -70;
			env.padRight = 70;
			env.padTop = 70;
			env.padBottom = -70;
		}
	}
}
