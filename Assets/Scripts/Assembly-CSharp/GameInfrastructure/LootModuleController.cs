using InventoryModule;

namespace GameInfrastructure
{
	public class LootModuleController
	{
		public static void Init(bool solo)
		{
			int layer = 2;
			SingletonManager.Add<LootManager>(layer);
			if (solo)
			{
				SingletonManager.Add<LootSoloController>(layer);
			}
		}
	}
}
