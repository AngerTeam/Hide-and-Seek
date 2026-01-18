using System.IO;
using System.Text.RegularExpressions;

namespace CraftyEngine.Infrastructure.Editor
{
	public class BuilderIOS
	{
		public const int LIMIT_OF_SRC_FILES = 48;

		private static string[] ArrayGetters = new string[5] { "GetVertexes", "GetNormals", "GetTextures", "GetColors", "GetTriangles" };

		private BuilderIOS()
		{
		}

		public static void XCodeProcessing(string basePath, string appName)
		{
			string path = Path.Combine(basePath, appName);
			path = Path.Combine(path, "/Classes/Native");
			for (int i = 0; i < 48; i++)
			{
				FileInfo fileInfo = new FileInfo(Path.Combine(path, "Bulk_Assembly-CSharp_" + i + ".cpp"));
				if (fileInfo.Exists)
				{
					ProcessFile(fileInfo);
				}
			}
		}

		private static void ProcessFile(FileInfo file)
		{
			string path = file.ToString();
			string text = File.ReadAllText(path);
			string format = "(DEFAULT_CALL {0}(?:.|\\r|\\n|;)*?_returnValue_unmarshaled = \\(.*?\\))(.*);";
			for (int i = 0; i < ArrayGetters.Length; i++)
			{
				string text2 = ArrayGetters[i];
				string pattern = string.Format(format, text2);
				Regex.Replace(text, pattern, "$1" + text2 + "();");
			}
			File.WriteAllText(path, text);
		}
	}
}
