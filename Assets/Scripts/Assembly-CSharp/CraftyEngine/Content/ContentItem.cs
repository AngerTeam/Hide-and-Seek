using System;
using System.Collections.Generic;
using System.Globalization;
using Interlace.Amf;

namespace CraftyEngine.Content
{
	public class ContentItem
	{
		private enum ValueType
		{
			Int = 0,
			Float = 1,
			Stirng = 2
		}

		public int intKey;

		public string stringKey;

		private IDictionary<string, object> associativeElements_;

		public T Clone<T>() where T : ContentItem, new()
		{
			T result = new T();
			result.SetValues(associativeElements_);
			return result;
		}

		public virtual T CloneWithLinks<T>(ContentMapBase map) where T : ContentItem, new()
		{
			T result = Clone<T>();
			result.CreateLinks(map);
			return result;
		}

		public virtual void CreateLinks(ContentMapBase contentMap)
		{
		}

		public virtual void Deserialize()
		{
		}

		public void SetValues(IDictionary<string, object> associativeElements)
		{
			associativeElements_ = associativeElements;
			Deserialize();
		}

		protected T GetLink<T>(Dictionary<string, T> links, string linkId)
		{
			T value;
			if (links.TryGetValue(linkId, out value))
			{
				return value;
			}
			return default(T);
		}

		protected T GetLink<T>(Dictionary<int, T> links, int linkId)
		{
			T value;
			if (links.TryGetValue(linkId, out value))
			{
				return value;
			}
			return default(T);
		}

		protected bool TryGetBool(string key)
		{
			object value;
			if (associativeElements_.TryGetValue(key, out value))
			{
				return (bool)value;
			}
			return false;
		}

		protected Dictionary<TKey, TValue> TryGetDictionary<TKey, TValue>(Dictionary<TKey, TValue> dic, string key)
		{
			ValueType type = GetType<TKey>();
			ValueType type2 = GetType<TValue>();
			ParseDictionary(key, dic, type, type2);
			return dic;
		}

		protected float TryGetFloat(string key, float defaultValue = 0f)
		{
			object value;
			if (associativeElements_.TryGetValue(key, out value))
			{
				return TryConvertSingle(value, defaultValue);
			}
			return defaultValue;
		}

		protected int TryGetInt(string key, int defaultValue = 0)
		{
			object value;
			return (!associativeElements_.TryGetValue(key, out value)) ? defaultValue : TryConvertToInt32(value, defaultValue);
		}

		protected Dictionary<int, TValue> TryGetIntDictionary<TValue>(Dictionary<int, TValue> dic, string key)
		{
			ValueType type = GetType<TValue>();
			ParseDictionary(key, dic, ValueType.Int, type);
			ParseList(key, dic, type);
			return dic;
		}

		protected string TryGetString(string key, string defaultValue = "")
		{
			object value;
			if (associativeElements_.TryGetValue(key, out value))
			{
				return TryConvertToString(value, defaultValue);
			}
			return defaultValue;
		}

		private static float TryConvertSingle(object source, float defaultValue)
		{
			try
			{
				return Convert.ToSingle(source, CultureInfo.InvariantCulture);
			}
			catch
			{
				Log.Error("Unable to convert {0} to float", source);
				return defaultValue;
			}
		}

		private static int TryConvertToInt32(object source, int defautlValue)
		{
			try
			{
				return Convert.ToInt32(source);
			}
			catch
			{
				Log.Error("Unable to convert {0} to int", source);
				return defautlValue;
			}
		}

		private static string TryConvertToString(object source, string defaultValue)
		{
			try
			{
				return Convert.ToString(source);
			}
			catch
			{
				Log.Error("Unable to convert {0} to string", source);
				return defaultValue;
			}
		}

		private ValueType GetType<TSourceType>()
		{
			Type typeFromHandle = typeof(TSourceType);
			if (typeFromHandle.IsAssignableFrom(typeof(int)))
			{
				return ValueType.Int;
			}
			return typeFromHandle.IsAssignableFrom(typeof(float)) ? ValueType.Float : ValueType.Stirng;
		}

		private T GetValue<T>(ValueType valueType, object obj)
		{
			switch (valueType)
			{
			case ValueType.Int:
				return (T)(object)Convert.ToInt32(obj);
			case ValueType.Float:
				return (T)(object)Convert.ToSingle(obj, CultureInfo.InvariantCulture);
			default:
				return (T)(object)Convert.ToString(obj);
			}
		}

		private void ParseDictionary<TKey, TValue>(string dicKey, Dictionary<TKey, TValue> dic, ValueType keyType, ValueType valueType)
		{
			object value;
			if (!associativeElements_.TryGetValue(dicKey, out value))
			{
				return;
			}
			AmfArray amfArray = value as AmfArray;
			if (amfArray == null)
			{
				return;
			}
			foreach (KeyValuePair<string, object> associativeElement in amfArray.AssociativeElements)
			{
				TKey value2 = GetValue<TKey>(keyType, associativeElement.Key);
				if (value2 != null)
				{
					TValue value3 = GetValue<TValue>(valueType, associativeElement.Value);
					dic[value2] = value3;
				}
			}
		}

		private void ParseList<TValue>(string key, Dictionary<int, TValue> dic, ValueType valueType)
		{
			object value;
			if (!associativeElements_.TryGetValue(key, out value))
			{
				return;
			}
			AmfArray amfArray = value as AmfArray;
			if (amfArray == null)
			{
				return;
			}
			for (int i = 0; i < amfArray.DenseElements.Count; i++)
			{
				object obj = amfArray.DenseElements[i];
				if (obj != null)
				{
					dic[i] = GetValue<TValue>(valueType, obj);
				}
			}
		}
	}
}
