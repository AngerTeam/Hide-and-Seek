using CraftyEngine.Infrastructure;
using UnityEngine;

namespace MyPlayerInput
{
	public class MouseCursorManager : Singleton
	{
		private UnityEvent unityEvent_;

		public bool visibleByAltButton;

		public bool visibleByOpenedWindow;

		public bool visibleByGameState;

		public override void Init()
		{
			if (!CompileConstants.MOBILE)
			{
				visibleByAltButton = false;
				visibleByOpenedWindow = false;
				GetSingleton<UnityEvent>(out unityEvent_);
				unityEvent_.Subscribe(UnityEventType.ApplicationQuit, HandleApplicationQuit);
				unityEvent_.Subscribe(UnityEventType.Update, UnityUpdate);
			}
		}

		private void HandleApplicationQuit()
		{
			visibleByAltButton = true;
			visibleByOpenedWindow = true;
		}

		private void UnityUpdate()
		{
			if (visibleByOpenedWindow || visibleByAltButton || visibleByGameState)
			{
				Cursor.lockState = CursorLockMode.None;
				Cursor.visible = true;
			}
			else
			{
				Cursor.lockState = CursorLockMode.Locked;
				Cursor.visible = false;
			}
		}
	}
}
