using System;
using System.Collections.Generic;
using CraftyEngine.Utils;
using LogSystem;
using UnityEngine;

public static class Log
{
	public enum LogCategory
	{
		Temp = 0,
		CSharpVoxelEngine = 1,
		CppVoxelEngine = 2,
		Info = 3,
		Timestamp = 4,
		Warning = 5,
		Error = 6,
		Online = 7,
		Animation = 8
	}

	public abstract class LogTarget
	{
		public const string LOG_MARK = "cLog: ";

		public bool unityNative;

		internal bool locked;

		public abstract void AddMessage(LogCategory category, string message);
	}

	public static Dictionary<string, long> timestamps = new Dictionary<string, long>();

	public static LogTargetFileBase FileTarget;

	private static List<LogTarget> targets_;

	public static void ArtError(string message, params object[] param)
	{
		Message(LogCategory.Warning, message, param);
	}

	public static void ChronologyStart(string key)
	{
		timestamps[key] = DateTime.Now.Ticks;
		Message(LogCategory.Timestamp, "Chronology: {0} started", key);
	}

	public static void ChronologyStop(string key)
	{
		long num = timestamps[key];
		timestamps.Remove(key);
		long ticks = DateTime.Now.Ticks;
		double num2 = (double)(ticks - num) / 10000000.0;
		Message(LogCategory.Timestamp, "Chronology: {0} took {1:f3} seconds", key, num2);
	}

	public static void ContentError(string message, params object[] param)
	{
		Message(LogCategory.Warning, message, param);
	}

	public static void Animation(string message, params object[] param)
	{
		if (!CompileConstants.RELEASE)
		{
			Message(LogCategory.Animation, "[Animation]: " + message, param);
		}
	}

	public static void Error(string message, params object[] param)
	{
		Message(LogCategory.Error, message, param);
	}

	public static void Exception(Exception exc)
	{
		if (exc.InnerException != null)
		{
			Message(LogCategory.Error, exc.InnerException.Message + "\n" + exc.InnerException.StackTrace);
		}
		Message(LogCategory.Error, exc.Message + "\n" + exc.StackTrace);
	}

	public static void Info(string message, params object[] param)
	{
		Message(LogCategory.Info, message, param);
	}

	public static void Init()
	{
		targets_ = new List<LogTarget>();
		targets_.Add(new LogTargetUnityConsole());
		FileTarget = new LogTargetLoopFile(DataStorage.logFile);
		targets_.Add(FileTarget);
		Application.logMessageReceived -= Application_logMessageReceived;
		Application.logMessageReceived += Application_logMessageReceived;
	}

	public static void Online(string message, params object[] param)
	{
		Message(LogCategory.Online, "[Online] " + message, param);
	}

	public static void CSVE(string message, params object[] param)
	{
		Message(LogCategory.CSharpVoxelEngine, "[CSVE]: " + message, param);
	}

	internal static void CPPVE(string str)
	{
		Message(LogCategory.CppVoxelEngine, "[CPPVE]: " + str);
	}

	public static void Temp(params object[] values)
	{
		Message(LogCategory.Temp, ArrayUtils.ArrayToString(values));
	}

	public static void Warning(string message, params object[] param)
	{
		Message(LogCategory.Warning, message, param);
	}

	private static void Application_logMessageReceived(string condition, string stackTrace, LogType type)
	{
		if (condition.StartsWith("cLog: "))
		{
			return;
		}
		for (int i = 0; i < targets_.Count; i++)
		{
			LogTarget logTarget = targets_[i];
			if (!logTarget.unityNative && !logTarget.locked)
			{
				logTarget.locked = true;
				LogCategory logCategory = GetLogCategory(type);
				logTarget.AddMessage(logCategory, condition + stackTrace);
				logTarget.locked = false;
			}
		}
	}

	private static LogCategory GetLogCategory(LogType type)
	{
		switch (type)
		{
		case LogType.Error:
			return LogCategory.Error;
		case LogType.Warning:
			return LogCategory.Warning;
		default:
			return LogCategory.Info;
		}
	}

	private static void Message(LogCategory category, string message, params object[] param)
	{
		foreach (LogTarget item in targets_)
		{
			item.locked = true;
			string message2 = ((param == null || param.Length <= 0) ? message : string.Format(message, param));
			item.AddMessage(category, message2);
			item.locked = false;
		}
	}
}
