using System;
using System.Collections.Generic;
using System.IO;

namespace Interlace.Amf
{
	public class AmfReaderWithMap : AmfReader
	{
		private const string Key = "<voxels/>";

		private static int KeyLength = "<voxels/>".Length;

		private static Dictionary<int, byte[]> map;

		public AmfReaderWithMap(BinaryReader reader, AmfRegistry registry)
			: base(reader, registry)
		{
			if (map == null)
			{
				map = new Dictionary<int, byte[]>();
			}
		}

		protected override void CheckString(string value, byte[] rawData)
		{
			if (value.StartsWith("<voxels/>"))
			{
				byte[] array = new byte[rawData.Length - KeyLength];
				Array.Copy(rawData, KeyLength, array, 0, array.Length);
				map[value.GetHashCode()] = array;
			}
		}

		public static void Clear()
		{
			map.Clear();
		}

		public static byte[] GetData(string key)
		{
			byte[] value = null;
			map.TryGetValue(key.GetHashCode(), out value);
			return value;
		}
	}
}
