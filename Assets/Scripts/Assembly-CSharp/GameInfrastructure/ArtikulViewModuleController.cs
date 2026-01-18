using ArticulViewModule;

namespace GameInfrastructure
{
	public class ArtikulViewModuleController
	{
		public static void Init(int layer)
		{
			SingletonManager.Add<ArtikulItemViewManager>(layer);
		}
	}
}
