using CraftyEngine.Infrastructure;
using UnityEngine;
using UnityEngine.UI;

namespace NguiTools
{
	public class PrefabsManagerNGUI : PrefabsManager
	{
		public T InstantiateAndSetUIText<T>(PrefabNames name, string title) where T : Component
		{
			T val = Instantiate<T>(name.ToString());
			SetUIText(val, title);
			return val;
		}

		public T InstantiateInAndSetUIText<T>(PrefabNames name, Transform parent, string title) where T : Component
		{
			T val = InstantiateIn<T>(name.ToString(), parent);
			SetUIText(val, title);
			return val;
		}

		public T InstantiateNGUI<T>(string name) where T : Component
		{
			GameObject prefab = GetPrefab(name.ToString());
			GameObject gameObject = Object.Instantiate(prefab);
			T component = gameObject.GetComponent<T>();
			if ((Object)component == (Object)null)
			{
				Log.Error("There is no {0} attached to {1}", typeof(T), gameObject);
			}
			return component;
		}

		public T InstantiateNGUIIn<T>(string name, GameObject parent) where T : Component
		{
			GameObject prefab = GetPrefab(name.ToString());
			if (parent == null)
			{
				Log.Error("Attempt to AddChild prefab {0} in null parent!", name);
			}
			GameObject gameObject = parent.AddChild(prefab);
			T component = gameObject.GetComponent<T>();
			if ((Object)component == (Object)null)
			{
				Log.Error("There is no {0} attached to {1}", typeof(T), gameObject);
			}
			return component;
		}

		public T InstantiateNGUIInAndSetUIText<T>(string name, GameObject parent, string title) where T : Component
		{
			T val = InstantiateNGUIIn<T>(name, parent);
			UILabel componentInChildren = val.GetComponentInChildren<UILabel>();
			if (componentInChildren == null)
			{
				Log.Error("There is no UILabel component in {0} hierarchy", val);
			}
			else
			{
				componentInChildren.text = title;
			}
			return val;
		}

		private void SetUIText(Component instance, string title)
		{
			Text componentInChildren = instance.GetComponentInChildren<Text>();
			if (componentInChildren == null)
			{
				Log.Error("There is no Text component in {0} hierarchy", instance);
			}
			else
			{
				componentInChildren.text = title;
			}
		}
	}
}
