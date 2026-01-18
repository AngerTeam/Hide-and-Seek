using System;

public class ByteUtils
{
	private const int SIZE = 4;

	private static byte[] header_ = new byte[4];

	public static int ReadLength(byte[] data, int from = 0)
	{
		Array.Copy(data, from, header_, 0, 4);
		return (header_[0] << 24) | (header_[1] << 16) | (header_[2] << 8) | header_[3];
	}

	public static byte[] AddLength(byte[] bytes)
	{
		byte[] array = new byte[bytes.Length + header_.Length];
		header_ = BitConverter.GetBytes(bytes.Length);
		Array.Reverse(header_);
		Array.Copy(header_, 0, array, 0, 4);
		Array.Copy(bytes, 0, array, 4, bytes.Length);
		return array;
	}

	public static byte[] GetLength(byte[] bytes)
	{
		byte[] bytes2 = BitConverter.GetBytes(bytes.Length);
		Array.Reverse(bytes2);
		return bytes2;
	}

	public static byte[] GetMessage(byte[] buffer, int from, int length)
	{
		if (length > buffer.Length)
		{
			throw new ArgumentOutOfRangeException("length");
		}
		byte[] array = new byte[length];
		Array.Copy(buffer, from, array, 0, length);
		return array;
	}
}
