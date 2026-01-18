using System;
using System.Collections;
using System.Collections.Generic;

namespace CraftyEngine.Utils
{
	public class EnumUtils
	{
		public static bool TryParse<T>(string source, out T result)
		{
			return TryParse(source, out result, default(T));
		}

		public static bool TryParse<T>(string source, out T result, T defaultValue)
		{
			try
			{
				result = (T)Enum.Parse(typeof(T), source);
				return true;
			}
			catch
			{
				result = defaultValue;
				return false;
			}
		}

		public static int WhatPowerOfTwo(int value)
		{
			return (int)(System.Math.Log(value) / System.Math.Log(2.0));
		}

		public static bool IsPowerOfTwo(object value)
		{
			return IsPowerOfTwo(Convert.ToInt32(value));
		}

		public static bool IsPowerOfTwo(int i)
		{
			return i != 0 && (i & (~i + 1)) == i;
		}

		internal static T Parse<T>(string source)
		{
			return (T)Enum.Parse(typeof(T), source);
		}

		public static bool Contains(object filter, object value)
		{
			return Contains(Convert.ToInt32(filter), Convert.ToInt32(value));
		}

		public static bool Contains(int filter, int value)
		{
			return value == (value & filter);
		}

		public static IEnumerable<T1> GetFlagValuesIn<T1>(T1 filter)
		{
			foreach (T1 value in GetFlagValues<T1>())
			{
				if (Contains(filter, value))
				{
					yield return value;
				}
			}
		}

		public static IEnumerable<T1> GetFlagValues<T1>()
		{
			Array values = Enum.GetValues(typeof(T1));
			IEnumerator enumerator = values.GetEnumerator();
			enumerator.Reset();
			while (enumerator.MoveNext())
			{
				if (IsPowerOfTwo(enumerator.Current))
				{
					yield return (T1)enumerator.Current;
				}
			}
		}
	}
}
