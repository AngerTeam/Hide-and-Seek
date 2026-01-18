using System;
using Extensions;
using UnityEngine;

namespace CraftyEngine.Infrastructure
{
	public class UnityTouchScreenKeyboardTracker : Singleton
	{
		private bool visible_;

		public event Action<bool> ChangeVisibility;

		public override void Init()
		{
			SingletonManager.Get<UnityEvent>().Subscribe(UnityEventType.Update, CheckKeyboardVisibility);
		}

		public override void Dispose()
		{
			this.ChangeVisibility = null;
		}

		private void CheckKeyboardVisibility()
		{
			if (visible_ != TouchScreenKeyboard.visible)
			{
				visible_ = TouchScreenKeyboard.visible;
				this.ChangeVisibility.SafeInvoke(visible_);
				Log.Info("===== Keyboard Status: {0}", visible_);
			}
		}
	}
}
