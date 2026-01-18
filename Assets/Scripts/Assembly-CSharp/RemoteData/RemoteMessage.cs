using System;
using System.Collections.Generic;
using CraftyEngine;
using CraftyEngine.Utils;
using Interlace.Amf;

namespace RemoteData
{
	public class RemoteMessage
	{
		public static bool TryRead<T>(AmfObject source, out T message) where T : RemoteMessage, new()
		{
			try
			{
				message = Read<T>(source);
				return true;
			}
			catch (Exception exc)
			{
				Log.Error("Failed to read {0} from {1}", typeof(T), AmfHelper.AmfToString(source));
				Log.Exception(exc);
				message = (T)null;
				return false;
			}
		}

		public static T Read<T>(AmfObject source) where T : RemoteMessage, new()
		{
			T result = new T();
			result.Deserialize(source, false);
			return result;
		}

		public virtual AmfObject Serialize()
		{
			return null;
		}

		public virtual void Deserialize(AmfObject source, bool silent)
		{
		}

		protected T Get<T>(AmfObject source, string key, bool silent)
		{
			try
			{
				if (typeof(double).IsAssignableFrom(typeof(T)))
				{
					return (T)(object)Convert.ToDouble(source.Properties[key]);
				}
				return (T)source.Properties[key];
			}
			catch
			{
				if (!silent)
				{
					Log.Warning("unable to find {0} in\n{1}", key, ArrayUtils.DictionaryToString(source.Properties));
				}
				return default(T);
			}
		}

		protected T GetMessage<T>(AmfObject amfObject, string key, bool silent = false) where T : RemoteMessage, new()
		{
			try
			{
				T result = new T();
				AmfObject source = (AmfObject)amfObject.Properties[key];
				result.Deserialize(source, true);
				return result;
			}
			catch
			{
				if (!silent)
				{
					Log.Warning("unable to find {2} {0} in\n{1}", key, ArrayUtils.DictionaryToString(amfObject.Properties), typeof(T).Name);
				}
				return (T)null;
			}
		}

		protected Dictionary<string, T> GetDictionary<T>(AmfObject amfObject, string key) where T : RemoteMessage, new()
		{
			try
			{
				Dictionary<string, T> dictionary = new Dictionary<string, T>();
				foreach (KeyValuePair<string, object> property in amfObject.Properties)
				{
					T value = new T();
					AmfObject source = (AmfObject)property.Value;
					value.Deserialize(source, true);
					dictionary[property.Key] = value;
				}
				return dictionary;
			}
			catch
			{
				Log.Warning("unable to find {2} {0} in\n{1}", key, ArrayUtils.DictionaryToString(amfObject.Properties), typeof(T).Name);
				return null;
			}
		}

		protected T[] GetArray<T>(AmfObject amfObject, string key, bool silent = false) where T : RemoteMessage, new()
		{
			try
			{
				AmfArray amfArray = (AmfArray)amfObject.Properties[key];
				T[] array = new T[amfArray.DenseElements.Count];
				for (int i = 0; i < amfArray.DenseElements.Count; i++)
				{
					T val = new T();
					AmfObject source = (AmfObject)amfArray.DenseElements[i];
					val.Deserialize(source, true);
					array[i] = val;
				}
				return array;
			}
			catch (Exception)
			{
				if (!silent)
				{
					Log.Warning("unable to find {0} in\n{1}", key, ArrayUtils.DictionaryToString(amfObject.Properties));
				}
				return null;
			}
		}
	}
}
