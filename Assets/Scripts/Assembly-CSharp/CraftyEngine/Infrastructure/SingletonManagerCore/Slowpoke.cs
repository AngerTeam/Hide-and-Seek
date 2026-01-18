namespace CraftyEngine.Infrastructure.SingletonManagerCore
{
	public class Slowpoke : Singleton
	{
		public Slowpoke()
		{
			if (CompileConstants.CONTENT_IS_TEST)
			{
				SingletonManager.debug = true;
			}
		}

		public override void OnDataLoaded()
		{
			QueueManager queueManager = SingletonManager.Get<QueueManager>();
			queueManager.AddTask(delegate
			{
				SingletonManager.InitiatePhase(SingletonPhase.LogicLoaded);
			});
		}

		public override void OnLogicLoaded()
		{
			Log.Info(SingletonManagerDebug.GetDebugInfo());
		}
	}
}
