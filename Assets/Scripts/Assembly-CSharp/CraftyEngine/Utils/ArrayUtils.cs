using System;
using System.Collections;
using System.Collections.Generic;

namespace CraftyEngine.Utils
{
	public class ArrayUtils
	{
		public static int IndexOf<T>(T[] array, T item) where T : class
		{
			int i = 0;
			for (int num = array.Length; i < num; i++)
			{
				if (EqualityComparer<T>.Default.Equals(array[i], item))
				{
					return i;
				}
			}
			return -1;
		}

		public static void DictionaryToArrays<T1, T2>(IDictionary<T1, T2> dictionary, out T1[] names, out T2[] values)
		{
			names = new T1[dictionary.Keys.Count];
			dictionary.Keys.CopyTo(names, 0);
			values = new T2[dictionary.Values.Count];
			dictionary.Values.CopyTo(values, 0);
		}

		public static T2[] DictionaryValuesToArray<T1, T2>(IDictionary<T1, T2> dictionary)
		{
			T2[] array = new T2[dictionary.Values.Count];
			dictionary.Values.CopyTo(array, 0);
			return array;
		}

		public static T1[] DictionaryKeysToArray<T1, T2>(IDictionary<T1, T2> dictionary)
		{
			T1[] array = new T1[dictionary.Keys.Count];
			dictionary.Keys.CopyTo(array, 0);
			return array;
		}

		public static string DictionaryToURLVariables<T1, T2>(IDictionary<T1, T2> dictionary)
		{
			return DictionaryToString(dictionary, "=", "&");
		}

		public static string DictionaryToString<T1, T2>(IDictionary<T1, T2> dictionary, string valueSymbol = ": ", string enumerationSymbol = ", ")
		{
			return ArrayToString(DictionaryToStrings(dictionary, valueSymbol), enumerationSymbol);
		}

		public static string[] DictionaryToStrings<T1, T2>(IDictionary<T1, T2> dictionary, string symbol = ": ")
		{
			string[] array = new string[dictionary.Count];
			int num = 0;
			foreach (KeyValuePair<T1, T2> item in dictionary)
			{
				array[num] = ((item.Key != null) ? item.Key.ToString() : "null") + symbol + ((item.Value != null) ? item.Value.ToString() : "null");
				num++;
			}
			return array;
		}

		public static string[] ArrayToStrings(IEnumerable list)
		{
			if (list == null)
			{
				return new string[1] { "null" };
			}
			List<string> list2 = new List<string>();
			foreach (object item in list)
			{
				list2.Add((item != null) ? item.ToString() : "null");
			}
			return list2.ToArray();
		}

		public static string ArrayToString(IEnumerable list, string splitSymbol = ", ")
		{
			return string.Join(splitSymbol, ArrayToStrings(list));
		}

		public static Array AddTo(Array array, object obj)
		{
			int length = array.Length;
			Array array2 = Array.CreateInstance(array.GetType().GetElementType(), length + 1);
			if (length != 0)
			{
				Array.Copy(array, array2, length);
			}
			array2.SetValue(obj, length);
			return array2;
		}

		internal static void RemoveWhere<ValueType>(ICollection<ValueType> iEnumerable, Predicate<ValueType> compare)
		{
			List<ValueType> list = new List<ValueType>();
			foreach (ValueType item in iEnumerable)
			{
				if (compare(item))
				{
					list.Add(item);
				}
			}
			foreach (ValueType item2 in list)
			{
				iEnumerable.Remove(item2);
			}
		}
	}
}
