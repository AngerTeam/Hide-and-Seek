using System;
using System.Runtime.InteropServices;
using UnityEngine;

namespace CraftyVoxelEngine
{
	[Serializable]
	[StructLayout(LayoutKind.Sequential, Pack = 1)]
	public struct CircleHit
	{
		[MarshalAs(UnmanagedType.Struct)]
		public Vector3 Point;

		[MarshalAs(UnmanagedType.I1)]
		public bool success;

		[MarshalAs(UnmanagedType.R4)]
		public float distance;

		public CircleHit(bool suc)
		{
			Point = Vector3.zero;
			success = suc;
			distance = 10000000f;
		}
	}
}
