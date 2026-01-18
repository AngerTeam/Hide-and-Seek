using UnityEngine;

namespace CraftyVoxelEngine.Clouds
{
	public class CloudView
	{
		private MeshFilter meshFilter_;

		public GameObject GameObject { get; private set; }

		public UnityEngine.Mesh Mesh { get; private set; }

		public CloudView(Material material, Transform parent, Vector3 position, bool addRenderer)
		{
			GameObject = new GameObject();
			GameObject.layer = parent.gameObject.layer;
			Mesh = new UnityEngine.Mesh();
			if (addRenderer)
			{
				MeshRenderer meshRenderer = GameObject.AddComponent<MeshRenderer>();
				meshFilter_ = GameObject.AddComponent<MeshFilter>();
				meshRenderer.sharedMaterial = material;
				meshFilter_.sharedMesh = Mesh;
			}
			GameObject.transform.SetParent(parent, false);
			GameObject.transform.localPosition = position;
		}

		internal void Clear()
		{
			if (meshFilter_ != null)
			{
				meshFilter_.sharedMesh = null;
			}
			if (GameObject != null)
			{
				GameObject.SetActive(false);
			}
		}

		internal void RefreshMesh(bool clear = false)
		{
			if (meshFilter_ != null)
			{
				Mesh.RecalculateBounds();
				meshFilter_.sharedMesh = Mesh;
			}
			GameObject.SetActive(true);
		}
	}
}
