using System;

public abstract class Singleton : IDisposable, ISingleton
{
	public int Layer { get; set; }

	public virtual void Init()
	{
	}

	protected void GetGlobalSingleton<T>(out T singleton) where T : ISingleton
	{
		SingletonManager.Get<T>(out singleton);
	}

	protected void GetSingleton<T>(out T singleton, int layer) where T : ISingleton
	{
		SingletonManager.Get<T>(out singleton, layer);
	}

	protected void GetSingleton<T>(out T singleton) where T : ISingleton
	{
		SingletonManager.Get<T>(out singleton, Layer);
	}

	public virtual void OnDataLoaded()
	{
	}

	public virtual void OnSyncRecieved()
	{
	}

	public virtual void OnLogicLoaded()
	{
	}

	public virtual void OnReset()
	{
	}

	public virtual void OnThreadStop()
	{
	}

	public virtual void Dispose()
	{
	}
}
