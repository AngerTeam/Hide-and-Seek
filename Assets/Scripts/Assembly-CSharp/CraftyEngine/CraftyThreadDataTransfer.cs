using CraftyEngine.Infrastructure;

namespace CraftyEngine
{
	public class CraftyThreadDataTransfer<T> : ThreadDataTransfer<T>
	{
		private UnityEvent unityEvent_;

		public CraftyThreadDataTransfer(bool processInUnity, bool permanent)
			: base(processInUnity)
		{
			if (processInUnity)
			{
				unityEvent_ = SingletonManager.Get<UnityEvent>(permanent ? 1 : 2);
				unityEvent_.Subscribe(UnityEventType.Update, base.Update);
			}
		}

		public override void Dispose()
		{
			base.Dispose();
			if (unityEvent_ != null)
			{
				unityEvent_.Unsubscribe(UnityEventType.Update, base.Update);
			}
		}
	}
}
