using System;

namespace CraftyVoxelEngine
{
	public class MeshBox : IDisposable
	{
		public VoxelKey chunkKey;

		public MeshHolder solidHolder;

		public MeshHolder transHolder;

		public int SolidLength { get; private set; }

		public int TransLength { get; private set; }

		public int Length { get; private set; }

		public Mesh this[int i]
		{
			get
			{
				if (i < SolidLength)
				{
					return solidHolder.GetMesh(i);
				}
				i -= SolidLength;
				if (i < TransLength)
				{
					return transHolder.GetMesh(i);
				}
				return null;
			}
		}

		public MeshBox(VoxelKey key, IntPtr solid, IntPtr trans)
		{
			MeshHolder solid2 = null;
			MeshHolder trans2 = null;
			if (!solid.Equals(IntPtr.Zero))
			{
				solid2 = new MeshHolder(solid);
			}
			if (!trans.Equals(IntPtr.Zero))
			{
				trans2 = new MeshHolder(trans);
			}
			Init(key, solid2, trans2);
		}

		public MeshBox(VoxelKey key, MeshHolder solid, MeshHolder trans)
		{
			Init(key, solid, trans);
		}

		private void Init(VoxelKey key, MeshHolder solid, MeshHolder trans)
		{
			chunkKey = key;
			solidHolder = solid;
			transHolder = trans;
			SolidLength = ((solidHolder != null) ? solidHolder.Length : 0);
			TransLength = ((transHolder != null) ? transHolder.Length : 0);
			Length = SolidLength + TransLength;
		}

		public void Dispose()
		{
			if (solidHolder != null)
			{
				solidHolder.FreeMeshs();
			}
			if (transHolder != null)
			{
				transHolder.FreeMeshs();
			}
		}
	}
}
