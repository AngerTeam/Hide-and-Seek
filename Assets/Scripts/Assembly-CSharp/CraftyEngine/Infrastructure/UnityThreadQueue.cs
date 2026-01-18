namespace CraftyEngine.Infrastructure
{
	public class UnityThreadQueue : TaskQueue
	{
		private UnityEvent unityEvent_;

		public UnityThreadQueue()
		{
			if (SingletonManager.TryGet<UnityEvent>(out unityEvent_))
			{
				unityEvent_.Subscribe(UnityEventType.Update, UnityUpdate);
			}
			else
			{
				Log.Error("Unable to get UnityEvent");
			}
		}

		public override void Dispose()
		{
			if (unityEvent_ != null)
			{
				unityEvent_.Unsubscribe(UnityEventType.Update, UnityUpdate);
			}
			base.Dispose();
		}

		private void UnityUpdate()
		{
			Update();
		}
	}
}
