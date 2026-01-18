namespace CraftyEngine.Infrastructure
{
	public class UnityEventType2Int
	{
		public static int Update = 1;

		public static int FixedUpdate = 2;

		public static int LateUpdate = 3;

		public static int ApplicationQuit = 4;

		public static int ApplicationFocus = 5;

		public static int ApplicationPause = 6;

		public static int Enum2Int(UnityEventType value)
		{
			switch (value)
			{
			case UnityEventType.Update:
				return Update;
			case UnityEventType.LateUpdate:
				return LateUpdate;
			case UnityEventType.FixedUpdate:
				return FixedUpdate;
			case UnityEventType.ApplicationFocus:
				return ApplicationFocus;
			case UnityEventType.ApplicationPause:
				return ApplicationPause;
			case UnityEventType.ApplicationQuit:
				return ApplicationQuit;
			default:
				return Update;
			}
		}
	}
}
