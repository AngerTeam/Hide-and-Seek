using System.Collections.Generic;

namespace CraftyEngine.Infrastructure.SingletonManagerCore
{
	public class SingletonAsyncPass
	{
		private class Data
		{
			public SingletonPhase phase;

			public SingletonMetaData meta;
		}

		public static bool async;

		private static Queue<Data> actions_ = new Queue<Data>();

		public static void Update()
		{
			if (async && actions_.Count > 0)
			{
				Data data = actions_.Dequeue();
				Log.Info("Execute {0} on {1}", data.phase, data.meta.debugName);
				Execute(data.phase, data.meta);
			}
		}

		public static void Perform(SingletonPhase phase, SingletonMetaData meta)
		{
			if (async && meta.holder.Layer == 2)
			{
				actions_.Enqueue(new Data
				{
					phase = phase,
					meta = meta
				});
			}
			else
			{
				Execute(phase, meta);
			}
		}

		private static void Execute(SingletonPhase phase, SingletonMetaData meta)
		{
			if (phase != SingletonPhase.Sync && phase != SingletonPhase.Reset)
			{
				meta.performedPhases[phase] = true;
			}
			switch (phase)
			{
			case SingletonPhase.Init:
				meta.holder.Init();
				break;
			case SingletonPhase.DataLoaded:
				meta.holder.OnDataLoaded();
				break;
			case SingletonPhase.Sync:
				meta.holder.OnSyncRecieved();
				break;
			case SingletonPhase.LogicLoaded:
				meta.holder.OnLogicLoaded();
				break;
			case SingletonPhase.Reset:
				meta.holder.OnReset();
				break;
			case SingletonPhase.ThreadStop:
				break;
			}
		}
	}
}
