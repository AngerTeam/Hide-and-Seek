namespace Interlace.Amf.Extended
{
	public class OptConverter
	{
		private static ByteDouble doubleConverter_;

		public static long DoubleToInt64Bits(double value)
		{
			doubleConverter_.doubleValue = value;
			return doubleConverter_.longValue;
		}

		public static double Int64BitsToDouble(long value)
		{
			doubleConverter_.longValue = value;
			return doubleConverter_.doubleValue;
		}
	}
}
