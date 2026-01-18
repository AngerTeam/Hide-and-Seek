using System;
using System.Runtime.InteropServices;

namespace CraftyVoxelEngine
{
	[Serializable]
	[StructLayout(LayoutKind.Sequential, Pack = 1)]
	public struct KeyedVoxel
	{
		[MarshalAs(UnmanagedType.I4)]
		public int x;

		[MarshalAs(UnmanagedType.I4)]
		public int y;

		[MarshalAs(UnmanagedType.I4)]
		public int z;

		[MarshalAs(UnmanagedType.I2)]
		public ushort Value;

		[MarshalAs(UnmanagedType.I1)]
		public byte Rotation;

		public KeyedVoxel(VoxelKey key, Voxel voxel)
		{
			x = key.x;
			y = key.y;
			z = key.z;
			Value = voxel.Value;
			Rotation = voxel.Rotation;
		}

		public KeyedVoxel(VoxelKey key, ushort value, byte rotation = 0)
		{
			x = key.x;
			y = key.y;
			z = key.z;
			Value = value;
			Rotation = rotation;
		}

		public VoxelKey GetKey()
		{
			return new VoxelKey(x, y, z);
		}
	}
}
