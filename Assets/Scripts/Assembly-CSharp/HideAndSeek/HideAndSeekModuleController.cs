namespace HideAndSeek
{
	public class HideAndSeekModuleController
	{
		public static void InitPrime(int layer)
		{
			SingletonManager.AddAlias<SocketsHideAndSeekShopOnline, IHideAndSeekShopOnline>(layer);
			SingletonManager.Add<NetworkHideAndSeekManager>(layer);
			SingletonManager.Add<SocketsHideAndSeekOnline>(layer);
			SingletonManager.Add<HideAndSeekMyPlayerController>(layer);
			SingletonManager.Add<HideAndSeekMyPlayerView>(layer);
			SingletonManager.Add<HideAndSeekNetworkCombatController>(layer);
			SingletonManager.Add<HideAndSeekBeltHudController>(layer);
			SingletonManager.Add<HideAndSeekVoxelsController>(layer);
			SingletonManager.Add<HideAndSeekExceptionsManager>(layer);
		}

		public static void InitLobby(int layer)
		{
			SingletonManager.AddAlias<HttpHideAndSeekShopOnline, IHideAndSeekShopOnline>(layer);
			SingletonManager.Add<NetworkHideAndSeekManager>(layer);
			SingletonManager.Add<HideAndSeekLobbyInventoryController>(layer);
		}

		public static void InitModule(int layer)
		{
			SingletonManager.Add<HideAndSeekController>(layer);
			SingletonManager.Add<HideAndSeekModel>(layer);
		}
	}
}
