using UnityEngine;

namespace CraftyVoxelEngine
{
	public class VoxelMath
	{
		private static byte[] TorchDirections = new byte[6] { 1, 3, 0, 0, 4, 2 };

		public static readonly byte[] XP90 = new byte[24]
		{
			17, 18, 19, 16, 5, 6, 7, 4, 1, 2,
			3, 0, 15, 12, 13, 14, 23, 20, 21, 22,
			11, 8, 9, 10
		};

		public static readonly byte[] XN90 = new byte[24]
		{
			11, 8, 9, 10, 7, 4, 5, 6, 21, 22,
			23, 20, 13, 14, 15, 12, 3, 0, 1, 2,
			17, 18, 19, 16
		};

		public static readonly byte[] YP90 = new byte[24]
		{
			3, 0, 1, 2, 16, 17, 18, 19, 4, 5,
			6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
			21, 22, 23, 20
		};

		public static readonly byte[] YN90 = new byte[24]
		{
			1, 2, 3, 0, 8, 9, 10, 11, 12, 13,
			14, 15, 16, 17, 18, 19, 4, 5, 6, 7,
			23, 20, 21, 22
		};

		public static readonly byte[] ZP90 = new byte[24]
		{
			14, 15, 12, 13, 0, 1, 2, 3, 11, 8,
			9, 10, 20, 21, 22, 23, 17, 18, 19, 16,
			6, 7, 4, 5
		};

		public static readonly byte[] ZN90 = new byte[24]
		{
			4, 5, 6, 7, 22, 23, 20, 21, 9, 10,
			11, 8, 2, 3, 0, 1, 19, 16, 17, 18,
			12, 13, 14, 15
		};

		public static readonly byte[] ByX = new byte[24]
		{
			20, 21, 22, 23, 6, 7, 4, 5, 18, 19,
			16, 17, 14, 15, 12, 13, 10, 11, 8, 9,
			0, 1, 2, 3
		};

		public static readonly byte[] ByY = new byte[24]
		{
			2, 3, 0, 1, 12, 13, 14, 15, 16, 17,
			18, 19, 4, 5, 6, 7, 8, 9, 10, 11,
			22, 23, 20, 21
		};

		public static readonly byte[] ByZ = new byte[24]
		{
			22, 23, 20, 21, 14, 15, 12, 13, 10, 11,
			8, 9, 6, 7, 4, 5, 18, 19, 16, 17,
			2, 3, 0, 1
		};

		public static int KeyToIndexHex(int x, int y, int z)
		{
			return z | (y << 4) | (x << 8);
		}

		public static int KeyToIndexHex(VoxelKey key)
		{
			return KeyToIndexHex(key.x, key.y, key.z);
		}

		public static VoxelKey IndexToKeyHex(int index)
		{
			return new VoxelKey((index >> 8) & 0xF, (index >> 4) & 0xF, index & 0xF);
		}

		public static void GlobalKeyToIndex3D(VoxelKey globalKey, out int chunkIndex3d, out int localVoxelIndex3D)
		{
			VoxelKey voxelKey = globalKey / 16f;
			chunkIndex3d = KeyToIndexHex(voxelKey.x, voxelKey.y, voxelKey.z);
			VoxelKey voxelKey2 = globalKey % 16;
			localVoxelIndex3D = KeyToIndexHex(voxelKey2.x, voxelKey2.y, voxelKey2.z);
		}

		internal static VoxelKey Index3DToGlobalKey(int chunkIndex3D, int voxelIndex3D)
		{
			VoxelKey voxelKey = IndexToKeyHex(chunkIndex3D);
			VoxelKey voxelKey2 = IndexToKeyHex(voxelIndex3D);
			return voxelKey * 16 + voxelKey2;
		}

		private static byte Rotor(int ang, int dir)
		{
			return (byte)((dir << 2) | ang);
		}

		private static float abs(float val)
		{
			return Mathf.Abs(val);
		}

		public static byte RotationLogic(VoxelData data, VoxelRaycastHit hit, Vector3 dir, bool baseRotation = false)
		{
			int side = hit.side;
			Vector3 point = hit.Point;
			if (data.TorchRotation)
			{
				return (byte)((uint)(TorchDirections[side] << 2) & 0xFFu);
			}
			if (data.StairRotation)
			{
				byte b = 0;
				point.y -= hit.Free.y;
				if (point.y < 0.5f)
				{
					if (abs(dir.x) > abs(dir.z))
					{
						return Rotor((dir.x < 0f) ? 2 : 0, 0);
					}
					return Rotor((dir.z < 0f) ? 1 : 3, 0);
				}
				if (abs(dir.x) > abs(dir.z))
				{
					return Rotor((dir.x < 0f) ? 2 : 0, 5);
				}
				return Rotor((!(dir.z < 0f)) ? 1 : 3, 5);
			}
			if (baseRotation)
			{
				byte b2 = 0;
				if (abs(dir.x) > abs(dir.z))
				{
					return Rotor((!(dir.x < 0f)) ? 1 : 3, 0);
				}
				return Rotor((dir.z < 0f) ? 2 : 0, 0);
			}
			return 0;
		}
	}
}
