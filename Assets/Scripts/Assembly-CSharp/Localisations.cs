using System;
using System.Collections.Generic;
using UnityEngine;

public class Localisations
{
	public static Dictionary<string, string> vocabulary;

	public static Func<string, string> Getter;

	public static string Get(string key)
	{
		if (Getter != null)
		{
			string text = Getter(key);
			if (!string.IsNullOrEmpty(text))
			{
				return text;
			}
		}
		string value;
		if (vocabulary != null && vocabulary.TryGetValue(key, out value))
		{
			return value;
		}
		Log.Warning("Unable to find localisation for {0}", key);
		return key;
	}

	private static void Set(string key, string eng, string rus)
	{
		vocabulary[key] = ((!(LangMap.lang == "en")) ? rus : eng);
	}

	public static void Init()
	{
		if (vocabulary == null)
		{
			LangMap.lang = ((Application.systemLanguage != SystemLanguage.Russian) ? "en" : "ru");
			vocabulary = new Dictionary<string, string>();
			Set("Obsolete_Version_Standalone", "New version is avalible now, please start Game Launcher and update the game!", "Вышла новая версия игры! Пожалуйста, запустите загрузчик игры и обновитесь!");
			Set("Obsolete_Version_Android", "New version of game is avalible now, please update in GooglePlay!", "Вышла новая версия игры! Пожалуйста, обновитесь в GooglePlay!");
			Set("Obsolete_Version_IOS", "New version of game is avalible now, please update!", "Вышла новая версия игры! Пожалуйста, обновитесь!");
			Set("Obsolete_Version", "New version of game is avalible now, please update!", "Вышла новая версия игры! Пожалуйста, обновитесь!");
			Set("yes", "yes", "да");
			Set("no", "no", "нет");
			Set("on", "on", "вкл.");
			Set("off", "off", "выкл.");
			Set("OK", "OK", "ОК");
			Set("Error_No_Internet_Connection", "No internet connection detected.\nPlease check your internet connection.", "Нет соединения,\n пожалуйста, проверьте доступ к интернету.");
			Set("Error_No_Server_Connection", "Unable to connect to server,\nplease wait for a few minutes and try again.", "Невозможно подключиться к серверу,\nпожалуйста, попробуйте через несколько минут.");
			Set("Error_ERR_PROJECT_MAINTENANCE", "Server is under maintenance,\nplease try again later.", "Тех. работы на сервере,\nпожалуйста, попробуйте позже.");
			Set("UI_RestartButton", "Restart", "Перезагрузить");
			Set("Error_GuestSessionRestore", "Server is under maintenance,\nplease try again later.", "Тех. работы на сервере,\nпожалуйста, попробуйте позже.");
			Set("UI_Loading", "Loading", "Загрузка");
			Set("UI_Register_Warning", "Attention!\nMake sure to save game progress before updating!", "Внимание!\nСохраните прогресс игры перед обновлением!");
			Set("UI_Cancel", "Cancel", "Отмена");
			Set("UI_UnableToLoadFile", "Connection error. Try again later.", "Ошибка соединения. Попробуйте позже.");
		}
	}
}
