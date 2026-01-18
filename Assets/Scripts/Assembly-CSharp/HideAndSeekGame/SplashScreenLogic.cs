using CraftyEngine.Infrastructure;
using SplashesModule;

namespace HideAndSeekGame
{
	public class SplashScreenLogic : PermanentSingleton
	{
		public SplashScreenManager manager;

		public override void Init()
		{
			PrefabsManager singlton;
			SingletonManager.Get<PrefabsManager>(out singlton);
			singlton.Load("HideAndSeekScreenPrefabsHolder");
			SingletonManager.Get<SplashScreenManager>(out manager);
		}

		public override void Dispose()
		{
			manager = null;
		}

		public void ShowSplashScreen()
		{
			manager.ShowDefaultScreen();
		}

		public void ShowSplashScreen(int splashId)
		{
			manager.ShowScreen(splashId);
		}

		public void ShowSplashScreenByGameType(int pvpModeId)
		{
			manager.ShowScreen(pvpModeId);
		}

		public void HideSplashScreen()
		{
			manager.HideScreen();
		}
	}
}
