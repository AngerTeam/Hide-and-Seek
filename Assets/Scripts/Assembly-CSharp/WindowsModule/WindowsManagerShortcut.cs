namespace WindowsModule
{
	public class WindowsManagerShortcut
	{
		public static WindowsManager instance;

		public static void ToggleWindow<T>() where T : class
		{
			instance.ToggleWindow<T>();
		}

		public static void ToggleWindow(GameWindow window)
		{
			instance.ToggleWindow(window);
		}
	}
}
