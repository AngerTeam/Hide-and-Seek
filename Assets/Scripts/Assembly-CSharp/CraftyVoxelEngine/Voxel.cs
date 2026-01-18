using System;
using System.Runtime.InteropServices;
using UnityEngine;

namespace CraftyVoxelEngine
{
	[Serializable]
	[StructLayout(LayoutKind.Sequential, Pack = 1)]
	public struct Voxel
	{
		[MarshalAs(UnmanagedType.I2)]
		public ushort Value;

		[MarshalAs(UnmanagedType.I1)]
		public byte Rotation;

		[MarshalAs(UnmanagedType.I1)]
		public byte Flags;

		[MarshalAs(UnmanagedType.Struct)]
		public Color32 Light;

		public bool Visible
		{
			get
			{
				return Value != 0;
			}
		}

		public bool Transparency
		{
			get
			{
				return BitMath.GetBit(Flags, 0);
			}
			set
			{
				Flags = BitMath.SetBit(Flags, 0, value);
			}
		}

		public bool Indestructible
		{
			get
			{
				return BitMath.GetBit(Flags, 1);
			}
			set
			{
				Flags = BitMath.SetBit(Flags, 1, value);
			}
		}

		public bool LightSrc
		{
			get
			{
				return BitMath.GetBit(Flags, 2);
			}
			set
			{
				Flags = BitMath.SetBit(Flags, 2, value);
			}
		}

		public bool LightDay
		{
			get
			{
				return BitMath.GetBit(Flags, 3);
			}
			set
			{
				Flags = BitMath.SetBit(Flags, 3, value);
			}
		}

		public override string ToString()
		{
			return string.Format("Voxel {0} {1}{2}{3}{4}", Value, (!Visible) ? "Invisible" : string.Empty, (!Transparency) ? string.Empty : ", Transparent", (!LightSrc) ? string.Empty : ", Light source", (!Indestructible) ? string.Empty : ", Indestructable");
		}
	}
}
