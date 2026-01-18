namespace HideAndSeekGame
{
	public class SplashScreenAsynOpener : Singleton
	{
		public override void Init()
		{
			SingletonManager.Get<SplashScreenLogic>().ShowSplashScreen();
		}
	}
}
