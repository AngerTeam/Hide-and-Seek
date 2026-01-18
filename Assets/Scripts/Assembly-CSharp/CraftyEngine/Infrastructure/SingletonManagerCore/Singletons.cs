using System;
using System.Collections.Generic;

namespace CraftyEngine.Infrastructure.SingletonManagerCore
{
	public class Singletons
	{
		public Dictionary<Type, ISingleton> singletonsByType;

		public List<SingletonMetaData> uniqueSingletons;

		public string debugName;

		public int Layer { get; private set; }

		public Singletons(int layer, string debugName)
		{
			Layer = layer;
			this.debugName = debugName;
			singletonsByType = new Dictionary<Type, ISingleton>();
			uniqueSingletons = new List<SingletonMetaData>();
		}

		internal bool ContainsKey<T>() where T : ISingleton
		{
			return ContainsKey(typeof(T));
		}

		internal bool ContainsKey(Type type)
		{
			return singletonsByType.ContainsKey(type);
		}

		internal bool TryGet<T>(out T singleton) where T : ISingleton
		{
			if (singletonsByType == null)
			{
				singleton = default(T);
				return false;
			}
			if (ContainsKey<T>())
			{
				singleton = Get<T>();
				return true;
			}
			singleton = default(T);
			return false;
		}

		public T Get<T>() where T : ISingleton
		{
			Type typeFromHandle = typeof(T);
			ISingleton value;
			if (singletonsByType.TryGetValue(typeFromHandle, out value))
			{
				return (T)value;
			}
			Log.Error("Singleton {0} is not defined!", typeFromHandle.Name);
			return default(T);
		}

		public void Get<T>(out T singlton) where T : Singleton
		{
			singlton = Get<T>();
		}

		internal ISingleton Add(Type t, ISingleton singleton)
		{
			singleton.Layer = Layer;
			if (singletonsByType.ContainsKey(t))
			{
				Log.Error("Singleton {0} already defined in layer {1}!", t.Name, Layer);
				return singleton;
			}
			singletonsByType[t] = singleton;
			SingletonMetaData singletonMetaData = new SingletonMetaData(singleton);
			if (!uniqueSingletons.Contains(singletonMetaData))
			{
				uniqueSingletons.Add(singletonMetaData);
				singletonMetaData.Init();
			}
			return singleton;
		}

		internal void Reset()
		{
			foreach (SingletonMetaData uniqueSingleton in uniqueSingletons)
			{
				if (uniqueSingleton.holder != null)
				{
					try
					{
						uniqueSingleton.holder.OnReset();
					}
					catch (Exception exc)
					{
						Log.Error("Error while Reset Singleton " + uniqueSingleton.debugName);
						Log.Exception(exc);
					}
				}
			}
		}

		internal void Clear()
		{
			foreach (SingletonMetaData uniqueSingleton in uniqueSingletons)
			{
				if (uniqueSingleton.holder != null)
				{
					try
					{
						uniqueSingleton.holder.Dispose();
					}
					catch (Exception exc)
					{
						Log.Error("Error while Dispose Singleton " + uniqueSingleton.debugName);
						Log.Exception(exc);
					}
				}
			}
			uniqueSingletons.Clear();
			singletonsByType.Clear();
		}

		public void Remove<T>(T iSingleton) where T : ISingleton
		{
			Singleton singleton = iSingleton as Singleton;
			SingletonMetaData item = new SingletonMetaData(singleton);
			if (uniqueSingletons.Contains(item))
			{
				uniqueSingletons.Remove(item);
			}
			List<Type> list = new List<Type>();
			foreach (KeyValuePair<Type, ISingleton> item2 in singletonsByType)
			{
				if (item2.Value == singleton)
				{
					list.Add(item2.Key);
				}
			}
			foreach (Type item3 in list)
			{
				singletonsByType.Remove(item3);
			}
			singleton.Dispose();
		}
	}
}
