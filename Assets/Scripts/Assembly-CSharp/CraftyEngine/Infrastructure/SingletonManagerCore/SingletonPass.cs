using System;
using System.Collections.Generic;

namespace CraftyEngine.Infrastructure.SingletonManagerCore
{
	public class SingletonPass
	{
		private static Queue<SingletonPass> queue_;

		private static bool syncLock_;

		private SingletonPhase phase;

		private Singletons singletons;

		private bool debug;

		private long from;

		public SingletonPass(SingletonPhase phase, Singletons singletons, bool debug = false)
		{
			if (queue_ == null)
			{
				queue_ = new Queue<SingletonPass>();
			}
			this.phase = phase;
			this.singletons = singletons;
		}

		public static void Perfom(SingletonPhase phase, Singletons singletons, bool debug = false)
		{
			SingletonPass singletonPass = new SingletonPass(phase, singletons, true);
			singletonPass.debug = debug;
			singletonPass.Perfom();
		}

		public bool Perfom()
		{
			if (syncLock_)
			{
				queue_.Enqueue(this);
				return false;
			}
			syncLock_ = true;
			try
			{
				foreach (SingletonMetaData uniqueSingleton in singletons.uniqueSingletons)
				{
					try
					{
						if (uniqueSingleton.performedPhases.ContainsKey(phase))
						{
							continue;
						}
						if (debug)
						{
							if (uniqueSingleton.executionTime == null)
							{
								uniqueSingleton.executionTime = new Dictionary<SingletonPhase, float>();
							}
							from = DateTime.Now.Ticks;
						}
						SingletonAsyncPass.Perform(phase, uniqueSingleton);
						if (debug)
						{
							long ticks = DateTime.Now.Ticks;
							long num = ticks - from;
							uniqueSingleton.executionTime[phase] = num;
							uniqueSingleton.totalExecutionTime += num;
						}
					}
					catch (Exception exc)
					{
						Log.Error("Failed to {1} singletion {0}", uniqueSingleton.debugName, phase);
						Log.Exception(exc);
					}
				}
			}
			catch (Exception exc2)
			{
				Log.Error("Singletons \"{0}\" pass failed. You are probably trying to create more singletons.\nAll singletons must be created before Build pass!", phase);
				Log.Exception(exc2);
			}
			syncLock_ = false;
			if (queue_.Count > 0)
			{
				queue_.Dequeue().Perfom();
			}
			return true;
		}
	}
}
