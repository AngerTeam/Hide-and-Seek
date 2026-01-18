namespace CraftyVoxelEngine.Clouds
{
	public class BoxSide
	{
		public const byte LeftTopFront = 0;

		public const byte CenterTopFront = 1;

		public const byte RightTopFront = 2;

		public const byte LeftTopCenter = 3;

		public const byte CenterTopCenter = 4;

		public const byte RightTopCenter = 5;

		public const byte LeftTopBack = 6;

		public const byte CenterTopBack = 7;

		public const byte RightTopBack = 8;

		public const byte LeftMiddleFront = 9;

		public const byte CenterMiddleFront = 10;

		public const byte RightMiddleFront = 11;

		public const byte LeftMiddleCenter = 12;

		public const byte CenterMiddleCenter = 13;

		public const byte RightMiddleCenter = 14;

		public const byte LeftMiddleBack = 15;

		public const byte CenterMiddleBack = 16;

		public const byte RightMiddleBack = 17;

		public const byte LeftBottomFront = 18;

		public const byte CenterBottomFront = 19;

		public const byte RightBottomFront = 20;

		public const byte LeftBottomCenter = 21;

		public const byte CenterBottomCenter = 22;

		public const byte RightBottomCenter = 23;

		public const byte LeftBottomBack = 24;

		public const byte CenterBottomBack = 25;

		public const byte RightBottomBack = 26;

		public const byte NXPYPZ = 0;

		public const byte MXPYPZ = 1;

		public const byte PXPYPZ = 2;

		public const byte NXPYMZ = 3;

		public const byte MXPYMZ = 4;

		public const byte PXPYMZ = 5;

		public const byte NXPYNZ = 6;

		public const byte MXPYNZ = 7;

		public const byte PXPYNZ = 8;

		public const byte NXMYPZ = 9;

		public const byte MXMYPZ = 10;

		public const byte PXMYPZ = 11;

		public const byte NXMYMZ = 12;

		public const byte MXMYMZ = 13;

		public const byte PXMYMZ = 14;

		public const byte NXMYNZ = 15;

		public const byte MXMYNZ = 16;

		public const byte PXMYNZ = 17;

		public const byte NXNYPZ = 18;

		public const byte MXNYPZ = 19;

		public const byte PXNYPZ = 20;

		public const byte NXNYMZ = 21;

		public const byte MXNYMZ = 22;

		public const byte PXNYMZ = 23;

		public const byte NXNYNZ = 24;

		public const byte MXNYNZ = 25;

		public const byte PXNYNZ = 26;

		public const byte PX = 0;

		public const byte NX = 1;

		public const byte PY = 2;

		public const byte NY = 3;

		public const byte PZ = 4;

		public const byte NZ = 5;

		public const byte SELF = 6;

		public const byte RIGHT = 0;

		public const byte LEFT = 1;

		public const byte TOP = 2;

		public const byte BOTTOM = 3;

		public const byte FRONT = 4;

		public const byte BACK = 5;

		public static readonly byte[] Neighbours = new byte[27]
		{
			0, 1, 2, 3, 4, 5, 6, 7, 8, 9,
			10, 11, 12, 13, 14, 15, 16, 17, 18, 19,
			20, 21, 22, 23, 24, 25, 26
		};

		public static readonly byte[] sides = new byte[6] { 0, 1, 2, 3, 4, 5 };

		public static readonly byte[] mirror = new byte[6] { 1, 0, 3, 2, 5, 4 };

		public static VoxelKey GetDirection(byte dir)
		{
			VoxelKey result = default(VoxelKey);
			switch (dir)
			{
			case 0:
				result.x++;
				break;
			case 1:
				result.x--;
				break;
			case 2:
				result.y++;
				break;
			case 3:
				result.y--;
				break;
			case 4:
				result.z++;
				break;
			case 5:
				result.z--;
				break;
			}
			return result;
		}

		public static string ToString(int side, bool full = false)
		{
			switch (side)
			{
			case 0:
				return (!full) ? "PX" : "Positive X";
			case 1:
				return (!full) ? "NX" : "Negative X";
			case 2:
				return (!full) ? "PY" : "Positive Y";
			case 3:
				return (!full) ? "NY" : "Negative Y";
			case 4:
				return (!full) ? "PZ" : "Positive Z";
			case 5:
				return (!full) ? "NZ" : "Negative Z";
			default:
				return "Unknown";
			}
		}
	}
}
