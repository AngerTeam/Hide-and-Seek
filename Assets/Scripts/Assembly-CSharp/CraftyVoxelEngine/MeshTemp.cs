using UnityEngine;

namespace CraftyVoxelEngine
{
	public class MeshTemp
	{
		private bool filled;

		private Vector3[] vertexes;

		private Vector3[] normals;

		private Vector2[] uvs;

		private Color32[] colors;

		private int[] triangles;

		public MeshTemp()
		{
		}

		public MeshTemp(Mesh mesh)
		{
			Get(mesh);
		}

		public void Get(Mesh mesh)
		{
			if (mesh != null)
			{
				filled = true;
				vertexes = mesh.vertexes;
				normals = mesh.normals;
				uvs = mesh.uvs;
				colors = mesh.colors;
				triangles = mesh.triangles;
			}
			else
			{
				Log.Warning("Voxel Mesh are null!");
			}
		}

		public void Set(UnityEngine.Mesh mesh)
		{
			if (filled)
			{
				mesh.Clear();
				mesh.vertices = vertexes;
				mesh.normals = normals;
				mesh.uv = uvs;
				mesh.colors32 = colors;
				mesh.triangles = triangles;
				mesh.RecalculateBounds();
			}
		}
	}
}
