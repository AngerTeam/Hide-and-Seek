using System;
using System.Collections.Generic;
using UnityEngine;

namespace CraftyVoxelEngine
{
	[Serializable]
	public struct VoxelKey : IEqualityComparer<VoxelKey>, IIntVector3
	{
		private const char PARSE_SPLIT_CHAR = ';';

		public int x;

		public int y;

		public int z;

		public static readonly VoxelKey KeyPX = new VoxelKey(1, 0, 0);

		public static readonly VoxelKey KeyNX = new VoxelKey(-1, 0, 0);

		public static readonly VoxelKey KeyPY = new VoxelKey(0, 1, 0);

		public static readonly VoxelKey KeyNY = new VoxelKey(0, -1, 0);

		public static readonly VoxelKey KeyPZ = new VoxelKey(0, 0, 1);

		public static readonly VoxelKey KeyNZ = new VoxelKey(0, 0, -1);

		public static readonly VoxelKey[] Directions = new VoxelKey[6] { KeyPX, KeyNX, KeyPY, KeyNY, KeyPZ, KeyNZ };

		public static readonly VoxelKey zero = new VoxelKey(0, 0, 0);

		public static readonly VoxelKey one = new VoxelKey(1, 1, 1);

		public int X
		{
			get
			{
				return x;
			}
			set
			{
				x = value;
			}
		}

		public int Y
		{
			get
			{
				return y;
			}
			set
			{
				y = value;
			}
		}

		public int Z
		{
			get
			{
				return z;
			}
			set
			{
				z = value;
			}
		}

		public VoxelKey(int s)
		{
			x = (y = (z = s));
		}

		public VoxelKey(Vector3 fromVector)
		{
			x = (int)fromVector.x;
			y = (int)fromVector.y;
			z = (int)fromVector.z;
		}

		public VoxelKey(int x, int y, int z)
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}

		public VoxelKey Set(int x, int y, int z)
		{
			this.x = x;
			this.y = y;
			this.z = z;
			return this;
		}

		public VoxelKey Set(Vector3 vec)
		{
			x = (int)vec.x;
			y = (int)vec.y;
			z = (int)vec.z;
			return this;
		}

		public Vector3 ToVector()
		{
			return new Vector3(x, y, z);
		}

		public bool InRange(int MinX, int MaxX, int MinY, int MaxY, int MinZ, int MaxZ)
		{
			return InRange(MinX, MaxX, x) && InRange(MinY, MaxY, y) && InRange(MinZ, MaxZ, z);
		}

		private bool InRange(int Min, int Max, int Val)
		{
			return Min <= Val && Val < Max;
		}

		public static VoxelKey Min(VoxelKey a, VoxelKey b)
		{
			return new VoxelKey(Math.Min(a.x, b.x), Math.Min(a.y, b.y), Math.Min(a.z, b.z));
		}

		public static VoxelKey Max(VoxelKey a, VoxelKey b)
		{
			return new VoxelKey(Math.Max(a.x, b.x), Math.Max(a.y, b.y), Math.Max(a.z, b.z));
		}

		public bool Equals(VoxelKey other)
		{
			return x == other.x && y == other.y && z == other.z;
		}

		public override string ToString()
		{
			return string.Format("{0}x{1}x{2}", x, y, z);
		}

		public static VoxelKey SafeParse(string source, char splitChar = ';')
		{
			try
			{
				string[] array = source.Split(splitChar);
				int num = int.Parse(array[0]);
				int num2 = int.Parse(array[1]);
				int num3 = int.Parse(array[2]);
				return new VoxelKey(num, num2, num3);
			}
			catch
			{
				return zero;
			}
		}

		public bool Equals(VoxelKey a, VoxelKey b)
		{
			return a.Equals(b);
		}

		public int GetHashCode(VoxelKey obj)
		{
			return (x << 16) | (y << 8) | z;
		}

		public static VoxelKey operator +(VoxelKey a, int b)
		{
			return new VoxelKey(a.x + b, a.y + b, a.z + b);
		}

		public static VoxelKey operator -(VoxelKey a, int b)
		{
			return new VoxelKey(a.x - b, a.y - b, a.z - b);
		}

		public static VoxelKey operator +(VoxelKey a, VoxelKey b)
		{
			return new VoxelKey(a.x + b.x, a.y + b.y, a.z + b.z);
		}

		public static VoxelKey operator -(VoxelKey a, VoxelKey b)
		{
			return new VoxelKey(a.x - b.x, a.y - b.y, a.z - b.z);
		}

		public static VoxelKey operator +(VoxelKey a, Vector3 b)
		{
			return new VoxelKey(a.x + (int)b.x, a.y + (int)b.y, a.z + (int)b.z);
		}

		public static VoxelKey operator +(Vector3 a, VoxelKey b)
		{
			return new VoxelKey((int)a.x + b.x, (int)a.y + b.y, (int)a.z + b.z);
		}

		public static VoxelKey operator -(VoxelKey a, Vector3 b)
		{
			return new VoxelKey(a.x - (int)b.x, a.y - (int)b.y, a.z - (int)b.z);
		}

		public static VoxelKey operator -(Vector3 a, VoxelKey b)
		{
			return new VoxelKey((int)a.x - b.x, (int)a.y - b.y, (int)a.z - b.z);
		}

		public static VoxelKey operator *(VoxelKey a, int i)
		{
			return new VoxelKey(a.x * i, a.y * i, a.z * i);
		}

		public static VoxelKey operator %(VoxelKey a, int i)
		{
			return new VoxelKey(a.x % i, a.y % i, a.z % i);
		}

		public static VoxelKey operator *(VoxelKey a, float f)
		{
			return new VoxelKey((int)((float)a.x * f), (int)((float)a.y * f), (int)((float)a.z * f));
		}

		public static VoxelKey operator /(VoxelKey a, float f)
		{
			return new VoxelKey((int)((float)a.x / f), (int)((float)a.y / f), (int)((float)a.z / f));
		}
	}
}
