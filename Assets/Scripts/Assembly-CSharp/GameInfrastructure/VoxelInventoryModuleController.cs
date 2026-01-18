using VoxelInventoryModule;

namespace GameInfrastructure
{
	public class VoxelInventoryModuleController
	{
		public static void InitModule(int layer)
		{
			SingletonManager.Add<VoxelInventoryBroadcaster>(layer);
		}
	}
}
