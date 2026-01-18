using ChestsViewModule;
using CraftyBundles;
using CraftyEngine.Infrastructure.FileSystem;
using UnityEngine;

namespace UI3DModule
{
	public class UI3DManager
	{
		public static UI3DView InstantiateView(FileHolder fileHolder, float scale = 1f)
		{
			GameObject result;
			if (!RenderHierarchyUtils.TryInstansiate(fileHolder.loadedAssetBundle, out result))
			{
				result = (GameObject)fileHolder.Instantiate();
			}
			if (result == null)
			{
				Log.Error("Unable to instantiate {0}", fileHolder.fileGetter.Address);
				return null;
			}
			return new UI3DView(result, scale);
		}
	}
}
