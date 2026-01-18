using System;
using System.Collections.Generic;

namespace CraftyEngine.Infrastructure.SingletonManagerCore
{
	public class SingletonMetaData : IEquatable<SingletonMetaData>
	{
		public string debugName;

		public Singleton holder;

		public Dictionary<SingletonPhase, bool> performedPhases;

		public Dictionary<SingletonPhase, float> executionTime;

		public long totalExecutionTime;

		public bool debugView;

		public SingletonMetaData(ISingleton holder)
		{
			this.holder = (Singleton)holder;
		}

		public bool Equals(SingletonMetaData other)
		{
			return holder == other.holder;
		}

		internal void Init()
		{
			debugName = holder.GetType().Name;
			performedPhases = new Dictionary<SingletonPhase, bool>();
		}

		public override string ToString()
		{
			return debugName;
		}
	}
}
