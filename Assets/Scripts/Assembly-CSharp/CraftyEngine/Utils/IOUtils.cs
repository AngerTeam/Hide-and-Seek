using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;

namespace CraftyEngine.Utils
{
	public class IOUtils
	{
		public static void DeleteDirectory(string targetDir)
		{
			if (Directory.Exists(targetDir))
			{
				string[] files = Directory.GetFiles(targetDir);
				string[] directories = Directory.GetDirectories(targetDir);
				string[] array = files;
				foreach (string path in array)
				{
					File.SetAttributes(path, FileAttributes.Normal);
					File.Delete(path);
				}
				string[] array2 = directories;
				foreach (string targetDir2 in array2)
				{
					DeleteDirectory(targetDir2);
				}
				Directory.Delete(targetDir, false);
			}
		}

		public static void DirectoryCopy(string sourceDirName, string destDirName, bool copySubDirs, bool overwrite = true)
		{
			DirectoryInfo directoryInfo = new DirectoryInfo(sourceDirName);
			if (!directoryInfo.Exists)
			{
				throw new DirectoryNotFoundException("Source directory does not exist or could not be found: " + sourceDirName);
			}
			DirectoryInfo[] directories = directoryInfo.GetDirectories();
			if (!Directory.Exists(destDirName))
			{
				Directory.CreateDirectory(destDirName);
			}
			FileInfo[] files = directoryInfo.GetFiles();
			FileInfo[] array = files;
			foreach (FileInfo fileInfo in array)
			{
				string destFileName = Path.Combine(destDirName, fileInfo.Name);
				fileInfo.CopyTo(destFileName, overwrite);
			}
			if (copySubDirs)
			{
				DirectoryInfo[] array2 = directories;
				foreach (DirectoryInfo directoryInfo2 in array2)
				{
					string destDirName2 = Path.Combine(destDirName, directoryInfo2.Name);
					DirectoryCopy(directoryInfo2.FullName, destDirName2, true);
				}
			}
		}

		public static string[] GetAllFiles(string directory, string exclude, string include)
		{
			List<string> list = new List<string>();
			GetAllFiles(list, directory, exclude, include);
			return list.ToArray();
		}

		public static string[] GetAllFiles(string directory)
		{
			return GetAllFiles(directory, null, null);
		}

		public static void GetAllFiles(List<string> allFiles, string directory, string exclude, string include)
		{
			Regex exclude2 = ((exclude == null) ? null : new Regex(exclude));
			Regex include2 = ((include == null) ? null : new Regex(include));
			GetAllFiles(allFiles, directory, directory, exclude2, include2);
		}

		public static void GetAllFiles(List<string> allFiles, string topDirectory, string directory, Regex exclude, Regex include)
		{
			if (!Directory.Exists(directory))
			{
				return;
			}
			string[] files = Directory.GetFiles(directory);
			foreach (string text in files)
			{
				if (exclude != null)
				{
					string input = text.Substring(topDirectory.Length);
					if (exclude.IsMatch(input))
					{
						continue;
					}
				}
				if (include == null || include.IsMatch(text))
				{
					allFiles.Add(text);
				}
			}
			string[] directories = Directory.GetDirectories(directory);
			for (int j = 0; j < directories.Length; j++)
			{
				GetAllFiles(allFiles, topDirectory, directories[j], exclude, include);
			}
		}

		public static string FindDirectory(string root, string name)
		{
			string text = null;
			string[] directories = Directory.GetDirectories(root);
			string[] array = directories;
			foreach (string text2 in array)
			{
				if (text2.EndsWith(name))
				{
					text = text2;
					break;
				}
				text = FindDirectory(text2, name);
				if (text != null)
				{
					break;
				}
			}
			if (text != null)
			{
				text = text.Replace('\\', '/');
			}
			return text;
		}

		public static string SplitPathByDirectory(string path, string name)
		{
			path = path.Replace('\\', '/');
			string[] array = path.Split('/');
			StringBuilder stringBuilder = new StringBuilder();
			bool flag = false;
			for (int i = 0; i < array.Length; i++)
			{
				if (!flag && array[i].Equals(name))
				{
					flag = true;
				}
				if (flag)
				{
					stringBuilder.Append(array[i]);
					if (i < array.Length - 1)
					{
						stringBuilder.Append('/');
					}
				}
			}
			return stringBuilder.ToString();
		}
	}
}
