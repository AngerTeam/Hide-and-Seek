using System;
using System.Runtime.InteropServices;
using UnityEngine;

namespace CraftyVoxelEngine
{
	[Serializable]
	[StructLayout(LayoutKind.Sequential, Pack = 1)]
	public struct VoxelRaycastHit
	{
		[MarshalAs(UnmanagedType.Struct)]
		public Vector3 Point;

		[MarshalAs(UnmanagedType.Struct)]
		public VoxelKey Free;

		[MarshalAs(UnmanagedType.Struct)]
		public VoxelKey Full;

		[MarshalAs(UnmanagedType.I1)]
		public byte side;

		[MarshalAs(UnmanagedType.I1)]
		public bool success;

		[MarshalAs(UnmanagedType.I2)]
		public ushort value;

		[MarshalAs(UnmanagedType.I1)]
		public byte rotation;

		public IntPtr FreeVoxel;

		public IntPtr FullVoxel;

		public static VoxelRaycastHit EmptyMessage;

		static VoxelRaycastHit()
		{
			EmptyMessage.Point = Vector3.zero;
			EmptyMessage.Free = VoxelKey.zero;
			EmptyMessage.Full = VoxelKey.zero;
			EmptyMessage.side = 0;
			EmptyMessage.success = false;
			EmptyMessage.value = 0;
			EmptyMessage.rotation = 0;
			EmptyMessage.FreeVoxel = IntPtr.Zero;
			EmptyMessage.FullVoxel = IntPtr.Zero;
		}
	}
}
