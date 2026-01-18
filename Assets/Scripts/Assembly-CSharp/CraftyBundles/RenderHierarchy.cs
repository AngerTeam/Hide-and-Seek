using System;
using UnityEngine;

namespace CraftyBundles
{
	[Serializable]
	public class RenderHierarchy
	{
		public RenderHierarchyNode[] hierarchy;

		public RenderHierarchyMaterial[] materials;

		[NonSerialized]
		public Texture[] textures;
	}
}
