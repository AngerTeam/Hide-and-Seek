using System.Collections.Generic;

namespace CraftyEngine.Infrastructure.FileSystem
{
	public class LegacyPermanentFilesManager : PermanentSingleton
	{
		public Dictionary<string, FileHolder> files;

		public override void Init()
		{
			files = new Dictionary<string, FileHolder>();
		}

		public override void Dispose()
		{
			if (files == null)
			{
				return;
			}
			foreach (FileHolder value in files.Values)
			{
				if (Extended.log)
				{
					Log.Info("[FilesManager]: Unload {0}", value.fileGetter.originalUrl);
				}
				if (value.loadedAssetBundle != null)
				{
					value.loadedAssetBundle.Unload(true);
					value.loadedAssetBundle = null;
				}
				value.fileGetter.Unload();
			}
			files.Clear();
			files = null;
		}

		internal void TransferNonPermanentFiles(Dictionary<string, FileHolder> storage)
		{
			if (files == null)
			{
				return;
			}
			List<KeyValuePair<string, FileHolder>> list = new List<KeyValuePair<string, FileHolder>>();
			foreach (KeyValuePair<string, FileHolder> file in files)
			{
				list.Add(file);
			}
			foreach (KeyValuePair<string, FileHolder> item in list)
			{
				if (Extended.log)
				{
					Log.Info("[FilesManager]: Transfer {0} from permanentFilesManager", item.Value.fileGetter.originalUrl);
				}
				files.Remove(item.Key);
				storage.Add(item.Key, item.Value);
			}
		}
	}
}
