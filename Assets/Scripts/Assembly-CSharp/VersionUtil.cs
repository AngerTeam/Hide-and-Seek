using System;
using UnityEngine;

public class VersionUtil
{
	public const int MainScale = 10000000;

	public const int MajorScale = 10000;

	public const int MinorScale = 1;

	public static int StringToInt(string version)
	{
		try
		{
			string[] array = version.Split('.');
			int num = int.Parse(array[0]) * 10000000;
			int num2 = int.Parse(array[1]) * 10000;
			int num3 = int.Parse(array[2]) * 1;
			return num + num2 + num3;
		}
		catch (Exception exc)
		{
			Log.Error("Unable to parse version {0}", version);
			Log.Exception(exc);
			return -1;
		}
	}

	public static bool Compare(string current, string desire)
	{
		if (string.IsNullOrEmpty(desire))
		{
			return true;
		}
		int num = StringToInt(current);
		int num2 = StringToInt(desire);
		return num2 <= num;
	}

	public static string IntToString(int value)
	{
		int num = value / 10000000;
		int num2 = (value - num * 10000000) / 10000;
		int num3 = (value - num * 10000000 - num2 * 10000) / 1;
		return string.Format("{0}.{1}.{2}", num, num2, num3);
	}

	public static string UpMinor(string versionString)
	{
		return Up(versionString, 1);
	}

	public static string UpMajor(string versionString)
	{
		return Up(versionString, 10000);
	}

	private static string Up(string versionString, int scale)
	{
		int num = StringToInt(versionString);
		num += 1 * scale;
		return IntToString(num);
	}

	public static string GetSettingsUrl(string version, string lang)
	{
		string bUNDLE_TYPE = CompileConstants.BUNDLE_TYPE;
		return string.Format("deploy/{0}/deploy_{0}_{1}_{2}.amf3", version, lang, bUNDLE_TYPE);
	}

	public static bool InstalledFromStore()
	{
		if (DataStorage.isAdmin || !CompileConstants.CONTENT_IS_RELEASE || CompileConstants.EDITOR)
		{
			return false;
		}
		if (CompileConstants.IOS)
		{
			return true;
		}
		if (CompileConstants.ANDROID)
		{
			bool result = false;
			try
			{
				AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
				AndroidJavaObject @static = androidJavaClass.GetStatic<AndroidJavaObject>("currentActivity");
				AndroidJavaObject androidJavaObject = @static.Call<AndroidJavaObject>("getPackageManager", new object[0]);
				string text = @static.Call<string>("getPackageName", new object[0]);
				string text2 = androidJavaObject.Call<string>("getInstallerPackageName", new object[1] { text });
				Log.Temp("IsInstalledFromStore installerPackage=" + text2);
				result = !string.IsNullOrEmpty(text2) && text2 == "com.android.vending";
			}
			catch (Exception ex)
			{
				Log.Error("IsInstalledFromStore error:" + ex);
			}
			return result;
		}
		return false;
	}
}
