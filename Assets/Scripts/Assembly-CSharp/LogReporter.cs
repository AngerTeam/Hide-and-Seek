using System;
using System.Collections.Generic;
using System.IO;
using CraftyEngine.Infrastructure;
using UnityEngine;

public class LogReporter
{
	public static string hostingUrl = "https://deploy.hns.pixelgun.plus/public/";

	private static readonly int maxLogSize = 3145728;

	private static readonly string relativePath = "crash_report.php";

	private static float offTime_;

	private static UnityEvent unityEvent_;

	private static WWW www_;

	private static WWWForm form_;

	public static void Report(Exception exc = null)
	{
		form_ = ContentStandart.GetForm(CompileConstants.PLATFORM);
		form_.AddField("pf", CompileConstants.PLATFORM);
		if (LogReporterModel.info != null)
		{
			foreach (KeyValuePair<string, string> item in LogReporterModel.info)
			{
				form_.AddField(item.Key, item.Value);
			}
		}
		form_.AddField("locale", (Application.systemLanguage != SystemLanguage.Russian) ? "en_US" : "ru_RU");
		form_.AddField("version", string.Format("v{0} ({1})", DataStorage.releaseVersion, DataStorage.version.Replace(".", string.Empty)));
		if (exc != null)
		{
			form_.AddField("error", exc.Message);
			form_.AddField("log", exc.ToString());
		}
		else
		{
			form_.AddField("error", "No exception");
			form_.AddField("log", "See the log file");
		}
		Log.FileTarget.Lock(true);
		Log.FileTarget.Flush();
		string filePath = Log.FileTarget.FilePath;
		string fileName = Path.GetFileName(filePath);
		form_.AddField("log_file", fileName);
		form_.AddBinaryData("log_file", GetSlicedLogs(filePath), fileName);
		Log.FileTarget.Lock(false);
		offTime_ = Time.unscaledTime + 10f;
		SingletonManager.Get<UnityEvent>(out unityEvent_, 0);
		unityEvent_.Subscribe(UnityEventType.Update, Update);
	}

	private static byte[] GetSlicedLogs(string file)
	{
		byte[] array = File.ReadAllBytes(file);
		if (array.Length > maxLogSize)
		{
			byte[] array2 = new byte[maxLogSize];
			Array.Copy(array, array.Length - maxLogSize, array2, 0, maxLogSize);
			array = array2;
		}
		return array;
	}

	private static void Update()
	{
		if (form_ != null)
		{
			string text = Path.Combine(hostingUrl, relativePath);
			Log.Temp("url", text);
			www_ = new WWW(text, form_);
			form_ = null;
		}
		else if (www_.isDone || Time.unscaledTime < offTime_)
		{
			unityEvent_.Unsubscribe(UnityEventType.Update, Update);
			Log.Temp("Report done!");
			www_ = null;
		}
	}
}
