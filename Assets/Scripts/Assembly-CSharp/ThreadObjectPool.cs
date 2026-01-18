using System.Threading;

public abstract class ThreadObjectPool
{
}
public class ThreadObjectPool<T> : ThreadObjectPool where T : new()
{
	private ObjectPool<T> pool_ = new ObjectPool<T>();

	public T Get()
	{
		T val = default(T);
		try
		{
			Monitor.Enter(pool_.collection);
			while (val == null)
			{
				val = pool_.Get();
			}
			return val;
		}
		finally
		{
			Monitor.Exit(pool_.collection);
		}
	}

	public void Dispose()
	{
		pool_.Dispose();
	}

	public void Release(T data)
	{
		try
		{
			Monitor.Enter(pool_.collection);
			pool_.Release(data);
		}
		finally
		{
			Monitor.Exit(pool_.collection);
		}
	}
}
