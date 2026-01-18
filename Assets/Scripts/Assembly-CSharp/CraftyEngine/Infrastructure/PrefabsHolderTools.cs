using System.Collections.Generic;
using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class PrefabsHolderTools
	{
		public static Dictionary<string, GameObject> Read(PrefabsHolder metaData)
		{
			Dictionary<string, GameObject> dictionary = new Dictionary<string, GameObject>();
			Read(metaData, dictionary);
			return dictionary;
		}

		public static void Read(PrefabsHolder metaData, Dictionary<string, GameObject> prefabsByName)
		{
			if (prefabsByName == null)
			{
				prefabsByName = new Dictionary<string, GameObject>();
			}
			GameObject[] prefabs = metaData.prefabs;
			foreach (GameObject gameObject in prefabs)
			{
				if (gameObject == null)
				{
					Log.Warning("Missing prefab at {0}", metaData.name);
				}
				else if (!prefabsByName.ContainsKey(gameObject.name))
				{
					prefabsByName.Add(gameObject.name, gameObject);
				}
			}
		}
	}
}
