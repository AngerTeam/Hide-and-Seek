using System;
using UnityEngine;

namespace CraftyBundles
{
	[Serializable]
	public class RenderHierarchyNode
	{
		public int id;

		public int childId;

		public string name;

		public int parent;

		public int[] materialId;

		[NonSerialized]
		public Transform transform;

		[NonSerialized]
		public Renderer renderer;
	}
}
