namespace CraftyEngine
{
	public class MemoryMapper
	{
		public static MemoryMap map;

		static MemoryMapper()
		{
			map.longValue = 0L;
		}

		public static long DoubleToInt64Bits(double value)
		{
			map.doubleValue = value;
			return map.longValue;
		}

		public static double Int64BitsToDouble(long value)
		{
			map.longValue = value;
			return map.doubleValue;
		}

		public static int FloatToInt32Bits(float value)
		{
			map.floatValue = value;
			return map.intValue;
		}

		public static float Int32BitsToFloat(int value)
		{
			map.intValue = value;
			return map.floatValue;
		}
	}
}
