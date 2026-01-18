using CraftyGameEngine.Gui;
using HudSystem;

namespace ShopModule
{
	public class ShopModuleController : Singleton
	{
		public static void InitModule(int layer)
		{
			SingletonManager.Add<ShopModuleContentDeserializer>(layer);
			SingletonManager.Add<PlayerSkinsManager>(layer);
			SingletonManager.Add<ShopModuleController>(layer);
		}

		public override void OnDataLoaded()
		{
			GuiModuleHolder.AddAlias<ShopWindow, IShop>();
			GuiModuleHolder.Add<ShopHud>();
		}
	}
}
