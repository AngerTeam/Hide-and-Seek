using System.Collections.Generic;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class ChunkView
	{
		public VoxelKey ChunkKey;

		public VoxelViewManager viewManager;

		public bool visible;

		public List<ChunkViewHierarchy> Views { get; private set; }

		public ChunkView()
		{
			visible = true;
			Views = new List<ChunkViewHierarchy>();
		}

		public ChunkViewHierarchy GetOrCreate(int i)
		{
			if (i < Views.Count)
			{
				return Views[i];
			}
			ChunkViewHierarchy chunkViewHierarchy = viewManager.CreateMeshObject(ChunkKey, i);
			Views.Add(chunkViewHierarchy);
			return chunkViewHierarchy;
		}

		public void SetActive(bool active)
		{
			visible = active;
			int count = Views.Count;
			for (int i = 0; i < count; i++)
			{
				Views[i].gameObject.SetActive(active);
			}
		}

		public void Clear()
		{
			int count = Views.Count;
			for (int i = 0; i < count; i++)
			{
				Object.Destroy(Views[i].gameObject);
			}
			Views.Clear();
		}
	}
}
