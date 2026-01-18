using System.Runtime.InteropServices;

namespace Interlace.Amf.Extended
{
	[StructLayout(LayoutKind.Explicit)]
	public struct ByteDouble
	{
		[FieldOffset(0)]
		public long longValue;

		[FieldOffset(0)]
		public double doubleValue;
	}
}
