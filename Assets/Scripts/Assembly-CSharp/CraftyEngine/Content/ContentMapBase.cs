using System;
using System.Collections.Generic;
using CraftyEngine.Utils;
using Interlace.Amf;

namespace CraftyEngine.Content
{
	public class ContentMapBase
	{
		private IDictionary<string, object> associativeElements_;

		public void SetValues(IDictionary<string, object> associativeElements)
		{
			associativeElements_ = associativeElements;
			Deserialize();
		}

		public virtual void Deserialize()
		{
		}

		protected T FillSettings<T>(string key) where T : ContentItem, new()
		{
			T result = new T();
			object value;
			if (associativeElements_.TryGetValue(key, out value))
			{
				AmfArray amfArray = (AmfArray)value;
				result.SetValues(amfArray.AssociativeElements);
			}
			else
			{
				Log.ContentError("Unable to find {0} in {1}", key, ArrayUtils.ArrayToString(associativeElements_.Keys));
			}
			return result;
		}

		protected Dictionary<string, T> ReadString<T>(string key) where T : ContentItem, new()
		{
			try
			{
				Dictionary<string, T> dictionary = new Dictionary<string, T>();
				foreach (T item in Read<T>(key))
				{
					dictionary.Add(item.stringKey, (T)item);
				}
				return dictionary;
			}
			catch (Exception ex)
			{
				Log.Warning("ContentMapBase: Unable to read {0}\n {1}", key, ex);
				return null;
			}
		}

		protected Dictionary<int, T> ReadInt<T>(string key) where T : ContentItem, new()
		{
			try
			{
				Dictionary<int, T> dictionary = new Dictionary<int, T>();
				foreach (T item in Read<T>(key))
				{
					dictionary.Add(item.intKey, (T)item);
				}
				return dictionary;
			}
			catch (Exception ex)
			{
				Log.Warning("ContentMapBase: Unable to read " + key, ex);
				return null;
			}
		}

		protected List<ValueType> Read<ValueType>(string key) where ValueType : ContentItem, new()
		{
			List<ValueType> list = new List<ValueType>();
			AmfArray amfArray = (AmfArray)associativeElements_[key];
			foreach (object denseElement in amfArray.DenseElements)
			{
				AmfArray amfArray2 = (AmfArray)denseElement;
				ValueType item = new ValueType();
				item.SetValues(amfArray2.AssociativeElements);
				list.Add(item);
			}
			return list;
		}
	}
}
