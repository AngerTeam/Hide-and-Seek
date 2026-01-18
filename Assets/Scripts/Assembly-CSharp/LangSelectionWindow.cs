using System;
using System.Collections.Generic;
using HudSystem;
using UnityEngine;
using WindowsModule;

public class LangSelectionWindow : GameWindow
{
	[Serializable]
	public class LangEntry
	{
		public string flag;

		public string text;

		public string lang;
	}

	[Serializable]
	public class LangList
	{
		public LangEntry[] list;
	}

	private PersistanceUserSettings userSettings;

	private LangSelectionHierarchy hierarchy_;

	private DialogWindowManager splashmanager_;

	public string currentFlagIcon;

	private string nextLanguage;

	private Dictionary<string, LangSelectionItemHierarchy> languages;

	public event EventHandler<EventArgs> RestartGame;

	public LangSelectionWindow()
		: base(false)
	{
		SingletonManager.Get<DialogWindowManager>(out splashmanager_);
		languages = new Dictionary<string, LangSelectionItemHierarchy>();
		hierarchy_ = prefabsManager.InstantiateNGUIIn<LangSelectionHierarchy>("UILanguageSelection", nguiManager.UiRoot.gameObject);
		Init();
		hierarchy_.label.text = Localisations.Get("UI_InGameMenu_SelectLanguage");
		SetContent(hierarchy_.transform, false);
	}

	public void Init()
	{
		PersistanceManager.Get<PersistanceUserSettings>(out userSettings);
		try
		{
			GenerateLangList();
		}
		catch (Exception ex)
		{
			Log.Error(ex.ToString());
		}
	}

	public override void Clear()
	{
	}

	private void GenerateLangList()
	{
		TextAsset textAsset = Resources.Load<TextAsset>("lang.list");
		LangList langList = JsonUtility.FromJson<LangList>(textAsset.text);
		if (langList == null || langList.list == null)
		{
			Log.Error("Lang.list not loaded!");
			return;
		}
		LangEntry[] list = langList.list;
		foreach (LangEntry langEntry in list)
		{
			InstanceLanguageItem(langEntry.flag, langEntry.text, langEntry.lang);
		}
	}

	private LangSelectionItemHierarchy InstanceLanguageItem(string flag, string text, string lang)
	{
		LangSelectionItemHierarchy langSelectionItemHierarchy = UnityEngine.Object.Instantiate(hierarchy_.LanguageItem);
		langSelectionItemHierarchy.gameObject.name = "Lang_" + lang;
		langSelectionItemHierarchy.gameObject.SetActive(true);
		langSelectionItemHierarchy.transform.SetParent(hierarchy_.Grid.transform);
		langSelectionItemHierarchy.transform.localScale = Vector3.one;
		langSelectionItemHierarchy.Flag.spriteName = flag;
		langSelectionItemHierarchy.Label.text = text;
		bool flag2 = userSettings.lang == lang;
		langSelectionItemHierarchy.Mark.gameObject.SetActive(flag2);
		if (flag2)
		{
			currentFlagIcon = flag;
		}
		ButtonSet.Up(langSelectionItemHierarchy.Button, delegate
		{
			ChangeLanguage(lang);
		}, ButtonSetGroup.InWindow);
		languages.Add(lang, langSelectionItemHierarchy);
		return langSelectionItemHierarchy;
	}

	internal void ChangeLanguage(string lang)
	{
		nextLanguage = lang;
		splashmanager_.ShowDialogue(Localisations.Get("UI_InGameMenu_ApplyChangersAndRestart"), Restart);
	}

	private void Restart()
	{
		userSettings.lang = nextLanguage;
		PersistanceManager.Save(userSettings);
		if (this.RestartGame != null)
		{
			this.RestartGame(this, new EventArgs());
		}
	}
}
