using AbilitiesModule;

namespace AbilitiesOnlineModule
{
	public class AbilitiesOnlineModuleController
	{
		public static void InitPermaModule(int layer)
		{
			SingletonManager.Add<AbilitiesHolder>(layer);
			SingletonManager.Add<AbilitiesContentDeserializer>(layer);
		}

		public static void InitModule(int layer)
		{
			SingletonManager.Add<PlayerAbilityManager>(layer);
			SingletonManager.Add<AbilitiesOnline>(layer);
			SingletonManager.Add<NetworkAbilitiesManager>(layer);
		}
	}
}
