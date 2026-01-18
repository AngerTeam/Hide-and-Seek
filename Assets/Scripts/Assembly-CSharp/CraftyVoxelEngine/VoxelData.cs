using System.Runtime.InteropServices;
using UnityEngine;

namespace CraftyVoxelEngine
{
	[StructLayout(LayoutKind.Sequential, Pack = 1)]
	public struct VoxelData
	{
		[MarshalAs(UnmanagedType.I4)]
		public int Flags;

		[MarshalAs(UnmanagedType.I4)]
		public int Logic;

		[MarshalAs(UnmanagedType.I4)]
		public int Options;

		[MarshalAs(UnmanagedType.Struct)]
		public Color32 LightColor;

		[MarshalAs(UnmanagedType.I4)]
		public int ModelID;

		[MarshalAs(UnmanagedType.I4)]
		public int SoundGroupDig;

		[MarshalAs(UnmanagedType.I4)]
		public int SoundGroupPop;

		[MarshalAs(UnmanagedType.I4)]
		public int SoundGroupStp;

		[MarshalAs(UnmanagedType.R4)]
		public float ScaleInHand;

		[MarshalAs(UnmanagedType.I4)]
		public int BuildingID;

		[MarshalAs(UnmanagedType.I4)]
		public int DropArtikulID;

		[MarshalAs(UnmanagedType.I4)]
		public int Durability;

		[MarshalAs(UnmanagedType.I4)]
		public int DurabilityTypeID;

		[MarshalAs(UnmanagedType.I4)]
		public int VoxelID;

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

		public bool LightSource
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

		public bool Interactive
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

		public bool IsBox
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

		public bool SplitBySides
		{
			get
			{
				return BitMath.GetBit(Flags, 4);
			}
			set
			{
				Flags = BitMath.SetBit(Flags, 4, value);
			}
		}

		public bool NotBuildOnGround
		{
			get
			{
				return BitMath.GetBit(Logic, 0);
			}
			set
			{
				Logic = BitMath.SetBit(Logic, 0, value);
			}
		}

		public bool NotBuildOnWallOrCeil
		{
			get
			{
				return BitMath.GetBit(Logic, 1);
			}
			set
			{
				Logic = BitMath.SetBit(Logic, 1, value);
			}
		}

		public bool ChangeWhenCovered
		{
			get
			{
				return BitMath.GetBit(Logic, 2);
			}
			set
			{
				Logic = BitMath.SetBit(Logic, 2, value);
			}
		}

		public bool CanRotateInHand
		{
			get
			{
				return BitMath.GetBit(Logic, 3);
			}
			set
			{
				Logic = BitMath.SetBit(Logic, 3, value);
			}
		}

		public bool TorchRotation
		{
			get
			{
				return BitMath.GetBit(Logic, 4);
			}
			set
			{
				Logic = BitMath.SetBit(Logic, 4, value);
			}
		}

		public bool StairRotation
		{
			get
			{
				return BitMath.GetBit(Logic, 5);
			}
			set
			{
				Logic = BitMath.SetBit(Logic, 5, value);
			}
		}

		public bool Replaceble
		{
			get
			{
				return BitMath.GetBit(Logic, 6);
			}
			set
			{
				Logic = BitMath.SetBit(Logic, 6, value);
			}
		}

		public bool NoCollide
		{
			get
			{
				return BitMath.GetBit(Options, 0);
			}
			set
			{
				Options = BitMath.SetBit(Options, 0, value);
			}
		}

		public bool NoCracks
		{
			get
			{
				return BitMath.GetBit(Options, 1);
			}
			set
			{
				Options = BitMath.SetBit(Options, 1, value);
			}
		}

		public override string ToString()
		{
			string text = string.Format("\n\tSoundGroups: {0} {1} {2}\n\tScaleInHand: {3}\n\tBuildingID: {4}\n\tDropArtikulID: {5}\n\tDurability: {6}\n\tDurabilityTypeID: {7}\n\tVoxelID: {8}", SoundGroupDig, SoundGroupPop, SoundGroupStp, ScaleInHand, BuildingID, DropArtikulID, Durability, DurabilityTypeID, VoxelID);
			return string.Format("VoxelData\n\tFlags: {0}\n\tLogic: {1}\n\tOptions: {2}\n\tLightColor: {3}\n\tModelID: {4}\n\tNoCollide: {5}\n{6}\n\n", Flags, Logic, Options, LightColor.ToString(), ModelID, NoCollide, text);
		}
	}
}
