using UnityEngine;

namespace CraftyEngine.Utils.Unity
{
	public static class GameObjectMaker
	{
		public const string PREFIX = "_cm_";

		public static GameObject Create(string name)
		{
			return new GameObject("_cm_" + name);
		}

		internal static GameObject Create(string name, Transform parent)
		{
			GameObject gameObject = new GameObject(name);
			gameObject.transform.SetParent(parent, false);
			return gameObject;
		}

		internal static void Rename(GameObject instance, string name)
		{
			instance.name = "_cm_" + name;
		}

		internal static void Rename(GameObject instance)
		{
			instance.name = "_cm_" + instance.name;
		}
	}
}
