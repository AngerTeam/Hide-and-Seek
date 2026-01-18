public class SingletonManagerLegacy
{
	public static int legacyPermanentLayer;

	public static int defaultLayer;

	public static T Add<T>(bool legacyPermanent) where T : ISingleton, new()
	{
		return SingletonManager.Add<T>((!legacyPermanent) ? defaultLayer : legacyPermanentLayer);
	}

	public static T Add<T>(T singleton, bool legacyPermanent) where T : ISingleton
	{
		return SingletonManager.Add(singleton, (!legacyPermanent) ? defaultLayer : legacyPermanentLayer);
	}

	public static bool TryAddPermanentSingleton<T>() where T : ISingleton, new()
	{
		if (SingletonManager.Contains<T>())
		{
			return false;
		}
		SingletonManager.Add<T>(legacyPermanentLayer);
		return true;
	}
}
