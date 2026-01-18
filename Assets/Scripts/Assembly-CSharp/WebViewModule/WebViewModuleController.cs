namespace WebViewModule
{
	public class WebViewModuleController : Singleton
	{
		public static void InitModule(int layer)
		{
			SingletonManager.Add<WebViewHandler>(layer);
		}
	}
}
