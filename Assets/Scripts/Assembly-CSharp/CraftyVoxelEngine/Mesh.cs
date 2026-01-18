using System;
using System.Runtime.InteropServices;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class Mesh
	{
		public struct TempColor
		{
			public byte r;

			public byte g;

			public byte b;

			public byte a;
		}

		private IntPtr pointer;

		public Vector3[] vertexes
		{
			get
			{
				int vertexesLength = GetVertexesLength(pointer);
				Vector3[] array = new Vector3[vertexesLength];
				if (vertexesLength > 0)
				{
					GetVertexesFill(pointer, array);
				}
				return array;
			}
		}

		public Vector3[] normals
		{
			get
			{
				int normalsLength = GetNormalsLength(pointer);
				Vector3[] array = new Vector3[normalsLength];
				if (normalsLength > 0)
				{
					GetNormalsFill(pointer, array);
				}
				return array;
			}
		}

		public Vector2[] uvs
		{
			get
			{
				int texturesLength = GetTexturesLength(pointer);
				Vector2[] array = new Vector2[texturesLength];
				if (texturesLength > 0)
				{
					GetTexturesFill(pointer, array);
				}
				return array;
			}
		}

		public Color32[] colors
		{
			get
			{
				int colorsLength = GetColorsLength(pointer);
				Color32[] array = new Color32[colorsLength];
				if (colorsLength > 0)
				{
					GetColorsFill(pointer, array);
				}
				return array;
			}
		}

		public int[] triangles
		{
			get
			{
				int trianglesLength = GetTrianglesLength(pointer);
				int[] array = new int[trianglesLength];
				if (trianglesLength > 0)
				{
					GetTrianglesFill(pointer, array);
				}
				return array;
			}
		}

		public Mesh(IntPtr pointer)
		{
			this.pointer = pointer;
		}

		[DllImport("VoxelCore")]
		private static extern Vector3[] GetVertexes(IntPtr mesh);

		[DllImport("VoxelCore")]
		private static extern Vector3[] GetNormals(IntPtr mesh);

		[DllImport("VoxelCore")]
		private static extern Vector2[] GetTextures(IntPtr mesh);

		[DllImport("VoxelCore")]
		private static extern Color32[] GetColors(IntPtr mesh);

		[DllImport("VoxelCore")]
		private static extern int[] GetTriangles(IntPtr mesh);

		[DllImport("VoxelCore")]
		private static extern int GetVertexesLength(IntPtr mesh);

		[DllImport("VoxelCore")]
		private static extern int GetNormalsLength(IntPtr mesh);

		[DllImport("VoxelCore")]
		private static extern int GetTexturesLength(IntPtr mesh);

		[DllImport("VoxelCore")]
		private static extern int GetColorsLength(IntPtr mesh);

		[DllImport("VoxelCore")]
		private static extern int GetTrianglesLength(IntPtr mesh);

		[DllImport("VoxelCore")]
		private static extern IntPtr GetVertexesRaw(IntPtr mesh);

		[DllImport("VoxelCore")]
		private static extern IntPtr GetNormalsRaw(IntPtr mesh);

		[DllImport("VoxelCore")]
		private static extern IntPtr GetTexturesRaw(IntPtr mesh);

		[DllImport("VoxelCore")]
		private static extern IntPtr GetColorsRaw(IntPtr mesh);

		[DllImport("VoxelCore")]
		private static extern IntPtr GetTrianglesRaw(IntPtr mesh);

		[DllImport("VoxelCore")]
		private static extern void GetVertexesFill(IntPtr mesh, Vector3[] data);

		[DllImport("VoxelCore")]
		private static extern void GetNormalsFill(IntPtr mesh, Vector3[] data);

		[DllImport("VoxelCore")]
		private static extern void GetTexturesFill(IntPtr mesh, Vector2[] data);

		[DllImport("VoxelCore")]
		private static extern void GetColorsFill(IntPtr mesh, Color32[] data);

		[DllImport("VoxelCore")]
		private static extern void GetTrianglesFill(IntPtr mesh, int[] data);

		public override bool Equals(object o)
		{
			try
			{
				Mesh mesh = (Mesh)o;
				if (this != mesh)
				{
					return pointer.Equals(mesh.pointer);
				}
				return true;
			}
			catch
			{
			}
			return false;
		}

		public override int GetHashCode()
		{
			return pointer.ToInt32();
		}
	}
}
