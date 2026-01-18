using CraftyEngine.Content;
using HudSystem;

namespace SelectModeModule
{
	public class SelectModeModuleController : Singleton
	{
		public static void InitModule(int layer)
		{
			SingletonManager.Add<SelectModeModuleController>(layer);
			SingletonManager.Add<SelectModeOnlineController>(layer);
			SingletonManager.Add<SelectModeController>(layer);
		}

		public override void OnDataLoaded()
		{
			ContentDeserializer.Deserialize<SelectGameModeMap>();
			GuiModuleHolder.Add<SelectModeWindow>();
			GuiModuleHolder.Add<SelectMapWindow>();
		}
	}
}
