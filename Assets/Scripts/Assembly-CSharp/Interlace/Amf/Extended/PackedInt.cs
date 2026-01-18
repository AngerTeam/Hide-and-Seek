using System.IO;

namespace Interlace.Amf.Extended
{
	public class PackedInt
	{
		public static int Read(BinaryReader reader)
		{
			int num = 0;
			byte b = reader.ReadByte();
			num = 0x7F & b;
			if ((b & 0x80) == 0)
			{
				return num;
			}
			byte b2 = reader.ReadByte();
			num = (num << 7) | (0x7F & b2);
			if ((b2 & 0x80) == 0)
			{
				return num;
			}
			byte b3 = reader.ReadByte();
			num = (num << 7) | (0x7F & b3);
			if ((b3 & 0x80) == 0)
			{
				return num;
			}
			byte b4 = reader.ReadByte();
			return (num << 8) | b4;
		}

		public static void Write(BinaryWriter writer, int value)
		{
			if (value < 0)
			{
				throw new AmfException("An attempt was made to serialize a negative integer.");
			}
			if (value < 128)
			{
				writer.Write((byte)value);
				return;
			}
			if (value < 16384)
			{
				writer.Write((byte)(0x80u | ((uint)(value >> 7) & 0x7Fu)));
				writer.Write((byte)((uint)value & 0x7Fu));
				return;
			}
			if (value < 2097152)
			{
				writer.Write((byte)(0x80u | ((uint)(value >> 14) & 0x7Fu)));
				writer.Write((byte)(0x80u | ((uint)(value >> 7) & 0x7Fu)));
				writer.Write((byte)((uint)value & 0x7Fu));
				return;
			}
			if (value < 1073741824)
			{
				writer.Write((byte)(0x80u | ((uint)(value >> 22) & 0x7Fu)));
				writer.Write((byte)(0x80u | ((uint)(value >> 15) & 0x7Fu)));
				writer.Write((byte)(0x80u | ((uint)(value >> 8) & 0x7Fu)));
				writer.Write((byte)((uint)value & 0xFFu));
				return;
			}
			throw new AmfException("An integer too large to serialize was serialized.");
		}
	}
}
