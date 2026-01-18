using PvpModule.Code;

namespace GameInfrastructure
{
	public class PVPModuleController
	{
		public static void InitModule()
		{
			int layer = 1;
			SingletonManager.Add<PvpModuleContentDeserializer>(layer);
		}
	}
}
