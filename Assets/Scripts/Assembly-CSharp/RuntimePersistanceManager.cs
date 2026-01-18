using System.IO;
using UnityEngine;

public class RuntimePersistanceManager
{
	public static void Init()
	{
		string cONTENT_TYPE = CompileConstants.CONTENT_TYPE;
		string arg = ((!CompileConstants.EDITOR) ? string.Empty : "editor");
		string path = string.Format("{0}Settings{1}", arg, cONTENT_TYPE);
		PersistanceManager.directory = Path.Combine(Application.persistentDataPath, path);
		path = string.Format("{0}Files{1}", arg, cONTENT_TYPE);
		PersistanceManager.filesDirectory = Path.Combine((!CompileConstants.PLATFORM_IS_WIN) ? Application.persistentDataPath : Path.GetFullPath(Application.dataPath + "/../"), path);
		PersistanceManager.Init();
	}
}
