using System;
using UnityEngine;

namespace CraftyBundles
{
	[Serializable]
	public class RenderHierarchyMaterial
	{
		public int id;

		public string name;

		public string shaderName;

		public ShaderProperty[] shaderProperties;

		[NonSerialized]
		public Material material;
	}
}
