using System;
using CraftyEngine.Infrastructure;

namespace PlayerModule
{
	public class PlayerEntityBase : IDisposable
	{
		private bool awake_;

		private UnityEvent unityEvent_;

		public PlayerEntityBase(bool permanent)
		{
			unityEvent_ = SingletonManager.Get<UnityEvent>(permanent ? 1 : 2);
			unityEvent_.Subscribe(UnityEventType.Update, UpdateIfAwake);
			awake_ = true;
		}

		public virtual void Dispose()
		{
			unityEvent_.Unsubscribe(UnityEventType.Update, UpdateIfAwake);
		}

		public virtual void Update()
		{
		}

		private void UpdateIfAwake()
		{
			if (awake_)
			{
				Update();
			}
		}
	}
}
