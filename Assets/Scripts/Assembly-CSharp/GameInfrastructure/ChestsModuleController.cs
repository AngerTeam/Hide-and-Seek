using ChestsOnlineModule;
using ChestsViewModule;
using DailyBonusModule;

namespace GameInfrastructure
{
	public class ChestsModuleController : Singleton
	{
		public static void InitPermanent(int layer)
		{
			SingletonManager.Add<ChestsPermanent>(layer);
			SingletonManager.Add<ChestsContentDeserializer>(layer);
		}

		public static void InitCurrent(int layer)
		{
			SingletonManager.AddAlias<ChestsManager, ChestsManagerBase>(layer);
			SingletonManager.Add<ChestsManagerOnline>(layer);
			SingletonManager.Add<ChestsOnlineController>(layer);
			SingletonManager.Add<ChestsModuleController>(layer);
			SingletonManager.Add<DailyBonusController>(layer);
		}
	}
}
