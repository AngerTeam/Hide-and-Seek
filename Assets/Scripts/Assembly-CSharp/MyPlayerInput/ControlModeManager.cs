using CraftyEngine.Infrastructure;

namespace MyPlayerInput
{
	public class ControlModeManager : Singleton
	{
		private MouseCursorManager mouseCursorManager_;

		private UnityEvent unityEvent_;

		public override void Init()
		{
			SingletonManager.Get<MouseCursorManager>(out mouseCursorManager_);
			SingletonManager.Get<UnityEvent>(out unityEvent_);
			unityEvent_.Subscribe(UnityEventType.Update, Update);
		}

		private void Update()
		{
			mouseCursorManager_.visibleByAltButton = PressedKey.Alt;
		}
	}
}
