using AdsModule;

namespace GameInfrastructure
{
	public class AdsModuleController : Singleton
	{
		public static void InitModule(int layer)
		{
			SingletonManager.Add<AdsContentDeserializer>(layer);
			SingletonManager.Add<AdsManager>(layer);
			SingletonManager.Add<AppodealManager>(layer);
		}
	}
}
