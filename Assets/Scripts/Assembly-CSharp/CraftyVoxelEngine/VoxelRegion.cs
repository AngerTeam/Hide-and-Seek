using System.Runtime.InteropServices;
using UnityEngine;

namespace CraftyVoxelEngine
{
	[StructLayout(LayoutKind.Sequential, Pack = 1)]
	public struct VoxelRegion
	{
		[MarshalAs(UnmanagedType.I1)]
		public byte type;

		[MarshalAs(UnmanagedType.I1)]
		public byte flags;

		[MarshalAs(UnmanagedType.I2)]
		public short id;

		[MarshalAs(UnmanagedType.Struct)]
		public VoxelKey min;

		[MarshalAs(UnmanagedType.Struct)]
		public VoxelKey max;

		public Vector3 center
		{
			get
			{
				return (min + max).ToVector() * 0.5f;
			}
		}

		public Vector3 scale
		{
			get
			{
				return (VoxelKey.Max(min, max) - VoxelKey.Min(min, max)).ToVector();
			}
		}

		public bool allowDig
		{
			get
			{
				return BitMath.GetBit(flags, 0);
			}
			set
			{
				flags = BitMath.SetBit(flags, 0, value);
			}
		}

		public bool allowBuild
		{
			get
			{
				return BitMath.GetBit(flags, 1);
			}
			set
			{
				flags = BitMath.SetBit(flags, 1, value);
			}
		}

		public VoxelRegion([Optional] VoxelKey Min, [Optional] VoxelKey Max)
		{
			type = 0;
			flags = 3;
			id = 0;
			min = VoxelKey.Min(Min, Max);
			max = VoxelKey.Max(Min, Max);
		}

		public VoxelRegion(VoxelRegion region)
		{
			type = 0;
			flags = 0;
			id = 0;
			min = VoxelKey.Min(region.min, region.max);
			max = VoxelKey.Max(region.min, region.max);
		}

		public void Set([Optional] VoxelKey Min, [Optional] VoxelKey Max)
		{
			min = VoxelKey.Min(Min, Max);
			max = VoxelKey.Max(Min, Max);
		}

		public void Update()
		{
			Set(min, max);
		}

		public bool Test(VoxelKey pos)
		{
			return min.x <= pos.x && pos.x <= max.x && min.y <= pos.y && pos.y <= max.y && min.z <= pos.z && pos.z <= max.z;
		}

		public override string ToString()
		{
			return string.Format("Region type:{0} flags:{1} id:{2} range: {3} - {4}", type, flags, id, min.ToString(), max.ToString());
		}
	}
}
