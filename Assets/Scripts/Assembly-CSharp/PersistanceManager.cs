using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using UnityEngine;

public class PersistanceManager
{
	public const string GAMESTATE_TYPE_KEY = "EditorSelectedGameStateType";

	public const string INTERNAL_LUA_ADDRESS = "10.0.1.201";

	public const string INTERNAL_LUA_URL_KEY = "InternalLuaUrl";

	public const string LOCALHOST_MODE_KEY = "EditorLocalhostMode";

	public const string ROOT = "/root";

	public static string directory;

	public static string filesDirectory;

	private static Dictionary<Type, object> allSettings;

	private static Dictionary<string, string> args;

	public static void Get<T>(out T settings) where T : new()
	{
		settings = Get<T>();
	}

	public static void Get<T>(string typeName, out T settings) where T : new()
	{
		settings = Get<T>(typeName);
	}

	public static bool Exists<T>(string typeName = null)
	{
		if (typeName == null)
		{
			typeName = typeof(T).Name + ".cfg";
		}
		string path = Path.Combine(directory, typeName);
		return File.Exists(path);
	}

	public static T Get<T>(string typeName = null) where T : new()
	{
		Type typeFromHandle = typeof(T);
		if (allSettings.ContainsKey(typeFromHandle))
		{
			return (T)allSettings[typeFromHandle];
		}
		if (typeName == null)
		{
			typeName = typeof(T).Name + ".cfg";
		}
		string path = Path.Combine(directory, typeName);
		T val;
		if (File.Exists(path))
		{
			string json = File.ReadAllText(path);
			val = JsonUtility.FromJson<T>(json);
		}
		else
		{
			val = new T();
		}
		allSettings[typeFromHandle] = val;
		return val;
	}

	public static void Init()
	{
		Log.Info("PersistanceManager: {0}", directory);
		allSettings = new Dictionary<Type, object>();
		Directory.CreateDirectory(directory);
		Directory.CreateDirectory(filesDirectory);
	}

	public static void Save(object settings)
	{
		string contents = JsonUtility.ToJson(settings, true);
		Type type = settings.GetType();
		allSettings[type] = settings;
		string path = type.Name + ".cfg";
		string path2 = Path.Combine(directory, path);
		if (File.Exists(path2))
		{
			File.Delete(path2);
		}
		File.WriteAllText(path2, contents);
	}

	public static void SaveAll()
	{
		List<object> list = new List<object>(allSettings.Values);
		foreach (object item in list)
		{
			Save(item);
		}
	}

	internal static void ParseArgs<T>(Dictionary<string, string> argsDictionary) where T : new()
	{
		args = argsDictionary;
		T val = Get<T>();
		ForeachField(val, ParseArg);
	}

	internal static void Save<T>() where T : new()
	{
		Save(Get<T>());
	}

	private static string Encrypt(string sKey, string data)
	{
		byte[] bytes = Encoding.ASCII.GetBytes(data);
		MemoryStream memoryStream = new MemoryStream(bytes);
		MemoryStream memoryStream2 = new MemoryStream();
		DESCryptoServiceProvider dESCryptoServiceProvider = new DESCryptoServiceProvider();
		dESCryptoServiceProvider.Key = Encoding.ASCII.GetBytes(sKey);
		dESCryptoServiceProvider.IV = Encoding.ASCII.GetBytes(sKey);
		ICryptoTransform transform = dESCryptoServiceProvider.CreateEncryptor();
		CryptoStream cryptoStream = new CryptoStream(memoryStream2, transform, CryptoStreamMode.Write);
		byte[] array = new byte[memoryStream.Length];
		memoryStream.Read(array, 0, array.Length);
		cryptoStream.Write(array, 0, array.Length);
		return Encoding.ASCII.GetString(memoryStream2.GetBuffer());
	}

	private static void ForeachField(object source, Action<object, FieldInfo, string> action)
	{
		Type type = source.GetType();
		string name = type.Name;
		FieldInfo[] fields = type.GetFields();
		FieldInfo[] array = fields;
		foreach (FieldInfo fieldInfo in array)
		{
			string arg = string.Format("Persistance.{0}.{1}", name, fieldInfo.Name);
			action(source, fieldInfo, arg);
		}
	}

	private static void ParseArg(object source, FieldInfo fieldInfo, string prefsName)
	{
		if (args.ContainsKey(fieldInfo.Name))
		{
			fieldInfo.SetValue(source, args[fieldInfo.Name]);
		}
	}
}
