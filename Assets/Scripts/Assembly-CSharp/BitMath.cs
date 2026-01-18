public class BitMath
{
	private BitMath()
	{
	}

	public static bool GetBit(byte data, int index)
	{
		return ((data >> index) & 1) == 1;
	}

	public static byte SetBit(byte data, int index, bool value = true)
	{
		int num = (byte)(1 << index);
		return (byte)((uint)(data & ~num) | (value ? ((uint)num) : 0u));
	}

	public static byte AddBit(byte data, int index)
	{
		return (byte)(data | (1 << index));
	}

	public static byte RemBit(byte data, int index)
	{
		return (byte)(data & ~(1 << index));
	}

	public static bool GetBit(int data, int index)
	{
		return ((data >> index) & 1) == 1;
	}

	public static int SetBit(int data, int index, bool value = true)
	{
		int num = 1 << index;
		return (data & ~num) | (value ? num : 0);
	}

	public static int AddBit(int data, int index)
	{
		return data | (1 << index);
	}

	public static int RemBit(int data, int index)
	{
		return data & ~(1 << index);
	}
}
