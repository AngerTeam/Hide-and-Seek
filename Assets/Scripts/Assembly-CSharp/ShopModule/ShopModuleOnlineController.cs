namespace ShopModule
{
	public class ShopModuleOnlineController
	{
		public static void InitModule(int layer)
		{
			SingletonManager.Add<PlayerSkinsManagerOnline>(layer);
		}
	}
}
