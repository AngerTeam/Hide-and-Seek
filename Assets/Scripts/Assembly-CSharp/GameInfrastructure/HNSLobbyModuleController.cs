using HomeLobby;

namespace GameInfrastructure
{
	public class HNSLobbyModuleController
	{
		public static void InitModule(int layer)
		{
			SingletonManager.Add<HomeLobbyController>(layer);
		}

		public static void Load(string mapFilePath)
		{
			HomeLobbyController singlton;
			SingletonManager.Get<HomeLobbyController>(out singlton);
			singlton.Start(mapFilePath);
		}
	}
}
