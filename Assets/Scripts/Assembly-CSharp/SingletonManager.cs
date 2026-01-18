using System;
using CraftyEngine.Infrastructure.SingletonManagerCore;
using Extensions;

public class SingletonManager
{
	public static bool debug;

	private static Singletons[] singletonsMap_;

	private static int defaultLayer_;

	public static event Action<SingletonPhase, int> PhaseCompleted;

	public static event Action<SingletonPhase, int> PhaseStarted;

	public static Singletons GetSingletons(int layer)
	{
		return singletonsMap_[layer];
	}

	public static ISingleton Add(Type type, ISingleton singleton, int layer)
	{
		Singletons singletons = singletonsMap_[layer];
		return singletons.Add(type, singleton);
	}

	public static T Add<T>() where T : Singleton, new()
	{
		return Add<T>(defaultLayer_);
	}

	public static T Add<T>(int layer) where T : ISingleton, new()
	{
		try
		{
			return (T)Add(typeof(T), new T(), layer);
		}
		catch (Exception context)
		{
			Exc.Report(3003, context, "Unable to add singleton " + typeof(T));
			return default(T);
		}
	}

	public static T Add<T>(T singleton) where T : ISingleton
	{
		return Add(singleton, defaultLayer_);
	}

	public static T Add<T>(T singleton, int layer) where T : ISingleton
	{
		return (T)Add(typeof(T), singleton, layer);
	}

	public static TName AddAlias<TName, TAlias>(int layer) where TName : TAlias, new() where TAlias : ISingleton
	{
		TName singleton;
		if (TryGet<TName>(out singleton, layer))
		{
			return singleton;
		}
		singleton = new TName();
		Add(singleton, layer);
		Add((TAlias)(object)singleton, layer);
		return singleton;
	}

	public static bool Contains<T>() where T : ISingleton
	{
		Type typeFromHandle = typeof(T);
		for (int i = 0; i < singletonsMap_.Length; i++)
		{
			if (singletonsMap_[i].ContainsKey(typeFromHandle))
			{
				return true;
			}
		}
		return false;
	}

	public static bool Contains<T>(int layer) where T : ISingleton
	{
		Type typeFromHandle = typeof(T);
		if (singletonsMap_[layer].ContainsKey(typeFromHandle))
		{
			return true;
		}
		return false;
	}

	public static void Dispose()
	{
		SingletonManager.PhaseStarted = null;
		SingletonManager.PhaseCompleted = null;
		if (singletonsMap_ != null)
		{
			for (int i = 0; i < singletonsMap_.Length; i++)
			{
				Singletons singletons = singletonsMap_[i];
				singletons.Clear();
			}
		}
		singletonsMap_ = null;
	}

	public static void ClearLayer(int layer)
	{
		for (int i = 0; i < singletonsMap_.Length; i++)
		{
			Singletons singletons = singletonsMap_[i];
			if (singletons.Layer == layer)
			{
				singletons.Clear();
			}
		}
	}

	public static void Get<T>(out T singlton, int layer) where T : ISingleton
	{
		singlton = Get<T>(layer);
	}

	public static void Get<T>(out T singlton) where T : ISingleton
	{
		singlton = Get<T>();
	}

	public static T Get<T>(int layer) where T : ISingleton
	{
		T singleton;
		if (TryGet<T>(out singleton, layer))
		{
			return singleton;
		}
		string text = string.Format("Singleton {0} is not defined in layer {1}!", typeof(T), layer);
		Exc.Report(3003, text);
		throw new NullReferenceException(text);
	}

	public static T Get<T>() where T : ISingleton
	{
		T singleton;
		if (TryGet<T>(out singleton))
		{
			return singleton;
		}
		string text = string.Format("Singleton {0} is not defined!", typeof(T));
		Exc.Report(3003, text);
		throw new NullReferenceException(text);
	}

	public static void Init(int layerCount, int defaultLayer = 0)
	{
		singletonsMap_ = new Singletons[layerCount];
		for (int i = 0; i < singletonsMap_.Length; i++)
		{
			singletonsMap_[i] = new Singletons(i, "Layer_" + i);
		}
		defaultLayer_ = defaultLayer;
	}

	public static void InitiatePhase(SingletonPhase phase, int layer)
	{
		try
		{
			SingletonManager.PhaseStarted.SafeInvoke(phase, layer);
		}
		catch (Exception context)
		{
			Exc.Report(3003, context);
		}
		SingletonPass.Perfom(phase, singletonsMap_[layer], debug);
		try
		{
			SingletonManager.PhaseCompleted.SafeInvoke(phase, layer);
		}
		catch (Exception context2)
		{
			Exc.Report(3003, context2);
		}
	}

	public static void InitiatePhase(SingletonPhase phase)
	{
		for (int i = 0; i < singletonsMap_.Length; i++)
		{
			InitiatePhase(phase, i);
		}
	}

	public static bool TryGet<T>(out T singleton, int layer) where T : ISingleton
	{
		if (layer < singletonsMap_.Length)
		{
			Singletons singletons = singletonsMap_[layer];
			if (singletons != null && singletons.TryGet<T>(out singleton))
			{
				return true;
			}
		}
		singleton = default(T);
		return false;
	}

	public static bool TryGet<T>(out T singleton) where T : ISingleton
	{
		for (int i = 0; i < singletonsMap_.Length; i++)
		{
			Singletons singletons = singletonsMap_[i];
			if (singletons.TryGet<T>(out singleton))
			{
				return true;
			}
		}
		singleton = default(T);
		return false;
	}

	public static void ClearEvents()
	{
		SingletonManager.PhaseCompleted = null;
		SingletonManager.PhaseStarted = null;
	}
}
