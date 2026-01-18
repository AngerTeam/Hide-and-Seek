using System;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class ChunkViewHierarchy : MonoBehaviour
	{
		public MeshFilter filter;

		public MeshRenderer render;

		[NonSerialized]
		public bool solid;
	}
}
