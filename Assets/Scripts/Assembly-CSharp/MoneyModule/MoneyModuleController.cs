using HudSystem;

namespace MoneyModule
{
	public class MoneyModuleController : Singleton
	{
		public static void InitModule()
		{
			SingletonManager.Add<MoneyModuleContentDeserializer>(1);
			SingletonManager.Add<MoneyModuleController>(1);
		}

		public override void OnDataLoaded()
		{
			GuiModuleHolder.Add<MoneyTypesWindow>();
		}
	}
}
