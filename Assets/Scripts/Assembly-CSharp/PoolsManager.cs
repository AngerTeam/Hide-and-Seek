using System.Collections.Generic;
using System.Threading;

public class PoolsManager : Singleton
{
	public List<ObjectPool> pools;

	public Dictionary<string, ObjectPool> poolsByName;

	public override void Init()
	{
		pools = new List<ObjectPool>();
		poolsByName = new Dictionary<string, ObjectPool>();
	}

	public ObjectPool<T> AddPool<T>() where T : new()
	{
		ObjectPool<T> objectPool = new ObjectPool<T>();
		pools.Add(objectPool);
		return objectPool;
	}

	public override void Dispose()
	{
		ClearAll();
	}

	public void ClearAll()
	{
		for (int i = 0; i < pools.Count; i++)
		{
			ObjectPool objectPool = pools[i];
			if (objectPool.collection != null)
			{
				try
				{
					Monitor.Enter(objectPool.collection);
					pools[i].Dispose();
				}
				finally
				{
					Monitor.Exit(objectPool.collection);
				}
			}
		}
		poolsByName.Clear();
		pools.Clear();
	}

	public ObjectPool<T> GetPool<T>(string name, int prebake = 0) where T : new()
	{
		ObjectPool value;
		if (!poolsByName.TryGetValue(name, out value))
		{
			ObjectPool<T> objectPool = AddPool<T>();
			poolsByName[name] = objectPool;
			if (prebake > 0)
			{
				for (int i = 0; i < prebake; i++)
				{
					T obj = objectPool.Get();
					objectPool.Release(obj);
				}
			}
			value = objectPool;
		}
		return (ObjectPool<T>)value;
	}
}
