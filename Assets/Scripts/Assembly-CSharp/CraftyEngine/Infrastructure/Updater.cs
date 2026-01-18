using System;
using Extensions;

namespace CraftyEngine.Infrastructure
{
	public class Updater : IDisposable, IUpdate
	{
		private UnityEvent unityEvent;

		public event Action Updated;

		public Updater()
		{
			SingletonManager.Get<UnityEvent>(out unityEvent);
			unityEvent.Subscribe(UnityEventType.Update, Update);
		}

		private void Update()
		{
			this.Updated.SafeInvoke();
		}

		public void Dispose()
		{
			unityEvent.Unsubscribe(UnityEventType.Update, Update);
		}
	}
}
