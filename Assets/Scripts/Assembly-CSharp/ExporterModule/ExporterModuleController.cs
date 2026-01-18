using HudSystem;

namespace ExporterModule
{
	public class ExporterModuleController : Singleton
	{
		public static void InitModule(int layer)
		{
			SingletonManager.Add<ExporterModuleController>(layer);
		}

		public override void OnDataLoaded()
		{
			GuiModuleHolder.Add<ExporterWindow>();
		}
	}
}
