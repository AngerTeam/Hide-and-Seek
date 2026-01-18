using HudSystem;

namespace RestoreServiceModule
{
	public class RestoreServiceModuleController : Singleton
	{
		public static void InitModule(int layer)
		{
			if (CompileConstants.IOS)
			{
				SingletonManager.Add<RestoreServiceController>(layer);
				SingletonManager.Add<RestoreServiceOnlineController>(layer);
				SingletonManager.Add<RestoreServiceModuleController>(layer);
			}
		}

		public override void OnDataLoaded()
		{
			GuiModuleHolder.Add<RestoreServiceWindow>();
		}
	}
}
