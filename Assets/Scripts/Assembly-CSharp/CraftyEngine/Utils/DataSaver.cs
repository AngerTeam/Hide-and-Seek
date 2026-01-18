using System.IO;
using UnityEngine;

namespace CraftyEngine.Utils
{
	public static class DataSaver
	{
		public static string SaveBytes(byte[] bytes, string fileName)
		{
			string text = Path.Combine(PersistanceManager.directory, fileName);
			if (File.Exists(text))
			{
				File.Delete(text);
			}
			File.WriteAllBytes(text, bytes);
			return text;
		}

		public static byte[] LoadBytesByFilename(string fileName)
		{
			string filePath = Path.Combine(PersistanceManager.directory, fileName);
			return LoadBytes(filePath);
		}

		public static byte[] LoadBytes(string filePath)
		{
			if (File.Exists(filePath))
			{
				return File.ReadAllBytes(filePath);
			}
			return null;
		}

		public static void Save<DATA>(DATA data, string fileName, string encrypt = null)
		{
			string text = JsonUtility.ToJson(data, true);
			string contents = text;
			string path = Path.Combine(PersistanceManager.directory, fileName);
			if (File.Exists(path))
			{
				File.Delete(path);
			}
			File.WriteAllText(path, contents);
		}

		public static DATA Load<DATA>(string file, string encrypt = null)
		{
			string path = Path.Combine(PersistanceManager.directory, file);
			if (File.Exists(path))
			{
				string text = File.ReadAllText(path);
				string json = text;
				try
				{
					return JsonUtility.FromJson<DATA>(json);
				}
				catch
				{
					Log.Error("Failed to read save file");
					return default(DATA);
				}
			}
			return default(DATA);
		}

		public static void Remove(string fileName)
		{
			if (File.Exists(fileName))
			{
				File.Delete(fileName);
			}
		}
	}
}
