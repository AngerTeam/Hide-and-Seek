using UnityEngine;

namespace CraftyVoxelEngine
{
	public class BoxSide
	{
		public const int PX = 0;

		public const int NX = 1;

		public const int PY = 2;

		public const int NY = 3;

		public const int PZ = 4;

		public const int NZ = 5;

		public static readonly byte[] sides = new byte[6] { 0, 1, 2, 3, 4, 5 };

		public static readonly byte[] mirror = new byte[6] { 1, 0, 3, 2, 5, 4 };

		public static int GetSideByNormal(Vector3 normal)
		{
			if (normal.x > 0f)
			{
				return 0;
			}
			if (normal.x < 0f)
			{
				return 1;
			}
			if (normal.y > 0f)
			{
				return 2;
			}
			if (normal.y < 0f)
			{
				return 3;
			}
			if (normal.z > 0f)
			{
				return 4;
			}
			if (normal.z < 0f)
			{
				return 5;
			}
			return -1;
		}

		public static Vector3 GetNormalBySide(int side)
		{
			switch (side)
			{
			case 0:
				return Vector3.right;
			case 1:
				return Vector3.left;
			case 2:
				return Vector3.up;
			case 3:
				return Vector3.down;
			case 4:
				return Vector3.forward;
			case 5:
				return Vector3.back;
			default:
				return Vector3.up;
			}
		}
	}
}
