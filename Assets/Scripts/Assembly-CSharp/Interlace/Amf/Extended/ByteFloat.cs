using System.Runtime.InteropServices;

namespace Interlace.Amf.Extended
{
	[StructLayout(LayoutKind.Explicit)]
	public struct ByteFloat
	{
		[FieldOffset(0)]
		public int intValue;

		[FieldOffset(0)]
		public float floatValue;
	}
}
