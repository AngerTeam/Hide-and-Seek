using System;
using System.Collections.Generic;

namespace Interlace.Amf.Extended
{
	public class OptAmfVoxelDiffs
	{
		public static readonly char[] Key;

		public static Dictionary<int, byte[]> map_;

		private static int counter;

		static OptAmfVoxelDiffs()
		{
			Key = new char[9] { '<', 'v', 'o', 'x', 'e', 'l', 's', '/', '>' };
			counter = 0;
			map_ = new Dictionary<int, byte[]>();
		}

		public static void Clear()
		{
			map_.Clear();
			counter = 0;
		}

		public static byte[] GetData(string key)
		{
			byte[] value = null;
			map_.TryGetValue(key.GetHashCode(), out value);
			return value;
		}

		private static string getNextId()
		{
			string result = string.Format("<diffs {0}/>", counter);
			counter++;
			return result;
		}

		public static bool CheckString(byte[] rawData, int length, out string value)
		{
			value = null;
			int num = Key.Length;
			if (length < num)
			{
				return false;
			}
			bool flag = true;
			for (int i = 0; i < num; i++)
			{
				if (Key[i] != rawData[i])
				{
					flag = false;
					break;
				}
			}
			if (flag)
			{
				value = getNextId();
				byte[] array = new byte[length - num];
				Array.Copy(rawData, num, array, 0, array.Length);
				map_[value.GetHashCode()] = array;
			}
			return flag;
		}
	}
}
