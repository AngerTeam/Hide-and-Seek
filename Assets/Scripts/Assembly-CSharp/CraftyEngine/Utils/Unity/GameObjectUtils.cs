using System;
using System.Collections.Generic;
using UnityEngine;

namespace CraftyEngine.Utils.Unity
{
	public class GameObjectUtils
	{
		private static List<GameObject> cachedChildren_ = new List<GameObject>();

		public static void SetLayer(GameObject gameObject, int layer)
		{
			gameObject.layer = layer;
			SetLayerRecursive(gameObject, layer);
		}

		public static void SetLayerRecursive(GameObject gameObject, int layer)
		{
			GetAllChildren(gameObject, cachedChildren_);
			gameObject.layer = layer;
			for (int i = 0; i < cachedChildren_.Count; i++)
			{
				cachedChildren_[i].layer = layer;
			}
			cachedChildren_.Clear();
		}

		public static List<GameObject> GetAllChildren(GameObject parent)
		{
			List<GameObject> list = new List<GameObject>();
			GetAllChildren(parent, list);
			return list;
		}

		private static void GetAllChildren(GameObject parent, List<GameObject> list)
		{
			for (int i = 0; i < parent.transform.childCount; i++)
			{
				Transform child = parent.transform.GetChild(i);
				list.Add(child.gameObject);
				GetAllChildren(child.gameObject, list);
			}
		}

		public static T Duplicate<T>(T original, bool? setActive = null) where T : Component
		{
			GameObject gameObject = Duplicate(original.gameObject, setActive);
			return gameObject.GetComponent<T>();
		}

		public static GameObject Duplicate(Component original, bool? setActive = null)
		{
			return Duplicate(original.gameObject, setActive);
		}

		public static GameObject Duplicate(GameObject original, bool? setActive = null)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(original);
			if (setActive.HasValue)
			{
				gameObject.SetActive(setActive.Value);
			}
			gameObject.transform.SetParent(original.transform.parent, false);
			return gameObject;
		}

		public static GameObject FindChild(GameObject parent, string name, bool strongMatch = true)
		{
			if (parent == null)
			{
				return null;
			}
			bool strongMatch2 = strongMatch;
			Transform transform = FindChild(parent.transform, name, false, strongMatch2);
			return (!transform) ? null : transform.gameObject;
		}

		public static Transform FindChild(Transform parent, string name, bool ignoreCase = false, bool strongMatch = true)
		{
			if (ignoreCase)
			{
				name = name.ToLower();
			}
			if (parent == null)
			{
				return null;
			}
			int i = 0;
			for (int childCount = parent.childCount; i < childCount; i++)
			{
				Transform child = parent.GetChild(i);
				string text = ((!ignoreCase) ? child.name : child.name.ToLower());
				if ((!strongMatch) ? text.Contains(name) : (text == name))
				{
					return child;
				}
			}
			int j = 0;
			for (int childCount2 = parent.childCount; j < childCount2; j++)
			{
				Transform child = FindChild(parent.GetChild(j), name, ignoreCase, strongMatch);
				if (child != null)
				{
					return child;
				}
			}
			return null;
		}

		public static void ReassignShaders(GameObject gameObject)
		{
			Renderer[] componentsInChildren = gameObject.GetComponentsInChildren<Renderer>(true);
			foreach (Renderer renderer in componentsInChildren)
			{
				if (renderer.sharedMaterials == null)
				{
					continue;
				}
				Material[] sharedMaterials = renderer.sharedMaterials;
				foreach (Material material in sharedMaterials)
				{
					if (material != null)
					{
						string name = material.shader.name;
						Shader shader = Shader.Find(name);
						if (shader != null)
						{
							material.shader = shader;
						}
					}
				}
			}
		}

		public static void SwitchActive(GameObject obj, bool activate)
		{
			if (obj == null)
			{
				Log.Warning("Warning: Obj is null");
			}
			else if (obj.activeSelf != activate)
			{
				obj.SetActive(activate);
			}
		}

		public static void SwitchColliders(GameObject gameObject, bool active)
		{
			Collider[] components = gameObject.GetComponents<Collider>();
			foreach (Collider collider in components)
			{
				collider.enabled = active;
			}
			Collider[] componentsInChildren = gameObject.GetComponentsInChildren<Collider>();
			foreach (Collider collider2 in componentsInChildren)
			{
				collider2.enabled = active;
			}
		}

		internal static T[] GetComponentsInChildren<T>(GameObject gameObject, bool includeSelf = false) where T : Component
		{
			List<GameObject> allChildren = GetAllChildren(gameObject);
			List<T> list = new List<T>();
			for (int i = 0; i < allChildren.Count; i++)
			{
				T component = allChildren[i].GetComponent<T>();
				if ((UnityEngine.Object)component != (UnityEngine.Object)null)
				{
					list.Add(component);
				}
			}
			if (includeSelf)
			{
				T component2 = gameObject.GetComponent<T>();
				if ((UnityEngine.Object)component2 != (UnityEngine.Object)null)
				{
					list.Insert(0, component2);
				}
			}
			return list.ToArray();
		}

		public static T GetComponentInParents<T>(GameObject gameObject) where T : Component
		{
			Transform transform = gameObject.transform;
			int num = 0;
			while (transform != null)
			{
				num++;
				if (num == 64)
				{
					throw new StackOverflowException();
				}
				T component = transform.gameObject.GetComponent<T>();
				if ((UnityEngine.Object)component == (UnityEngine.Object)null)
				{
					transform = transform.parent;
					continue;
				}
				return component;
			}
			return (T)null;
		}
	}
}
