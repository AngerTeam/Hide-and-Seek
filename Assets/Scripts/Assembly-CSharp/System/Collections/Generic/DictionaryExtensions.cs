namespace System.Collections.Generic
{
	public static class DictionaryExtensions
	{
		public static TValue GetOrSet<TKey, TValue>(this Dictionary<TKey, TValue> dictionary, TKey key) where TValue : new()
		{
			if (dictionary.ContainsKey(key))
			{
				return dictionary[key];
			}
			TValue val = new TValue();
			dictionary.Add(key, val);
			return val;
		}

		public static TValue[] FilterValues<TKey, TValue>(this Dictionary<TKey, TValue> dictionary, Predicate<TValue> compare)
		{
			List<TValue> list = new List<TValue>();
			foreach (TValue value in dictionary.Values)
			{
				if (compare(value))
				{
					list.Add(value);
				}
			}
			return list.ToArray();
		}
	}
}
