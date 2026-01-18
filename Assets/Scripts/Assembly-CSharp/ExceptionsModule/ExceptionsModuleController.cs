namespace ExceptionsModule
{
	public class ExceptionsModuleController
	{
		public static void InitModule(int layer)
		{
			SingletonManager.Add<ExceptionsManager>(layer);
			SingletonManager.Add<BasicExceptionsHandler>(layer);
			SingletonManager.Add<ExceptionsStatistics>(layer);
		}
	}
}
