using System;
using System.Collections.Generic;

namespace Interlace.Amf.Extended
{
	public class AmfOptimizationPools
	{
		public static ObjectPool<List<object>> ObjectList;

		public static ObjectPool<Dictionary<string, object>> ObjectDictionary;

		public static ObjectPool<Dictionary<string, int>> StringIntDictionary;

		public static ObjectPool<Dictionary<DateTime, int>> DateIntDictionary;

		public static ObjectPool<Dictionary<long, int>> LongIntDictionary;

		static AmfOptimizationPools()
		{
			ObjectList = new ObjectPool<List<object>>();
			ObjectDictionary = new ObjectPool<Dictionary<string, object>>();
			StringIntDictionary = new ObjectPool<Dictionary<string, int>>();
			DateIntDictionary = new ObjectPool<Dictionary<DateTime, int>>();
			LongIntDictionary = new ObjectPool<Dictionary<long, int>>();
		}
	}
}
