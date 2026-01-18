using CraftyEngine.Infrastructure;
using UnityEngine;

namespace TutorialModule
{
	public class TutorialStateJump : TutorialState
	{
		private KeyboardInputManager inputManager_;

		public TutorialStateJump()
		{
			title = "Prompt_TutorialJump";
			label.itemId = 2;
			label.anchor = TutorialAnchor.Right;
			SingletonManager.Get<KeyboardInputManager>(out inputManager_);
		}

		public override void OnComplete()
		{
			inputManager_.ButtonPressed -= HandleButtonPressed;
		}

		public override void OnStart()
		{
			inputManager_.ButtonPressed += HandleButtonPressed;
		}

		private void HandleButtonPressed(object sender, InputEventArgs e)
		{
			if (e.keyCode == KeyCode.Space)
			{
				Complete();
			}
		}
	}
}
