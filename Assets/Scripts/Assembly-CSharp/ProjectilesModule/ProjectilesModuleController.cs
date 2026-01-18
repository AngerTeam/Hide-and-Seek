namespace ProjectilesModule
{
	public class ProjectilesModuleController : Singleton
	{
		public static void InitModule(int layer)
		{
			SingletonManager.Add<ProjectilesModuleContentDeserializer>(layer);
			SingletonManager.Add<ProjectilesModuleController>(layer);
			SingletonManager.Add<ProjectilesManager>(layer);
			SingletonManager.Add<ProjectileInventoryController>(layer);
		}
	}
}
