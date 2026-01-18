using System.Runtime.InteropServices;

namespace CraftyEngine
{
	[StructLayout(LayoutKind.Explicit)]
	public struct MemoryMap
	{
		[FieldOffset(0)]
		public double doubleValue;

		[FieldOffset(0)]
		public long longValue;

		[FieldOffset(0)]
		public ulong uLongValue;

		[FieldOffset(0)]
		public float floatValue;

		[FieldOffset(0)]
		public int intValue;

		[FieldOffset(0)]
		public uint uIntValue;

		[FieldOffset(0)]
		public short shortValue;

		[FieldOffset(0)]
		public ushort uShortValue;

		[FieldOffset(0)]
		public byte byteValue0;

		[FieldOffset(1)]
		public byte byteValue1;

		[FieldOffset(2)]
		public byte byteValue2;

		[FieldOffset(3)]
		public byte byteValue3;

		[FieldOffset(4)]
		public byte byteValue4;

		[FieldOffset(5)]
		public byte byteValue5;

		[FieldOffset(6)]
		public byte byteValue6;

		[FieldOffset(7)]
		public byte byteValue7;
	}
}
