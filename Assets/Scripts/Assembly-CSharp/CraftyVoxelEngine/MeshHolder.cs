using System;
using System.Runtime.InteropServices;
using UnityEngine;

namespace CraftyVoxelEngine
{
	public class MeshHolder
	{
		public IntPtr pointer;

		private int index;

		public int Length
		{
			get
			{
				return Size(pointer);
			}
		}

		public MeshHolder(IntPtr pointer)
		{
			this.pointer = pointer;
		}

		[DllImport("VoxelCore")]
		private static extern int Size(IntPtr holder);

		[DllImport("VoxelCore")]
		private static extern IntPtr GetMesh(IntPtr holder, int i);

		[DllImport("VoxelCore")]
		private static extern void FreeMeshs(IntPtr holder);

		public Mesh GetMesh(int i)
		{
			IntPtr mesh = GetMesh(pointer, i);
			if (!mesh.Equals(IntPtr.Zero))
			{
				return new Mesh(mesh);
			}
			return null;
		}

		public void FreeMeshs()
		{
			FreeMeshs(pointer);
			index = 0;
		}

		public GameObject GetMesh()
		{
			if (index >= Length)
			{
				FreeMeshs(pointer);
				return null;
			}
			GameObject result = null;
			Mesh mesh = GetMesh(index);
			if (mesh != null)
			{
				result = MakeObject(mesh, index);
			}
			index++;
			return result;
		}

		public GameObject MakeObject(Mesh mesh, int index = 0)
		{
			GameObject gameObject = new GameObject();
			MeshFilter filter = gameObject.AddComponent<MeshFilter>();
			MakeMesh(filter, mesh);
			gameObject.AddComponent<MeshRenderer>();
			return gameObject;
		}

		public void MakeMesh(MeshFilter filter, int mesh = 0)
		{
			MakeMesh(filter, GetMesh(mesh));
		}

		public void MakeMesh(MeshFilter filter, Mesh mesh)
		{
			if (filter == null)
			{
				Log.Warning("MeshHolder.MakeMesh: filter is null!");
			}
			if (mesh == null)
			{
				Log.Warning("MeshHolder.MakeMesh: mesh is null!");
			}
			UnityEngine.Mesh mesh2 = new UnityEngine.Mesh();
			if (mesh2 == null)
			{
				Log.Warning("MeshHolder.MakeMesh: instance mesh is null! (То есть только что созданный объект уже null!!)");
			}
			mesh2.vertices = mesh.vertexes;
			mesh2.normals = mesh.normals;
			mesh2.uv = mesh.uvs;
			mesh2.triangles = mesh.triangles;
			mesh2.colors32 = mesh.colors;
			filter.mesh = mesh2;
		}
	}
}
