using System;
using System.Text;
using UnityEngine;

namespace CraftyVoxelEngine.Clouds
{
	public class VoxelMesh
	{
		public const int VERTEX_PER_QUAD = 4;

		public const int INDEX_PER_QUAD = 6;

		public int visibleQuadCount;

		public int poolSizeIndex;

		public Vector3[] normals;

		public int[] triangles;

		public Vector2[] uv;

		public Vector3[] vertices;

		public Color32[] colors;

		private static Color32 emptyColor = Color.white;

		private int maxVerteclesCount;

		private int maxIndexesCount;

		private static readonly Vector3 zero = Vector3.zero;

		private static int maxOverhead;

		private static int totalQuadValue;

		private static int totalOverheadValue;

		private static int totalCount;

		internal bool free;

		public int MaxQuadCount { get; private set; }

		public void SetSize(int maxQuadCount)
		{
			if (maxQuadCount < 1)
			{
				throw new Exception(string.Format("Wrong maxQuadCount {0}!", maxQuadCount));
			}
			MaxQuadCount = maxQuadCount;
			maxVerteclesCount = maxQuadCount * 4;
			maxIndexesCount = maxQuadCount * 6;
			normals = new Vector3[maxVerteclesCount];
			triangles = new int[maxIndexesCount];
			uv = new Vector2[maxVerteclesCount];
			vertices = new Vector3[maxVerteclesCount];
			colors = new Color32[maxVerteclesCount];
		}

		public void PushMesh(VoxelMesh otherMesh)
		{
			PushMesh(otherMesh, Vector3.one * 0.5f, Quaternion.identity, new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, byte.MaxValue));
		}

		public void PushMesh(VoxelMesh otherMesh, Vector3 offset, Quaternion rotor, Color32 color)
		{
			if (otherMesh == null)
			{
				Log.Warning("Null mesh pushed!!!");
				return;
			}
			bool flag = true;
			int num = visibleQuadCount * 4;
			int num2 = visibleQuadCount * 6;
			if (maxVerteclesCount < otherMesh.maxVerteclesCount)
			{
				flag = false;
			}
			if (vertices.Length - num < otherMesh.vertices.Length)
			{
				flag = false;
			}
			if (triangles.Length - num2 < otherMesh.triangles.Length)
			{
				flag = false;
			}
			if (!flag)
			{
				Log.Warning("Can't push mesh into other because it's too huge!");
				return;
			}
			for (int i = 0; i < otherMesh.vertices.Length; i++)
			{
				vertices[num + i] = rotor * otherMesh.vertices[i] + offset;
				normals[num + i] = rotor * otherMesh.normals[i];
				colors[num + i] = color;
				uv[num + i] = otherMesh.uv[i];
			}
			for (int j = 0; j < otherMesh.triangles.Length; j++)
			{
				triangles[num2 + j] = otherMesh.triangles[j] + num;
			}
			visibleQuadCount += otherMesh.visibleQuadCount;
		}

		internal void CopyTo(VoxelMesh mesh)
		{
			int length = visibleQuadCount * 4;
			int length2 = visibleQuadCount * 6;
			Array.Copy(vertices, mesh.vertices, length);
			Array.Copy(normals, mesh.normals, length);
			Array.Copy(uv, mesh.uv, length);
			Array.Copy(colors, mesh.colors, length);
			Array.Copy(triangles, mesh.triangles, length2);
		}

		public void FillRestOfMeshWithVoid(bool reportOverhead = false)
		{
			for (int i = visibleQuadCount * 4; i < maxVerteclesCount; i++)
			{
				vertices[i] = zero;
				normals[i] = zero;
				uv[i] = zero;
				colors[i] = emptyColor;
			}
			for (int j = visibleQuadCount * 6; j < maxIndexesCount; j++)
			{
				triangles[j] = 0;
			}
			if (reportOverhead)
			{
				int num = MaxQuadCount - visibleQuadCount;
				if (num > maxOverhead)
				{
					maxOverhead = num;
				}
				totalQuadValue += visibleQuadCount;
				totalOverheadValue += num;
				totalCount++;
				float num2 = (float)totalOverheadValue / (float)totalCount;
				float num3 = (float)totalQuadValue / (float)totalCount;
				Log.Info("avarage overhead", num2, "max overhead", maxOverhead, "avarage mesh", num3);
				visibleQuadCount = MaxQuadCount;
			}
		}

		internal void FlushToUnity(UnityEngine.Mesh mesh)
		{
			mesh.Clear();
			if (vertices.Length == 0)
			{
				Log.Warning("Attempt to pass empty mesh to {0}", mesh);
			}
			else
			{
				mesh.vertices = vertices;
				mesh.normals = normals;
				mesh.uv = uv;
				mesh.colors32 = colors;
				mesh.triangles = triangles;
			}
			mesh.RecalculateBounds();
		}

		public string Dump()
		{
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.Append("Quad Count " + visibleQuadCount);
			for (int i = 0; i < vertices.Length; i++)
			{
				stringBuilder.Append("\n\t");
				stringBuilder.Append(vertices[i].ToString());
				stringBuilder.Append("\t");
				stringBuilder.Append(normals[i].ToString());
				stringBuilder.Append("\t");
				stringBuilder.Append(uv[i].ToString());
			}
			stringBuilder.Append("\nTriangles:");
			for (int j = 0; j < vertices.Length; j += 3)
			{
				stringBuilder.Append("\n\t");
				stringBuilder.Append(triangles[j]);
				stringBuilder.Append("\t");
				stringBuilder.Append(triangles[j + 1]);
				stringBuilder.Append("\t");
				stringBuilder.Append(triangles[j + 2]);
			}
			return stringBuilder.ToString();
		}
	}
}
