using System.Collections.Generic;
using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class PrefabsManager : Singleton
	{
		private Dictionary<string, GameObject> holdersByType;

		private Dictionary<string, GameObject> prefabsByName;

		private GameObject prefabHoldersContainer_;

		public bool Contains(string name)
		{
			return prefabsByName.ContainsKey(name);
		}

		public override void Dispose()
		{
			if (prefabHoldersContainer_ != null)
			{
				if (Application.isPlaying)
				{
					Object.Destroy(prefabHoldersContainer_);
				}
				else
				{
					Object.DestroyImmediate(prefabHoldersContainer_);
				}
			}
			prefabHoldersContainer_ = null;
			if (prefabsByName != null)
			{
				prefabsByName.Clear();
			}
			prefabsByName = null;
			if (holdersByType != null)
			{
				holdersByType.Clear();
			}
			holdersByType = null;
			Resources.UnloadUnusedAssets();
		}

		public T GetPrefab<T>(string name) where T : Component
		{
			string name2 = name.ToString();
			GameObject prefab = GetPrefab(name2);
			return prefab.GetComponent<T>();
		}

		public GameObject GetPrefab(string name)
		{
			if (prefabsByName.ContainsKey(name))
			{
				return prefabsByName[name];
			}
			Log.Error("Prefab {0} is not found", name);
			return null;
		}

		public T Instantiate<T>(string name) where T : Component
		{
			GameObject prefab = GetPrefab(name);
			GameObject gameObject = Object.Instantiate(prefab);
			gameObject.name = "_cm_" + prefab.name;
			T component = gameObject.GetComponent<T>();
			if ((Object)component == (Object)null)
			{
				Log.Error("There is no {0} attached to {1}", typeof(T), gameObject);
			}
			return component;
		}

		public GameObject Instantiate(string name, string prefix = "_cm_")
		{
			GameObject prefab = GetPrefab(name);
			GameObject gameObject = Object.Instantiate(prefab);
			gameObject.name = prefix + prefab.name;
			return gameObject;
		}

		public T InstantiateIn<T>(string name, Transform parent) where T : Component
		{
			T result = Instantiate<T>(name);
			Transform component = result.GetComponent<Transform>();
			if (parent == null)
			{
				Log.Error("Attempt to Instantiate prefab {0} in null parent!", name);
			}
			component.SetParent(parent, false);
			return result;
		}

		public void Load(string holder)
		{
			if (holdersByType == null)
			{
				holdersByType = new Dictionary<string, GameObject>();
			}
			if (holdersByType.ContainsKey(holder))
			{
				return;
			}
			if (prefabHoldersContainer_ == null)
			{
				prefabHoldersContainer_ = new GameObject();
				prefabHoldersContainer_.name = "prefabHoldersContainer";
				if (Application.isPlaying)
				{
					Object.DontDestroyOnLoad(prefabHoldersContainer_);
				}
			}
			string path = holder.ToString();
			GameObject gameObject = Object.Instantiate(Resources.Load<GameObject>(path));
			gameObject.transform.SetParent(prefabHoldersContainer_.transform);
			if (prefabsByName == null)
			{
				prefabsByName = new Dictionary<string, GameObject>();
			}
			PrefabsHolderTools.Read(gameObject.GetComponent<PrefabsHolder>(), prefabsByName);
			holdersByType.Add(holder, gameObject);
		}
	}
}
